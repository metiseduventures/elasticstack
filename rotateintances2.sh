#!/bin/bash
envlist="franchiseprod"


for env in $envlist
do
	date;
	echo "Rotating instances for Environment :"$env;
	ver="$(aws elasticbeanstalk describe-environments --environment-names $env --output=text | awk -F $'\t' '{ print $17}')"
	aws elasticbeanstalk update-environment --environment-name $env --version-label $ver
done
