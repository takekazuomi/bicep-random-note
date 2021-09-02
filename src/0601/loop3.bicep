// Property value for-expressions cannot be nested.bicep(BCP142)
param parents array

resource parentResources 'Microsoft.Example/examples@2020-06-06' = [for parent in parents: if (parent.enabled) {
  name: parent.name
  properties: {
    children: [for child in parent.children: {
      name: child.name
      setting: child.settingValue
      nestedproperties: {
        nestedchildren: [for child2 in child: {
          nestedname: child2.name
          nestedsetting: child2.settingValue
        }]
      }
    }]
  }
}]
