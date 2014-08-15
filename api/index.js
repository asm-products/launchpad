var Hapi = require('hapi');

var manifest = {
  servers: [
    {
      port: process.env.PORT || 8080
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
    return console.error(err);
  }

  pack.start();

  console.log('Launchpad listening at ' + pack._servers[0].info.uri);
});
