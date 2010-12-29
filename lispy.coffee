/* Lispy inspired Javascript Lisp written in CoffeeScript */

tokenize = (s) -> s.replace('(', ' ( ').replace(')', ' ) ').split(' ')
read_from = (tokens) ->
    for token in tokens

        continue if token is ''
        console.log("TOKEN " + token);


parse = (s) ->
    read_from(tokenize(s));

code = "(+ 20 20)"
console.log(parse(code));
