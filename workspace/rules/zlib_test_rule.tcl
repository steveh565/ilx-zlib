when CLIENT_ACCEPTED {
    log local0. "ILX-PLUGIN: ZLIB self initialization test..."
    set handle [ILX::init "zlib_plugin" "zlib"]
    set myData "fZJbc6owFIX/CpN3roIXptgB0XpDUdEWXxjEqLGQQBJB/fWltT3T89I9k4fM3mvtNcn39HzNUqGElCGCLaBKChAgTsge4aMF1sFAbIPn7hOLszQ37Qs/4SUsLpBxodZhZn41LHCh2CQxQ8zEcQaZyRNzZXtTU5MUM6eEk4SkQLAZg5TXi3oEs0sG6QrSEiVwvZxa4MR5zkxZPhhSdpNYnEJ2IDSBUkKyZ0YsRXGV7zq9FSUQ3DoFwjH/Cv5PDfeQxhxKtU0tlD/zyWify3WKA0qhTOEeUZhwQnPCuMwYAcLItUCk9ey6XnVIhyjx+u3K2ywqz7U/j7K4p85nu2Hfw3Pysm65xXlA+tGNzNBZnb3Y57vYiI7baYN5xhKNmn5YGsp4LIa9963XPM7veuwUjaqF1NRxhroe541yt7SP516rP1GV9/L9Ol9jN6BTNx+phXjL27sZC4qLph0WvGp7HV2NqkOkN/txdU1vebG6tK+jZPma+TnvRJuRh3VHCZsVWpRkoG7fDngwx8Y4hLM5mk/Gi+2pKjv+PXI2UxZR2ii9ZDHKwnCHvdiZ+JvOcGXQgvhZXlauiq66P0mW7mY88RZkos4aha4aw8iuX4uxCxxhxmPMLaApakdUFVHRAk01jZapdaROs70Fgv/97w7CD5r+gmT3GGLmMAh80Z+vAiBsfqisB8CDQfNrOf0F39+28Q9xoPsXX0/yL/Pu4/Y/7t0P"
    set unzipdata [ILX::call $handle "b64decodeInflate" $myData]
    if { [catch {ILX::call $handle "b64decodeInflate" $myData} result] } {
        log local0. "Whoops! ILX-PLUGIN: ZLIB unexpected error calling method b64decodeInflate"
    }
    if { [lindex $result 0] } {
        set unzipdata [lindex $result 1]
        log local0. "Encoded Data: $myData"
        log local0. "Base64 Decoded and inflated: $unzipdata"
    } else {
        log local0. "Error: ILX-PLUGIN: ZLIB initialization failed!"
    }
    
    #set xmldata "<?xml version=\"1.0\" encoding=\"UTF-8\"?><samlp:AuthnRequest xmlns:samlp=\"urn:oasis:names:tc:SAML:2.0:protocol\" AssertionConsumerServiceURL=\"https://f5.my.salesforce.com?so=00D00000000hXqv\" Destination=\"https://federate.f5.com/saml/idp/profile/redirectorpost/sso\" ID=\"_2CAAAAW4erHicME8wMVQwMDAwMDA0QzlBAAAA3AzYjcGU7DqjFoE_yoNij1NGAjz-3_gZL3sM5RiI6PYv50JJ-YCkZM6gOz4aBq3w7i1lBBH44ap3vbRAgjC7EK10kvkxOUnDTrLDpI1q-yp8bNsTqu22fQtw8M941_wf_46EawxlypqSu8xIcRWmPpt9_VIMn4B0Y6wiQvoF1ZXfnFOn5JYeNOiOKJQZhwv9Pz_BVLs_rr3vMcQImYYbnMaBKPV9HS5rqoPmpvwD1ix4PKcRDVJKMQoK1N3q415H_A\" IssueInstant=\"2019-10-02T21:57:29.968Z\" ProtocolBinding=\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST\" Version=\"2.0\"><saml:Issuer xmlns:saml=\"urn:oasis:names:tc:SAML:2.0:assertion\">https://f5.my.salesforce.com</saml:Issuer></samlp:AuthnRequest>"
}

