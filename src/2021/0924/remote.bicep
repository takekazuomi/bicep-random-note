module hello 'br:omi02ax6xi6fpkotik.azurecr.io/demo/hello:1.0' = {
  name:'hello'
}

output hello string = hello.outputs.msg
