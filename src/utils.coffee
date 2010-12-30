_ = require('./underscore')

exports.createobj = (names, values) ->
    obj = new Object
    obj[pair[0]] = pair[1] for pair in _.zip(names, values)
    return obj
