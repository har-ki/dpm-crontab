# Schedule DPM Jobs using Crontab

StreamSets Dataflow Performance Manager (DPM) exposes all its functionality via Restful API. The scripts in this repository shows how to schedule DPM jobs using crontab.

DPM Restful API Scripts
-----------------------

The startJob.sh and stopJob.sh scripts make Restful API calls to DPM to authenticate and start and stop job respectively.
Update “DPM_CRONTAB_HOME” variable in these files to point to the “dpm-crontab” directory (the root directory of this repository). Use absolute path.

Grant execute permission on these scripts.

Update the following files in dpm-crontab/etc directory:
dpmuser : username to your DPM account
dpmpassword : password to your DPM account
job-id : id of the job you wish to start/stop. You can obtain job id from the DPM UI. Expand the the job you are interested in and click on “Show Additional Info”.

Crontab entries
------------

Edit your crontab file (crontab -e) to include the startJob and stopJob.sh scripts.

This sample crontab entry calls script startJob.sh every first minute of every hour and calls script stopJob.sh every third minute of every hour:
1 * * * * <Absolute path to dpm-crontab directory>/startJob.sh >> <Absolute path to dpm-crontab directory>/log/script_output.log 2>&1
3 * * * * <Absolute path to dpm-crontab directory>/stopJob.sh >> <Absolute path to dpm-crontab directory>/log/script_output.log 2>&1
