#!/bin/bash

env=$1;
EnableSpot=$2;

if [ -x "$EnableSpot" ];then
	EnableSpot="true";
fi


if [ -z "$env" ];then
	echo "usage : envLifecycle.sh <environment name>";
	echo "List of available environments: ";
	aws elasticbeanstalk describe-environments --query 'Environments[*].EnvironmentName' --output=text
else
	aws elasticbeanstalk update-environment --environment-name ${env} --option-settings Namespace=aws:ec2:instances,OptionName=SpotFleetOnDemandBase,Value=0,OptionName=SpotFleetOnDemandAboveBasePercentage,Value=0,OptionName=EnableSpot,Value=true
fi


