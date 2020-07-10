# ilx-zlib
This is an F5 iRules-LX Plugin that will decode a SAML message into raw XML.

Two ILX methods are provided by this plugin:
 * decodeRAW(string RawSamlRequest)
 * b64decodeInflate(string URLDECODED_SamlRequest)
 
Both methods will return the Raw unformatted XML of the SAML Message.

## Installation
Download the desired build from the builds folder, and copy it to the /var/tmp folder on the target BigIP.
From the BASH command line interface on the target BigIP:
    tmsh create ilx workspace ilx-zlib
    cd /var/ilx/workspaces/ilx-zlib
    tar -zxvf /var/tmp/ilz-zlib-0.3.tar.gz
    tmsh create ilx plugin ilx-zlib_plugin from-workspace ilx-zlib
