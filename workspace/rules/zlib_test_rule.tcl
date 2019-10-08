when CLIENT_ACCEPTED {
    log local0. "ILX-PLUGIN: ZLIB self initialization test..."
    set handle [ILX::init "ilx-zlib_plugin" "ilx-zlib"]
    set myData "fZJbc6owFIX/CpN3roIXptgB0XpDUdEWXxjEqLGQQBJB/fWltT3T89I9k4fM3mvtNcn39HzNUqGElCGCLaBKChAgTsge4aMF1sFAbIPn7hOLszQ37Qs/4SUsLpBxodZhZn41LHCh2CQxQ8zEcQaZyRNzZXtTU5MUM6eEk4SkQLAZg5TXi3oEs0sG6QrSEiVwvZxa4MR5zkxZPhhSdpNYnEJ2IDSBUkKyZ0YsRXGV7zq9FSUQ3DoFwjH/Cv5PDfeQxhxKtU0tlD/zyWify3WKA0qhTOEeUZhwQnPCuMwYAcLItUCk9ey6XnVIhyjx+u3K2ywqz7U/j7K4p85nu2Hfw3Pysm65xXlA+tGNzNBZnb3Y57vYiI7baYN5xhKNmn5YGsp4LIa9963XPM7veuwUjaqF1NRxhroe541yt7SP516rP1GV9/L9Ol9jN6BTNx+phXjL27sZC4qLph0WvGp7HV2NqkOkN/txdU1vebG6tK+jZPma+TnvRJuRh3VHCZsVWpRkoG7fDngwx8Y4hLM5mk/Gi+2pKjv+PXI2UxZR2ii9ZDHKwnCHvdiZ+JvOcGXQgvhZXlauiq66P0mW7mY88RZkos4aha4aw8iuX4uxCxxhxmPMLaApakdUFVHRAk01jZapdaROs70Fgv/97w7CD5r+gmT3GGLmMAh80Z+vAiBsfqisB8CDQfNrOf0F39+28Q9xoPsXX0/yL/Pu4/Y/7t0P"
    log local0. "ILX-PLUGIN: ZLIB SAML AuthN Request: $myData"
    set unzipdata [lindex [ILX::call $handle "b64decodeInflate" $myData] 1]
    log local0. "ILX-PLUGIN: ZLIB Test 1> SAML AuthN Request (decoded): $unzipdata"
    if { [catch {ILX::call $handle "b64decodeInflate" $myData} result] } {
        log local0. "Whoops! ILX-PLUGIN: ZLIB unexpected error calling method b64decodeInflate"
    }
    if { [lindex $result 0] } {
        set unzipdata [lindex $result 1]
        log local0. "ILX-PLUGIN: ZLIB Test 2> SAML AuthN Request (decoded): $unzipdata"
        log local0. "ILX-PLUGIN: ZLIB initialization succeeded!"
    } else {
        log local0. "ILX-PLUGIN: ZLIB initialization failed!"
    }
}

