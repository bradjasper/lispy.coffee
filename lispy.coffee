/* Lispy inspired Javascript Lisp written in CoffeeScript */

tokenize = (s) -> s.replace(/\(/g, ' ( ').replace(/\)/g, ' ) ').split(' ')
read_from = (tokens) ->

    console.log("TOKENS " + tokens);

    token = tokens.shift()
    switch token
        when '' then read_from(tokens)
        when ')' then raise 'SyntaxError'
        when '('
            list = []
            return list.push(read_from(tokens)) while tokens[0] isnt ')'
            return list
        else return token

parse = (s) -> read_from(tokenize(s))
assert = (code, result) ->
    actual = parse(code)
    if result isnt actual
        console.log "ERROR: " + code + " doesn't equal " + result + ". It equals " + actual

assert '(+ 20 20)', 40
