// Import the f5-nodejs module.
var f5 = require('f5-nodejs');

// Import ZLib module for inflate/deflate
var zlib = require('zlib');

// Create a new rpc server for listening to TCL iRule calls.
var ilx = new f5.ILXServer();

//function to decode encoded URLs
function isEncoded (url) {
    url = url || '';
    return url !== decodeURIComponent(url);
  };

//function to decode URI components
function cleanURI (uri) {
    while (isEncoded(uri)) {
      uri = decodeURIComponent(uri);
    }
    return uri;
  };

//function to inflate compressed content
function inflateClean (samlResponse) {
    if (samlResponse.includes('samlp:Response')) {
      return samlResponse.toString('utf8');
    } else {
      var tmp = zlib.inflateRawSync(samlResponse).toString('utf8');
      return tmp;
    }
  };

//de-URL-encode, base64decode, inflate RAW SAML AuthN Request
ilx.addMethod('decodeRAW', function(req, res) {
    try {
        var rawData = req.params()[0];
        var URLDecodedAssertion = cleanURI(rawData);
        var B64Assertion = Buffer.from(URLDecodedAssertion, 'base64');
        var rawAssertion = inflateClean(B64Assertion);
        var xml = rawAssertion.toString('utf8').trim();
        //console.log(xml);
    } catch (err) {
        //gracefully handle our errors ane return 0 (false==fail) because I was told do to that...
        console.error('Error: ', err.message);
        return res.reply(0);
    }
    //return 1 (true==success) and unzip'd content
    res.reply([1, xml]);
});

//base64decode, inflate RAW SAML AuthN Request
ilx.addMethod('b64decodeInflate', function(req, res) {
    try {
        var URLDecodedAssertion = req.params()[0];
        var B64Assertion = Buffer.from(URLDecodedAssertion, 'base64');
        var rawAssertion = inflateClean(B64Assertion);
        var xml = rawAssertion.toString('utf8').trim();
    } catch (err) {
        //gracefully handle our errors ane return resErr (0) because I was told do to that...
        console.error('Error: ', err.message);
        return res.reply(0);
    }
    //return 1 (success) and unzip'd content
    res.reply([1, unzip]);
});


//listen for RPC calls from TCL iRules
ilx.listen();
