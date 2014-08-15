var Hapi = require('hapi');
var dotenv = require('dotenv');

dotenv.load();

module.exports = function() {
  var manifest = {
    servers: [
      {
        port: process.env.PORT,
        options: {
          debug: {
            request: ['error', 'log', 'request']
          }
        }
      }
    ],

    plugins: {
      'launchpad-gh': {
        token: process.env.GIT_HUB_TOKEN,
        uri: 'https://api.github.com',
        organization: 'asm-products'
      },
      // 'launchpad-heroku': {
      //   token: process.env.HEROKU_TOKEN || config.HEROKU_TOKEN
      // }
    }
  };

  Hapi.Pack.compose(manifest, function composeCallback(err, pack) {
    if (err) {
      throw err;
    }

    pack.start();

    console.log('Launchpad listening at ' + pack._servers[0].info.uri);
  });
};
