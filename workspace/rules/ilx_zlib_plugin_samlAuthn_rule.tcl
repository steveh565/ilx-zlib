when CLIENT_ACCEPTED {
    ACCESS::restrict_irule_events disable
    log local0. "DEBUG: SAML irule: Got connection..."
}

when HTTP_REQUEST {
    if { [HTTP::path] equals "/saml/idp/profile/redirectorpost/sso" } {
        if { [HTTP::method] equals "POST" } {
            log local0. "DEBUG: Got SAML AuthN POST"
            # Collect POST data
            set content_length [HTTP::header value Content-Length]
            HTTP::collect $content_length
        } elseif { [HTTP::method] equals "GET" } {
            log local0. "DEBUG: Got SAML AuthN GET"
            set query [HTTP::query]
            set payload_data [URI::decode $query]
            log local0. "DEBUG: RAW QUERY: $query"
            log local0. "DEBUG: URI query data: $payload_data"
            log local0. "DEBUG: SAMLRequest Parameter: [URI::query "?$payload_data" "SAMLRequest"]"
            if { $payload_data contains "SAMLRequest" } {
                # Extract SAML request data
                set samlRequest [URI::query "?$payload_data" "SAMLRequest"]
                #try this
                set SAMLdata [b64decode $samlRequest]
                if { $SAMLdata contains "saml" } {
                    # SAML Request was only b64 encoded - not deflated
                    log local0. "DEBUG: decoded SAMLdata: $SAMLdata"
                } else {
                    #b64decoded data is not ascii text - probably deflated
                    set handle [ILX::init "ilx-zlib_plugin" "ilx-zlib"]
                    set SAMLdata [lindex [ILX::call $handle "b64decodeInflate" $samlRequest] 1]
                    log local0. "DEBUG: decoded and inflated SAMLdata: $SAMLdata"
                }
                set SAML_Issuer_loc [string first "saml:issuer" [string tolower $SAMLdata]]
                set SAML_Issuer_start [expr {[string first ">" $SAMLdata $SAML_Issuer_loc] + 1}]
                set SAML_Issuer_end [expr {[string first "<" $SAMLdata $SAML_Issuer_start] - 1}]
                set SAML_Issuer [string range $SAMLdata $SAML_Issuer_start $SAML_Issuer_end]
                if { !([ACCESS::session sid] equals "" ) } {
                    ACCESS::session data set session.saml.request.issuer $SAML_Issuer
                }
                log local0. "SAML Issuer (HTTP_REQUEST)= $SAML_Issuer"
            }
        }
    }
}

when HTTP_REQUEST_DATA {
    set payload_data [URI::decode [HTTP::payload]]
    log local0. "DEBUG: payload=$payload_data" 
    if { $payload_data contains "SAMLRequest" } {
        # Extract SAML request data
        set samlRequest [URI::query "?$payload_data" "SAMLRequest"]
        #try this
        set SAMLdata [b64decode $samlRequest]
        if { $SAMLdata contains "saml" } {
            # SAML Request was only b64 encoded - not deflated
            log local0. "DEBUG: decoded SAMLdata: $SAMLdata"
        } else {
            #b64decoded data is not ascii text - probably deflated
            set handle [ILX::init "ilx-zlib_plugin" "ilx-zlib"]
            set SAMLdata [lindex [ILX::call $handle "b64decodeInflate" $samlRequest] 1]
            log local0. "DEBUG: decoded and inflated SAMLdata: $SAMLdata"
        }
        set SAML_Issuer_loc [string first "saml:issuer" [string tolower $SAMLdata]]
        set SAML_Issuer_start [expr {[string first ">" $SAMLdata $SAML_Issuer_loc] + 1}]
        set SAML_Issuer_end [expr {[string first "<" $SAMLdata $SAML_Issuer_start] - 1}]
        set SAML_Issuer [string range $SAMLdata $SAML_Issuer_start $SAML_Issuer_end]
        if { !([ACCESS::session sid] equals "" ) } {
            ACCESS::session data set session.saml.request.issuer $SAML_Issuer
        }
        log local0. "SAML Issuer (HTTP_REQUEST_DATA)= $SAML_Issuer"
    }
}

when ACCESS_SESSION_STARTED {
    if { [info exists SAML_Issuer] } {
        ACCESS::session data set session.saml.request.issuer $SAML_Issuer
        log local0. "SAML Issuer (ACCESS_SESSION_STARTED)= $SAML_Issuer"
    }
}
