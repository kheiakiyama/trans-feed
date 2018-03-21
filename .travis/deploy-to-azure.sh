#!/bin/sh

# install azcopy
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt-get update
sudo apt-get install libunwind8
wget -O dotnet.tar.gz https://download.microsoft.com/download/D/7/2/D725E47F-A4F1-4285-8935-A91AE2FCC06A/dotnet-sdk-2.0.3-linux-x64.tar.gz
mkdir -p $HOME/dotnet && tar zxf dotnet.tar.gz -C $HOME/dotnet
export PATH=$PATH:$HOME/dotnet
dotnet --version
wget -O azcopy.tar.gz https://aka.ms/downloadazcopyprlinux
tar -xf azcopy.tar.gz
ls -la ./azcopy
ls -la ./_site
export PATH=$PATH:$HOME/dotnet
dotnet --version
dotnet ./azcopy/azcopy.dll --version

# add posts if exists
mkdir $TRAVIS_BUILD_DIR/_tmp
dotnet ./azcopy/azcopy.dll --source $BLOB_TRANSLATED_POSTS_URL --source-key $STORAGE_KEY --destination ./_tmp --recursive --quiet
git clone https://$GITHUB_USERNAME:$GITHUB_TOKEN@github.com/kheiakiyama/trans-feed.git $TRAVIS_BUILD_DIR/_travis_work
rsync -avr $TRAVIS_BUILD_DIR/_tmp/ $TRAVIS_BUILD_DIR/_travis_work/_posts
cd $TRAVIS_BUILD_DIR/_travis_work
ls -la $TRAVIS_BUILD_DIR/_travis_work/_posts
git add -A
git commit -m "Build:$TRAVIS_BUILD_NUMBER Commit:$TRAVIS_COMMIT $TRAVIS_COMMIT_MESSAGE"
git push origin master

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
ruby ./make-jekyll-proxies.rb ../_site $TRAVIS_BUILD_DIR/_function_proxy
ls -la $TRAVIS_BUILD_DIR/_function_proxy
git add -A
git commit -m "Build:$TRAVIS_BUILD_NUMBER Commit:$TRAVIS_COMMIT $TRAVIS_COMMIT_MESSAGE"
git push origin master
