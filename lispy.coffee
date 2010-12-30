# Lispy inspired Javascript Lisp written in CoffeeScript

globals = require('./globals')

env = globals

Symbol = String

# Create spaces where necessary then chop up the parts
tokenize = (s) -> s.replace(/\(/g, ' ( ').replace(/\)/g, ' ) ').split(' ')

# Create an atom (Number, Symbol)
atom = (token) ->
    return Number(token) if not isNaN(Number(token))
    return Symbol(token)

# Convert from tokens into expression tree
read_from = (tokens) ->
    raise "SyntaxError: Unexpected EOF" if tokens.length is 0

    token = tokens.shift()
    switch token
        when '' then return read_from(tokens)
        when ')' then raise 'SyntaxError'
        when '('
            list = []
            list.push(read_from(tokens)) while tokens[0] isnt ')'
            return list
        else return atom(token)

# Convert from input code to output code
parse = (s) -> read_from(tokenize(s))

# Evaluate an expression like ['+', 20, 20]
evaluate = (expr) ->

    return env[expr] if expr of env                         # Symbol
    return expr if expr not instanceof Array                # Constant

    switch expr[0]
        when 'quote' then return to_string(expr[1...][0])   # (quote expr)
        when 'if'                                           # (if test conseq alt)
            [_, test, conseq, alt] = expr
            console.log "EVAL", evaluate(test).constructor
            return conseq if evaluate(test) is true
            return alt

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
