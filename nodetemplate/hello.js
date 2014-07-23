var express=require("node_modules/express");
var logfmt = require("node_modules/logfmt");
var app=express();

/*app.use(logfmt.requestLogger());

app.get('/', function(req,res)  {

//res.send('Welcome to slipperyslope!');
express.static(__dirname + '/public');

});
*/

app.use('/', express.static(__dirname + '/public/freelancer'));

var port = Number(process.env.PORT || 5000);

app.listen(port,function() {

  console.log("Listening on "+port);


});
