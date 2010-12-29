/* Lispy inspired Javascript lisp clone */


code = "(+ 20 20)";

function tokenize(s) {
    return s.replace('(', ' ( ').replace(')', ' ) ').split(' ');
}

function read_from(tokens) {
    console.log("TOKENS: " + tokens);
}

function parse(s) {
    return read_from(tokenize(s));
}

console.log(parse(code));
