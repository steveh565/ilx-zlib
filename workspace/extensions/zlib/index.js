// Import the f5-nodejs module.
var f5 = require('f5-nodejs');

// Import ZLib module for inflate/deflate
var zlib = require('zlib');

// Create a new rpc server for listening to TCL iRule calls.
var ilx = new f5.ILXServer();

ilx.addMethod('b64decode_and_inflate', function(req, res) {
    try {
        //try to unzip the payload
        var inflate = zlib.inflate(new Buffer(req.params()[0], 'base64')).toString();
    } catch (err) {
        //gracefully handle our errors ane return resErr (1) because I was told do to that...
        console.error('Error: ', err.message);
        return res.reply(1);
    }
    //return 0 (success) and unzip'd content
    res.reply([0, inflate]);
});

ilx.addMethod('b64decode_and_unzip', function(req, res) {
    try {
        //try to unzip the payload
        var inflate = zlib.unzip(new Buffer(req.params()[0], 'base64')).toString();
    } catch (err) {
        //gracefully handle our errors ane return resErr (1) because I was told do to that...
        console.error('Error: ', err.message);
        return res.reply(1);
    }
    //return 0 (success) and unzip'd content
    res.reply([0, unzip]);
});


//listen for RPC calls from TCL iRules
ilx.listen();
