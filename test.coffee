lispy = require './lispy'

# Test that a piece of code equals its result
test = (code, result) ->
    actual = lispy.eval(code)
    if result isnt actual
        console.log "ERROR: " + code + " doesn't equal " + result + ". It equals " + actual
    else
        console.log "SUCCESS: " + code + " equals " + result

test '20', 20
test '(+ 100 200)', 300
test '(+ 100 200 300 400 500)', 1500
test '(* 10 10)', 100
test '(* 15 16 17)', 4080
test '(- 400 300 200)', -100
test '(/ 5000 20 100)', 2.5
test '(+ 20 (+ 20 20)))', 60
test '(* 20 (+ 20 20)))', 800
