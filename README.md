# trans-feed
trans-feed build Translated feeds as your favorite language

## How To Install

### BitBucket

1. [Create Consumer](https://confluence.atlassian.com/bitbucket/oauth-on-bitbucket-cloud-238027431.html#OAuthonBitbucketCloud-Createaconsumer)

2. Open browser
https://bitbucket.org/site/oauth2/authorize

3. Copy code  
You use this code on next step.

```
curl -X POST -u "client_id:secret" \
  https://bitbucket.org/site/oauth2/access_token \
  -d grant_type=authorization_code -d code={code}
```

## tale
-------
This design is powered by [tale](https://chesterhow.github.io/tale)
