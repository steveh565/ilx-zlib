# ilx-zlib
This is an F5 iRules-LX Plugin that will decode a SAML message into raw XML.

Two ILX methods are provided by this plugin:
 * decodeRAW(string RawSamlRequest)
 * b64decodeInflate(string URLDECODED_SamlRequest)
 
Both methods will return the Raw unformatted XML of the SAML Message.
