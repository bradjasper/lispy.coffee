_ = require './underscore'

exports.sum = (args...) -> _.reduce(args, (total, val) -> total + val)
exports.subtract = (args...) -> _.reduce(args, (total, val) -> total - val)
exports.multiply = (args...) -> _.reduce(args, (total, val) -> total * val)
exports.divide = (args...) -> _.reduce(args, (total, val) -> total / val)
