# list* errors

## log analytics and listKey(s)

Error when using listKey by mistake with listKeys.

```sh
% make la
az group create --location eastus2 -n omi01-rg -o table
Location    Name
----------  --------
eastus2     omi01-rg
az deployment group create -g omi01-rg \
        -f log-analytics.bicep
Deployment failed. Correlation ID: 6801c271-af85-41ee-b41f-749fba18520b. {
  "error": {
    "code": "BadRequest",
    "message": "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"/>\r\n<title>404 - File or directory not found.</title>\r\n<style type=\"text/css\">\r\n<!--\r\nbody{margin:0;font-size:.7em;font-family:Verdana, Arial, Helvetica, sans-serif;background:#EEEEEE;}\r\nfieldset{padding:0 15px 10px 15px;} \r\nh1{font-size:2.4em;margin:0;color:#FFF;}\r\nh2{font-size:1.7em;margin:0;color:#CC0000;} \r\nh3{font-size:1.2em;margin:10px 0 0 0;color:#000000;} \r\n#header{width:96%;margin:0 0 0 0;padding:6px 2% 6px 2%;font-family:\"trebuchet MS\", Verdana, sans-serif;color:#FFF;\r\nbackground-color:#555555;}\r\n#content{margin:0 0 0 2%;position:relative;}\r\n.content-container{background:#FFF;width:96%;margin-top:8px;padding:10px;position:relative;}\r\n-->\r\n</style>\r\n</head>\r\n<body>\r\n<div id=\"header\"><h1>Server Error</h1></div>\r\n<div id=\"content\">\r\n <div class=\"content-container\"><fieldset>\r\n  <h2>404 - File or directory not found.</h2>\r\n  <h3>The resource you are looking for might have been removed, had its name changed, or is temporarily unavailable.</h3>\r\n </fieldset></div>\r\n</div>\r\n</body>\r\n</html>\r\n"
  }
}
make: *** [Makefile:21: la] Error 1
```

## Storage Account

Storage Account's error message is easy to understand. But Log Analytics's error message is broken.

```sh
% make sa
az group create --location eastus2 -n omi01-rg -o table
Location    Name
----------  --------
eastus2     omi01-rg
az deployment group create -g omi01-rg \
        -f sa.bicep
Deployment failed. Correlation ID: 9062d7a3-44c2-48ec-9ee8-b063e9fb9ff7. {
  "error": {
    "code": "HttpResourceNotFound",
    "message": "The request url http://10.0.34.134:30008/facf652d-a46e-4319-a728-ebdae7a6549c/132602770391492876/d049b0c2-bf57-4f24-9f56-8fd795066592/subscriptions/eb366cce-61a4-447f-b5d0-cf4a7a262b37/resourcegroups/omi01-rg/providers/Microsoft.Storage/storageAccounts/sa01omi01/listKey?api-version=2021-02-01 is not found."
  }
}
make: *** [Makefile:26: sa] Error 1
```
