# README

## 2021/07/16 v0.4.412

<https://github.com/Azure/bicep/releases/tag/v0.4.412>

- Add list method call on Azure resource references ([#3430](https://github.com/Azure/bicep/pull/3430))
  - instead of listKeys(stg.id, stg.apiVersion), can now do stg.listKeys()
  - intellisense for these functions is not yet available, but will be addressed with [#667](https://github.com/Azure/bicep/issues/667) at a later date.
- Add support for JSON literal string conversion ([#3510](https://github.com/Azure/bicep/pull/3510))
  - provides type awareness/intellisense for json strings. Try json(loadTextContent('stuff.json')).
- More complete & accurate Azure resource types ([#3591](https://github.com/Azure/bicep/pull/3591))
  - should no longer see cryptic type names. May notice more type warnings that were not caught earlier.
- Add support for using local json templates as modules ([#3367](https://github.com/Azure/bicep/pull/3367))
- Add support for object body completion snippets (#3254)
  - the required-properties completion shows up in more places.
- Functions to include file's content as string or entire file as base64 ([#2501](https://github.com/Azure/bicep/pull/2501))
- Known top-level properties does not block compilation if not defined in the resource schema ([#3519](https://github.com/Azure/bicep/pull/3519))

