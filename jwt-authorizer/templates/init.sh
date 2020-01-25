#!/bin/bash

b64="base64 -w0"
uname | grep -i darwin > /dev/null
is_darwin_rc=$?

if [[ $is_darwin_rc -eq 0 ]]; then
    b64="base64"
fi

echo "Hostname:"
read HOSTNAME

echo "Kubernetes Namespace:"
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

echo "...done"
ISSUER_PRIVATE_KEY=$(cat private.pem)
ISSUER_PRIVATE_KEY_INDENT=$(printf -- "$ISSUER_PRIVATE_KEY")
JWKS_N=$modulus_urlsafe_b64

echo "generate secret for flask"
AUTHORIZER_FLASK_SECRET=$(dd if=/dev/urandom bs=32 count=1 2> /dev/null | $b64)
echo "...done"

mv public.pem ${NAMESPACE}-public.pem
mv private.pem ${NAMESPACE}-private.pem
echo -n $AUTHORIZER_FLASK_SECRET > ${NAMESPACE}-flask_secret.txt
echo -n $OAUTH2_PROXY_COOKIE_SECRET > ${NAMESPACE}-oauth2-proxy-cookie-secret.txt
echo -n $OAUTH2_PROXY_CLIENT_SECRET > ${NAMESPACE}-oauth2-proxy-client-secret.txt

cat <<EOF > ${NAMESPACE}-values.yml
secrets:
  enabled: False
  flask_secret: "" # See: ${NAMESPACE}-flask_secret.txt
  oauth2_proxy_cookie_secret: "" # See: ${NAMESPACE}-oauth2-proxy-cookie-secret.txt
  oauth2_proxy_client_secret: "" # See: ${NAMESPACE}-oauth2-proxy-client-secret.txt
  signing_key: "" # See: ${NAMESPACE}-private.pem

host: ${HOSTNAME}
vault_secrets:
  enabled: True
  path: "secret/k8s_operator/${HOSTNAME}/jwt_authorizer"

jwks_n: ${JWKS_N}
oauth2_proxy_client_id: ${OAUTH2_PROXY_CLIENT_ID}
user_capability: "exec:user"
admin_capability: "exec:admin"

oauth2_proxy:
  image: "lsstdm/oauth2_proxy:stable"
  issuer_url: https://cilogon.org
  login_url: https://cilogon.org/authorize/?skin=LSST
  jwks_url: https://cilogon.org/oauth2/certs
  redeem_url: https://cilogon.org/oauth2/token

jwt_authorizer:
  image: "lsstdm/jwt_authorizer:stable"

  known_capabilities:
    exec:portal: Use the Portal to execute operations. Mostly used from notebook APIs.
    read:image: Read images from the SODA and other image retrieval interfaces
    read:image/metadata: Read image metadata from SIA and other image interfaces
    read:tap: Execute SELECT queries in the TAP interface on project datasets
    read:tap/efd: Execute SELECT queries in the TAP interface on EFD datasets
    read:tap/user: Execute SELECT queries in the TAP interface on your data
    write:tap/user: Upload tables to your database workspace
    read:tap/history: Read the history of your TAP queries.
    read:workspace: Read project datasets from the file workspace
    read:workspace/user: Read the data in your file workspace
    write:workspace/user: Write data to your file workspace

  group_mapping:
    exec:admin: ["lsst_int_lsp_admin"]
    exec:user: ["lsst_int_lspdev"]
    read:workspace: ["lsst_int_lspdev"]
    read:workspace/user: ["lsst_int_lspdev"]
    write:workspace/user: ["lsst_int_lspdev"]
    exec:portal: ["lsst_int_lspdev"]
    exec:notebook: ["lsst_int_lspdev"]
    read:tap: ["lsst_int_lspdev"]
    read:image: ["lsst_int_lspdev"]

EOF

cat <<EOF 
If you are not using vault, enable secrets.enabled, and insert secrets
into ${NAMESPACE}-values.yaml.

If you are using vault, load the secrets:

export VAULT_ADDR=...
export VAULT_TOKEN=...
vault kv put "secret/k8s_operator/${HOSTNAME}/jwt_authorizer" \\
    flask_secret.txt=@${NAMESPACE}-flask-secret.txt \\
    signing_key.pem=@${NAMESPACE}-private.pem \\
    oauth2-proxy-cookie-secret.txt=@${NAMESPACE}-oauth2-proxy-cookie-secret.txt \\
    oauth2-proxy-client-secret.txt=@${NAMESPACE}-oauth2-proxy-client-secret.txt

# Finally, remove secrets
rm \\
    ${NAMESPACE}-flask_secret.txt \\
    ${NAMESPACE}-private.pem \\
    ${NAMESPACE}-oauth2-proxy-cookie-secret.txt \\
    ${NAMESPACE}-oauth2-proxy-client-secret.txt
EOF
