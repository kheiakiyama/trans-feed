# trans-feed
trans-feed build by jekyll and Azure components.
Translates RSS feeds in your favorite language and hosts static sites.

## [Demo](https://trans-feed.kheiakiyama.com/)

`feedUrl`: `https://azure.microsoft.com/en-us/blog/feed/`

## deploy setting
```
az ad sp create-for-rbac --name "trans-feed" --years 100 --sdk-auth true --scopes {RESOURCE_GROUP_ID}
# put result to github secret as `AZURE_CREDENTIALS`
az role assignment create --role "Storage Blob Data Owner" --assignee-object-id {OBJECT_ID} --assignee-principal-type ServicePrincipal --scope {RESOURCE_GROUP_ID}
```

## Structure

### translate
![translate](https://raw.githubusercontent.com/kheiakiyama/trans-feed/master/structure/translate.png)

### hosting
![hosting](https://raw.githubusercontent.com/kheiakiyama/trans-feed/master/structure/hosting.png)

### deployment
![deployment](https://raw.githubusercontent.com/kheiakiyama/trans-feed/master/structure/deployment.png)

## tale
-------
This design is powered by [tale](https://chesterhow.github.io/tale)
