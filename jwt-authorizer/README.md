# Pre-Deployment for LSP

## Prerequisites
This process assumes your ingress for the hostname has already been set up.
We do not rely on tls secrets for any deployments under that assumptions

### Getting Client Information

If you do not have a client as secret, you first need to obtain one from CILogon OAuth2 Client ID and secret.

Go here:
https://cilogon.org/oauth2/register

1. Add Client Name, e.g. "LSST LSP <instance> SSO"
2. Contact Email
3. Add hostname for Home URL
   - `https://lsst-lsp-instance.example.com`
4. Add callback URL for oauth2_proxy
   - `https://lsst-lsp-instance.example.com/oauth2/callback`
5. This is a private client

6. Select Scopes:

* email
* profile
* org.cilogon.userinfo

7. Refresh Token Lifetime - 24 hours
   - This is not really necessary, we can probably get by without refresh token

Save that information.
This is your client id and client secret.

# After submission

A separate email is required to help@cilogon.org to apply the client configuration
from the client `cilogon:/client_id/6ca7b54ac075b65bccb9c885f9ba4a75` to your new
client. Include your new client id with the email.

## Configuring Applications to use the authorizer
There is a bootstrap.sh script to help bootstrap secrets and values for a helm values file.
