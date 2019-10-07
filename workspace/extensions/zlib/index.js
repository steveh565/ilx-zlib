// Import the f5-nodejs module.
var f5 = require('f5-nodejs');

// Import ZLib module for inflate/deflate
var zlib = require('zlib');

// Create a new rpc server for listening to TCL iRule calls.
var ilx = new f5.ILXServer();

ilx.addMethod('b64decode_and_inflate', function(req, res) {
    var unzip = zlib.unzip(new Buffer(req.params()[0], 'base64')).toString();
    res.reply(unzip);
});

ilx.addMethod('b64decode_and_unzip', function(req, res) {
    var unzip = zlib.unzip(new Buffer(req.params()[0], 'base64')).toString();
    res.reply(unzip);
});

ilx.addMethod('deflate_and_b64encode', function(req, res) {
    var zip = zlib.deflate(new Buffer(req.params()[0])).toString('base64');
    res.reply(zip);
});

ilx.addMethod('zip_and_b64encode', function(req, res) {
    var zip = zlib.deflate(new Buffer(req.params()[0])).toString('base64');
    res.reply(zip);
});

//listen for RPC calls from TCL iRules
ilx.listen();
