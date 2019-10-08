when RULE_INIT {
    log local0. "ILX-TEST: in RULE_INIT"
}

when CLIENT_ACCEPTED {
    log local0. "ILX-TEST: in CLIENT_ACCEPTED"
}

when HTTP_REQUEST {
    log local0. "ILX-TEST: in HTTP_REQUEST"
      
    log local0. "ILX-PLUGIN: ZLIB self initialization test..."
    set handle [ILX::init "zlib_plugin" "zlib"]
    set myData "fZJbc6owFIX/CpN3roIXptgB0XpDUdEWXxjEqLGQQBJB/fWltT3T89I9k4fM3mvtNcn39HzNUqGElCGCLaBKChAgTsge4aMF1sFAbIPn7hOLszQ37Qs/4SUsLpBxodZhZn41LHCh2CQxQ8zEcQaZyRNzZXtTU5MUM6eEk4SkQLAZg5TXi3oEs0sG6QrSEiVwvZxa4MR5zkxZPhhSdpNYnEJ2IDSBUkKyZ0YsRXGV7zq9FSUQ3DoFwjH/Cv5PDfeQxhxKtU0tlD/zyWify3WKA0qhTOEeUZhwQnPCuMwYAcLItUCk9ey6XnVIhyjx+u3K2ywqz7U/j7K4p85nu2Hfw3Pysm65xXlA+tGNzNBZnb3Y57vYiI7baYN5xhKNmn5YGsp4LIa9963XPM7veuwUjaqF1NRxhroe541yt7SP516rP1GV9/L9Ol9jN6BTNx+phXjL27sZC4qLph0WvGp7HV2NqkOkN/txdU1vebG6tK+jZPma+TnvRJuRh3VHCZsVWpRkoG7fDngwx8Y4hLM5mk/Gi+2pKjv+PXI2UxZR2ii9ZDHKwnCHvdiZ+JvOcGXQgvhZXlauiq66P0mW7mY88RZkos4aha4aw8iuX4uxCxxhxmPMLaApakdUFVHRAk01jZapdaROs70Fgv/97w7CD5r+gmT3GGLmMAh80Z+vAiBsfqisB8CDQfNrOf0F39+28Q9xoPsXX0/yL/Pu4/Y/7t0P"
    set result [ILX::call $handle "b64decode_and_unzip" $myData]
    set unzipdata [lindex $result 1]
    log local0. "ILX-PLUGIN: ZLIB test 1 result: Input: $myData; Output: $unzipdata"

    #set unzipdata 
    if { [catch {ILX::call $handle "b64decode_and_unzip" $myData} result] } {
        log local0. "Whoops! ILX-PLUGIN: ZLIB unexpected error calling method b64decode_and_unzip"
    }
    if { [lindex $result 0] } {
        set unzipdata [lindex $result 1]
        log local0. "Base64 Decoded and inflated: $unzipdata"
    } else {
        log local0. "Error: ILX-PLUGIN: ZLIB initialization failed!"
    }
     
}