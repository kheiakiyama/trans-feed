#!/bin/sh
export PATH=$PATH:$HOME/dotnet
dotnet --version
dotnet ./azcopy/azcopy.dll --version

# deploy to azure blob storage
cd $TRAVIS_BUILD_DIR
dotnet ./azcopy/azcopy.dll --source ./_site --destination $BLOB_CONTENTS_URL --dest-key $STORAGE_KEY --recursive --quiet
dotnet ./azcopy/azcopy.dll --source ./_site --destination $BLOB_CONTENTS_URL --dest-key $STORAGE_KEY --recursive --quiet --include "*.html" --set-content-type "text/html"
dotnet ./azcopy/azcopy.dll --source ./_site --destination $BLOB_CONTENTS_URL --dest-key $STORAGE_KEY --recursive --quiet --include "*.css" --set-content-type "text/css"
dotnet ./azcopy/azcopy.dll --source ./_site --destination $BLOB_CONTENTS_URL --dest-key $STORAGE_KEY --recursive --quiet --include "*.js" --set-content-type "application/javascript"
dotnet ./azcopy/azcopy.dll --source ./_site --destination $BLOB_CONTENTS_URL --dest-key $STORAGE_KEY --recursive --quiet --include "*.eot" --set-content-type "application/vnd.ms-fontobject"
dotnet ./azcopy/azcopy.dll --source ./_site --destination $BLOB_CONTENTS_URL --dest-key $STORAGE_KEY --recursive --quiet --include "*.woff" --set-content-type "application/font-woff"
dotnet ./azcopy/azcopy.dll --source ./_site --destination $BLOB_CONTENTS_URL --dest-key $STORAGE_KEY --recursive --quiet --include "*.woff2" --set-content-type "application/font-woff2"
dotnet ./azcopy/azcopy.dll --source ./_site --destination $BLOB_CONTENTS_URL --dest-key $STORAGE_KEY --recursive --quiet --include "*.otf" --set-content-type "application/font-woff"
dotnet ./azcopy/azcopy.dll --source ./_site --destination $BLOB_CONTENTS_URL --dest-key $STORAGE_KEY --recursive --quiet --include "*.svg" --set-content-type "image/svg+xml"
dotnet ./azcopy/azcopy.dll --source ./_site --destination $BLOB_CONTENTS_URL --dest-key $STORAGE_KEY --recursive --quiet --include "*.jpg" --set-content-type "image/jpeg"
dotnet ./azcopy/azcopy.dll --source ./_site --destination $BLOB_CONTENTS_URL --dest-key $STORAGE_KEY --recursive --quiet --include "*.png" --set-content-type "image/png"

# update proxies.json
mkdir $TRAVIS_BUILD_DIR/_function_proxy
git clone https://$FUNCTION_GIT_USERNAME:$FUNCTION_GIT_PASSWORD@$FUNCTION_APP_NAME.scm.azurewebsites.net:443/$FUNCTION_APP_NAME.git $TRAVIS_BUILD_DIR/_function_proxy
cd $TRAVIS_BUILD_DIR/.travis
ruby ./make-jekyll-proxies.rb $TRAVIS_BUILD_DIR/_site $TRAVIS_BUILD_DIR/_function_proxy/
ls -la $TRAVIS_BUILD_DIR/_function_proxy
cd $TRAVIS_BUILD_DIR/_function_proxy
git add -A
git commit -m "Build:$TRAVIS_BUILD_NUMBER Commit:$TRAVIS_COMMIT $TRAVIS_COMMIT_MESSAGE"
git push origin master
