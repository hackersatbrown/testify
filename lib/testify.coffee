_ = require "underscore"
restify = require "restify"
should = require "should"

module.exports =

  createJsonClient: (opts, auth) ->
    client = restify.createJsonClient _.extend(
      url: "http://localhost:8080"
    , opts)
    if auth?
      _.defaults auth, { username: "", password: "" }
      client.basicAuth auth.username, auth.password
    client

  shouldNotErr: (handler, status = 200) ->
    (err, req, res, data) ->
      res.should.have.status status
      should.not.exist err
      handler req, res, data

  shouldErr: (done, status) ->
    (err) ->
      should.exist err
      if status? then err.should.have.status status 
      done()
