#!/bin/bash

cat <<EOF
This script will help generate secrets for a Helm values file.

EOF

b64="base64 -w0"
uname | grep -i darwin > /dev/null
is_darwin_rc=$?

if [[ $is_darwin_rc -eq 0 ]]; then
    b64="base64"
fi

echo "Hostname:"
read HOSTNAME

echo "Kubernetes Namespace (prefixes for generated files):"
read NAMESPACE

echo "CILogon client ID for hostname (for callback https://$HOSTNAME/oauth2/callback):"
read OAUTH2_PROXY_CLIENT_ID

echo "CILogon Client Secret:"
read OAUTH2_PROXY_CLIENT_SECRET

OAUTH2_PROXY_CLIENT_SECRET_B64=$(printf -- "$OAUTH2_PROXY_CLIENT_SECRET" | $b64)

OAUTH2_PROXY_COOKIE_SECRET=$(dd if=/dev/urandom bs=32 count=1 2> /dev/null | $b64 | sed 's/+/-/g;s/\//_/g')
OAUTH2_PROXY_COOKIE_SECRET_B64=$(printf -- "$OAUTH2_PROXY_COOKIE_SECRET" | $b64)

echo "Generating Issuer Keypair... private.pem, public.pem"
openssl genrsa -out private.pem 2048 2> /dev/null
openssl rsa -in private.pem -outform PEM -pubout -out public.pem
modulus_hex=$(openssl rsa -pubin -inform PEM -modulus -noout -in public.pem | sed 's/Modulus=//')
modulus_urlsafe_b64=$(printf -- "$modulus_hex" | xxd -r -p | $b64 | sed 's/+/-/g;s/\//_/g;s/=//g')

ISSUER_PRIVATE_KEY=$(cat private.pem)
ISSUER_PRIVATE_KEY_INDENT=$(printf -- "$ISSUER_PRIVATE_KEY")
JWKS_N=$modulus_urlsafe_b64

AUTHORIZER_FLASK_SECRET=$(dd if=/dev/urandom bs=32 count=1 2> /dev/null | $b64)

cat <<EOF
Writing Files:
${NAMESPACE}-private.pem
${NAMESPACE}-flask_secret.txt
${NAMESPACE}-oauth2-proxy-cookie-secret.txt
${NAMESPACE}-oauth2-proxy-client-secret.txt
EOF

rm public.pem
mv private.pem ${NAMESPACE}-private.pem
echo -n $AUTHORIZER_FLASK_SECRET > ${NAMESPACE}-flask_secret.txt
echo -n $OAUTH2_PROXY_COOKIE_SECRET > ${NAMESPACE}-oauth2-proxy-cookie-secret.txt
echo -n $OAUTH2_PROXY_CLIENT_SECRET > ${NAMESPACE}-oauth2-proxy-client-secret.txt

cat <<EOF
You may initialize and modify your values file as follows:

# If you are not using vault, edit the secrets section:
secrets:
  enabled: True
  flask_secret: "" # See: ${NAMESPACE}-flask_secret.txt
  oauth2_proxy_cookie_secret: "" # See: ${NAMESPACE}-oauth2-proxy-cookie-secret.txt
  oauth2_proxy_client_secret: "" # See: ${NAMESPACE}-oauth2-proxy-client-secret.txt
  signing_key: "" # See: ${NAMESPACE}-private.pem

# Otherwise, edit the vault_secrets as follows:
vault_secrets:
  enabled: True
  path: "secret/k8s_operator/${HOSTNAME}/jwt_authorizer"

* Make sure to also edit the following:
host: ${HOSTNAME}
jwks_n: ${JWKS_N}
oauth2_proxy_client_id: ${OAUTH2_PROXY_CLIENT_ID}

* If you are using vault, load the secrets, (and remove them after)

# export VAULT_ADDR=...
# export VAULT_TOKEN=...
vault kv put "secret/k8s_operator/${HOSTNAME}/jwt_authorizer" \\
    flask_secret.txt=@${NAMESPACE}-flask-secret.txt \\
    signing_key.pem=@${NAMESPACE}-private.pem \\
    oauth2-proxy-cookie-secret.txt=@${NAMESPACE}-oauth2-proxy-cookie-secret.txt \\
    oauth2-proxy-client-secret.txt=@${NAMESPACE}-oauth2-proxy-client-secret.txt

rm \\
    ${NAMESPACE}-flask_secret.txt \\
    ${NAMESPACE}-private.pem \\
    ${NAMESPACE}-oauth2-proxy-cookie-secret.txt \\
    ${NAMESPACE}-oauth2-proxy-client-secret.txt

EOF
