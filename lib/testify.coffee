_ = require "underscore"
restify = require "restify"
should = require "should"

module.exports =

  createJsonClient: (opts, auth) ->
    client = restify.createJsonClient _.defaults(opts,
      url: "http://localhost:#{opts.port or 8080}"
    )
    if auth?
      auth = _.defaults auth, { username: "", password: "" }
      client.basicAuth auth.username, auth.password
    client

  shouldNotErr: (handler, status = 200) ->
    (err, req, res, data) ->
      res.should.have.status status
      should.not.exist err
      handler req, res, data

  shouldErr: (done, status) ->
    (err, req, res) ->
      should.exist err
      if status? then res.should.have.status status 
      done()
