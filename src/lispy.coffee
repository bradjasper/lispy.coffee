# Lispy inspired Javascript Lisp written in CoffeeScript

globals = require('./globals')
stdlib = require('./stdlib')

env = stdlib

Symbol = String

# Create spaces where necessary then chop up the parts
tokenize = (s) ->
    # Replace brackets, reduce to single spacing, trim edges
    # This could probably be done a lot more efficiently
    s.replace(/\(/g, ' ( ') \
     .replace(/\)/g, ' ) ') \
     .replace(/\s+/g, ' ')  \
     .replace(/^\s*/, '')   \
     .replace(/\s*$/, '')   \
     .split(' ')

# Create an atom (Number, Symbol)
atom = (token) ->
    return Number(token) if not isNaN(Number(token))
    return Symbol(token)

# Convert from tokens into expression tree
read_from = (tokens) ->
    throw "SyntaxError: Unexpected EOF" if tokens.length is 0

    token = tokens.shift()
    switch token
        when ')' then throw 'SyntaxError'
        when '('
            list = []
            list.push(read_from(tokens)) while tokens[0] isnt ')'
            tokens.shift()
            return list
        else return atom(token)

# Convert from input code to output code
parse = (s) -> read_from(tokenize(s))

# Evaluate an expression like ['+', 20, 20]
evaluate = (expr) ->

    return env[expr] if expr of env                         # Symbol
    return eval(expr) if expr not instanceof Array          # Constant

    switch expr[0]
        when 'quote' then return to_string(expr[1...][0])   # (quote expr)
        when 'if'                                           # (if test conseq alt)
            [_, test, conseq, alt] = expr
            return conseq if evaluate(test) is true
            return alt
        when 'define'
            [_, name, expression] = expr
            env[name] = evaluate(expression)
            return env[name]

    # Handle expression
    exps = (evaluate(x) for x in expr)
    proc = exps.shift()
    return proc(exps...)

# Convert a parsed expression back to a lisp statement
#   ie. ['+', 20, 20] -> (+ 20 20)
to_string = (expr) ->
    if expr instanceof Array
        return '(' + expr.map(to_string).join(' ') + ')'
    return String(expr)

# Exports
exports.eval = (code) -> evaluate(parse(code))
