_ = require './underscore'

exports["+"] = (args...) -> _.reduce(args, (total, val) -> total + val)
exports["-"] = (args...) -> _.reduce(args, (total, val) -> total - val)
exports["*"] = (args...) -> _.reduce(args, (total, val) -> total * val)
exports["/"] = (args...) -> _.reduce(args, (total, val) -> total / val)
