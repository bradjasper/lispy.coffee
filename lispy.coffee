# Lispy inspired Javascript Lisp written in CoffeeScript

class Symbol
    constructor: (@value) ->

# Create spaces where necessary then chop up the parts
tokenize = (s) -> s.replace(/\(/g, ' ( ').replace(/\)/g, ' ) ').split(' ')

# Create an atom (Number, Symbol)
atom = (token) ->
    number = Number(token)
    return number if not isNaN(number) 
    return new Symbol(token)

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

# Eval input code
evaluate = (expr) ->
    result = parse(expr)

    return result if result not instanceof Array        # Constants


    console.log "RESULT", JSON.stringify(result)

# Assert that a code expression equals a result
assert = (code, result) ->
    actual = evaluate(code)
    if result is actual
        console.log "SUCCESS"
    else
        console.log "ERROR: " + code + " doesn't equal " + result + ". It equals " + actual


assert '20', 20
assert '(+ 20 20)', 40
