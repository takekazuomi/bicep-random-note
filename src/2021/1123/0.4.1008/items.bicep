var keys = {
  key1: {
    foo: true
    woo: 100
  }
  key2: {
    foo: false
    woo: 200
  }
}


var r = [for k in items(keys): {
  key: k.key
  foo: k.value.foo
  woo: k.value.woo
}]

output r array = r
