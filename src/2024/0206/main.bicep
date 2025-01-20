//param input string = resourceGroup().id
param input string = 'test'
output result string = uniqueString(input)
