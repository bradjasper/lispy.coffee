# Repl for lispy

lispy = require('./lispy')
sys = require("sys")

stdin = process.openStdin()
stdin.setEncoding('utf8')

write = (s) -> process.stdout.write(s)
prompt = (name='lispy') -> write(name + '> ')

stdin.on 'data', (data) -> write(String(lispy.eval(data) + '\n')) and prompt()

prompt()
