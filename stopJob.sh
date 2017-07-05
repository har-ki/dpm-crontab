#!/bin/bash
set -e

DPM_CLIENT_HOME=<Absolute path to dpm-crontab directory>
USERNAME=$(cat "${DPM_CLIENT_HOME}"/etc/dpmuser)
PASSWORD=$(cat "${DPM_CLIENT_HOME}"/etc/dpmpassword)
JOB_ID=$(cat "${DPM_CLIENT_HOME}"/etc/job-id)
URL=https://cloud.streamsets.com

# login to security app
echo "Authenticating with DPM"
curl -X POST -d "{\"userName\":\"${USERNAME}\", \"password\": \"${PASSWORD}\"}" ${URL}/security/public-rest/v1/authentication/login --header "Content-Type:application/json" --header "X-Requested-By:SDC" -c /tmp/cookie.txt
# generate auth token from security app
sessionToken=`sed -n '/SS-SSO-LOGIN/p' /tmp/cookie.txt | perl -lane 'print $F[$#F]'`

# Call DPM rest APIs to start job
echo "Starting job with id "${JOB_ID}""
curl -X POST ${URL}/jobrunner/rest/v1/job/${JOB_ID}/stop --header "Content-Type:application/json" --header "X-Requested-By:SDC" --header "X-SS-REST-CALL:true" --header "X-SS-User-Auth-Token:$sessionToken"
