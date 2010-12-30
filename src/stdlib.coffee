_ = require './underscore'

sum = (args...) -> _.reduce(args, (total, val) -> total + val)
minus = (args...) -> _.reduce(args, (total, val) -> total - val)
multiply = (args...) -> _.reduce(args, (total, val) -> total * val)
divide = (args...) -> _.reduce(args, (total, val) -> total / val)

# Greater than and less than
gt = (args...) -> _.reduce(args, (total, val) -> total > val)
lt = (args...) -> _.reduce(args, (total, val) -> total < val)
equal = (args...) ->
    val = args[0]
    for arg in args
        return no if arg isnt val
    return yes


exports.sum = sum
exports.minus = minus
exports.multiply = multiply
exports.divide = divide
exports.gt = gt
exports.lt = lt
exports["equal?"] = equal

# Add symbols
exports["+"] = sum
exports["-"] = minus
exports["*"] = multiply
exports["/"] = divide
exports[">"] = gt
exports["<"] = lt
exports["="] = equal
