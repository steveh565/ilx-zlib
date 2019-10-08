var zlib = require('zlib');

function isEncoded (url) {
    url = url || '';
    return url !== decodeURIComponent(url);
  };

function cleanURI (uri) {
    while (isEncoded(uri)) {
      uri = decodeURIComponent(uri);
    }
    return uri;
  };

function inflateClean (samlResponse) {
    if (samlResponse.includes('samlp:Response')) {
      return samlResponse.toString('utf8');
    } else {
      var tmp = zlib.inflateRawSync(samlResponse).toString('utf8');
      return tmp;
    }
  };

//Raw Base64 encoded SAML AuthN Request - URI Decoded
var myData = "fZJbc6owFIX/CpN3roIXptgB0XpDUdEWXxjEqLGQQBJB/fWltT3T89I9k4fM3mvtNcn39HzNUqGElCGCLaBKChAgTsge4aMF1sFAbIPn7hOLszQ37Qs/4SUsLpBxodZhZn41LHCh2CQxQ8zEcQaZyRNzZXtTU5MUM6eEk4SkQLAZg5TXi3oEs0sG6QrSEiVwvZxa4MR5zkxZPhhSdpNYnEJ2IDSBUkKyZ0YsRXGV7zq9FSUQ3DoFwjH/Cv5PDfeQxhxKtU0tlD/zyWify3WKA0qhTOEeUZhwQnPCuMwYAcLItUCk9ey6XnVIhyjx+u3K2ywqz7U/j7K4p85nu2Hfw3Pysm65xXlA+tGNzNBZnb3Y57vYiI7baYN5xhKNmn5YGsp4LIa9963XPM7veuwUjaqF1NRxhroe541yt7SP516rP1GV9/L9Ol9jN6BTNx+phXjL27sZC4qLph0WvGp7HV2NqkOkN/txdU1vebG6tK+jZPma+TnvRJuRh3VHCZsVWpRkoG7fDngwx8Y4hLM5mk/Gi+2pKjv+PXI2UxZR2ii9ZDHKwnCHvdiZ+JvOcGXQgvhZXlauiq66P0mW7mY88RZkos4aha4aw8iuX4uxCxxhxmPMLaApakdUFVHRAk01jZapdaROs70Fgv/97w7CD5r+gmT3GGLmMAh80Z+vAiBsfqisB8CDQfNrOf0F39+28Q9xoPsXX0/yL/Pu4/Y/7t0P";

//raw SAML AuthN request - URI Encoded
var rawData = "";
var URLDecodedAssertion = cleanURI(rawData);
var B64Assertion = Buffer.from(myData, 'base64');
var rawAssertion = inflateClean(B64Assertion);
var xml = rawAssertion.toString('utf8').trim();

console.log(xml);
