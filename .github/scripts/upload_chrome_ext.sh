#!/bin/sh

token=`
curl \
-X POST \
https://www.googleapis.com/oauth2/v4/token \
-d \
"client_id=${EXTENSION_CLIENT_ID}&client_secret=${EXTENSION_CLIENT_SECRET}&refresh_token=${EXTENSION_REFRESH_TOKEN}&grant_type=refresh_token" \
| \
jq '.access_token'`

status=`curl \
--silent \
--show-error \
--output /dev/null \
--fail \
-H "Authorization: Bearer $token" \
-H "x-goog-api-version: 2" \
-X PUT \
-T ${EXTENSION_PATH} \
https://www.googleapis.com/upload/chromewebstore/v1.1/items/${EXTENSION_ID} \
| \
jq -r '.uploadState'`

echo "$status"

