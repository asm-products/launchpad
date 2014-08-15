var Hapi = require('hapi');
var Lab = require('lab');
var Sinon = require('sinon');
var lab = exports.lab = Lab.script();

var describe = lab.describe;
var it = lab.it;
var before = lab.before;
var after = lab.after;
var expect = Lab.expect;

describe('index', function() {
  var index = require('../../api');

  it('starts', function(done) {
    var spy = Sinon.spy(Hapi.Pack, 'compose');

    index();

    expect(spy.calledOnce).to.be.true;

    Hapi.Pack.compose.restore();

    done();
  });

  it('catches errors', function(done) {
    var error = new Error('compose() error');
    Sinon.stub(Hapi.Pack, 'compose', function(manifest, callback) {
      callback(error);
    });

    expect(index.bind(index, null)).to.throw(error);

    Hapi.Pack.compose.restore();

    done();
  });
});
