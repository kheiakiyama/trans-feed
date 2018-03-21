#!/bin/sh

export PATH=$PATH:$HOME/dotnet
dotnet --version
dotnet ./azcopy/azcopy.dll --version

# add posts if exists
mkdir $TRAVIS_BUILD_DIR/_tmp
dotnet ./azcopy/azcopy.dll --source $BLOB_TRANSLATED_POSTS_URL --source-key $STORAGE_KEY --destination ./_tmp --recursive --quiet
rsync -avr $TRAVIS_BUILD_DIR/_tmp/ $TRAVIS_BUILD_DIR/_posts
ls -la $TRAVIS_BUILD_DIR/_posts
