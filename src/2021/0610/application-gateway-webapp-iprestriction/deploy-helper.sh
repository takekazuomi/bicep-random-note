#!/bin/bash
main ()
{
  local name=${1:-agwwebsql01}

  export RESOURCE_GROUP="${name}-rg"
  export LOCATION="eastus2"
  export SITE_NAME="${name}site"
  export ADMINISTRATOR_LOGIN="${name}"
}

main "$@"
