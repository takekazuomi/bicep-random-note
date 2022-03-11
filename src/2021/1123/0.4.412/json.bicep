var jsonVar = json('{"hello2":"world"}')

var foo = jsonVar.hello2

var jsonVar2 = json(loadTextContent('./jsonVar.json'))
var boo = jsonVar2.hello
