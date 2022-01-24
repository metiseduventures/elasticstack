#!/usr/bin/env bash
filename="$1";

if [ -z "$filename" ];then
	echo "Provide filename to process";
	exit 1;
fi
i=0;
while read qid ; do
	((i=i+1));
	echo "${i}. Activating Question id ${qid} from file ${filename}";
 	curl --location --request POST 'https://gold.adda247.com/account-ws/v1/account/publish/content/publish' --header 'Content-Type: application/json' --header 'X-Auth-Token: fpoa43edty5' --header 'user-agent: PostmanRuntime/7.26.3' --header 'Authorization: Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbkBhZGRhMjQ3LmNvbSIsInBlcm1pc3Npb25zIjpbIlF1ZXN0aW9uc19WaWV3ICYgRWRpdCIsIlBhY2thZ2VzX1ZpZXcgJiBFZGl0IiwiU01FIFBhbmVsX1ZpZXcgJiBFZGl0IiwiRGFzaGJvYXJkX1ZpZXcgJiBFZGl0IiwiRXhwb3J0IHRvIFdvcmRfVmlldyAmIEVkaXQiLCJNYW5hZ2UgVXNlcnNfVmlldyAmIEVkaXQiLCJPcmRlcnNfVmlldyAmIEVkaXQiLCJPdGhlciBDb250ZW50X1ZpZXcgJiBFZGl0IiwiVGVzdHNfVmlldyAmIEVkaXQiLCJUYWcgTWFzdGVyX1ZpZXcgJiBFZGl0IiwiRXhhbXNfVmlldyAmIEVkaXQiXSwiSXAtQWRkcmVzcyI6IjEyNy4wLjAuMSIsIlVzZXItQWdlbnQiOiJQb3N0bWFuUnVudGltZS83LjI2LjMiLCJleHAiOjE2MTMyMTg3ODl9.CzkUbEwdNopJpfXENh_4ioZg3IsvhBpfTTP8HQcc5wlEwq0yBD9uq9FR2FLDliD2ZfTHMBH8Gd_eDWjdW8VzGw' --data-raw '{"entityIds": ['"$qid"']}' ;
	if [[ $? -ne 0 ]]; then
		echo ${qid} >> failed.txt;
	fi
	echo "";	
done < "${filename}"
groupmsg="Completed Publishing  ${i} questions on gold platform";
curl -X POST -H 'Content-type: application/json' --data '{"text":"'"${groupmsg}"'"}' https://hooks.slack.com/services/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
