lispy = require './lispy'

# Test that a piece of code equals its result
test = (code, result) ->
    actual = lispy.eval(code)
    if result isnt actual
        console.log "ERROR: " + code + " doesn't equal " + result + ". It equals " + actual
    else
        console.log "SUCCESS: " + code + " equals " + result

test '20', 20
test 'true', true
test 'false', no
test '(+ 100 200)', 300
test '(+ 100 200 300 400 500)', 1500
test '(* 10 10)', 100
test '(* 15 16 17)', 4080
test '(- 400 300 200)', -100
test '(/ 5000 20 100)', 2.5
test '(+ 20 (+ 20 20)))', 60
test '(+ (+ 1 1) (+ 1 1))', 4
test '(* 20 (+ 20 20)))', 800
test '(> 20 30)', no
test '(> 20 30 19)', false
test '(< 10 100 1000)', yes
test '(= true true true)', yes
test '(= true false true)', no
test '(equal? false true)', no
test '(equal? (+ 20 20) 40)', yes
test '(equal? (+ 20 (* 2 10)) (* 4 (* 5 2)))', yes
test '(equal? (+ 20 (* 2 10)) (* 4 (* 5 3)))', no
test '(quote (+ 20 20))', '(+ 20 20)'
test '(if true "yes" "no")', '"yes"'
test '(if false "yes" "no")', '"no"'
test '(define yes true)', true
test '(define no false)', false
test '(define x (+ (* 2 2) (* 2 2)))', 8
test 'x', 8
test '((lambda i (* i i)) 4)', 16
