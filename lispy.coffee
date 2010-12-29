# Lispy inspired Javascript Lisp written in CoffeeScript

globals = require('./globals')

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


# Process an expression like ['+', 20, 20]
process = (expr) ->

    return globals[expr] if expr of globals         # Symbol
    return expr if expr not instanceof Array        # Constants

    # Handle nested expressions
    exps = (process(x) for x in expr)
    proc = exps.shift()
    return proc(exps...)

evaluate = (code) -> process(parse(code))

# Exports
exports.evaluate = evaluate
