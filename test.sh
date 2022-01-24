#!/usr/bin/env bash
	groupmsg="Deployment of xyz branch started on abc environment";
	# send message to slackbot
	curl -X POST -H 'Content-type: application/json' --data '{"text":"'"${groupmsg}"'"}' https://hooks.slack.com/services/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
