param foo object = {
  @allowed([
    'Always'
    'Never'
    'OnFailure'
  ])
  restartPolicy : 'Always'
}

//
param foo object = {
  restartPolicy : 'Always'
  boo: 'some value'
}
