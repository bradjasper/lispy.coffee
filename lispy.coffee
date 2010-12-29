# Lispy inspired Javascript Lisp written in CoffeeScript

_ = require './underscore'
utils = require('./utils')

Symbol = String
globals =
    "+": utils.sum
    "*": utils.multiply
    "-": utils.subtract
    "/": utils.divide

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

    return globals[expr] if expr of globals         # Symbol
    return expr if expr not instanceof Array        # Constants

    # Handle nested expressions
    exps = (evaluate(x) for x in expr)
    proc = exps.shift()
    return proc(exps...)

# Assert that a code expression equals a result
assert = (code, result) ->
    actual = evaluate(parse(code))
    if result isnt actual
        console.log "ERROR: " + code + " doesn't equal " + result + ". It equals " + actual
    else
        console.log "SUCCESS"

assert '20', 20
assert '(+ 100 200)', 300
assert '(+ 100 200 300 400 500)', 1500
assert '(* 10 10)', 100
assert '(* 15 16 17)', 4080
assert '(- 400 300 200)', -100
assert '(/ 5000 20 100)', 2.5
assert '(+ 20 (+ 20 20)))', 60
