#!/usr/bin/env bash

arg1="$1";
arg2="$2";
arg3="$3";
arg4="$4";
arg5="$5";

	case "$arg1" in
		-a | --appname )        
			appname="$arg2";;
        	-h | --help )
        		echo "usage: build.sh -a applicationName [-b branchName]";
            		exit;;
        	* )
        		echo "usage: build.sh -a applicationName [-b branchName]";
            		exit 1;
    	esac

	if [ -z "$arg3" ]; then
		branch=dev;
	elif [ "$arg3" != "-b" ];then
		echo "usage: build.sh -a applicationName [-b branchName]";
		exit 1;
	elif [ -z "$arg4" ]; then
		echo "usage: build.sh -a applicationName [-b branchName]";
		exit 1;
	else
		branch="$arg4";
	fi


	 
#Environment Variables
gitHome="/home/ec2-user/git/";
msg="build-script";
user="devops";
customBuild=false;
dbhost="localhost";
dbuser="heartprairy";
dbpass="cbbmc33JYQE5";
dbname="devops";
dbtable="deployments";
timemark='date +"%F %T"';
cusenv=$arg5;

if [ ! -z "$arg5" ];then
	msg="$msg-$arg5";
fi

#functions

verifyAppName()
{
	local app=$1;
	case "$app" in
		adda247 | paymentservice | erp | userauth | bigservice | analytics | appInstall | contentadmin | franchise | mailingservice | pushservice | ranking | testseries | timeline | Video-Streaming-server | store-elastic-search | coupon-admin | couponservice | extraservice | socialclient | newcouponadmin | ytsearch | newcouponservice | mars | Video-Streaming-server | doubts ) 
		;;

		admin-panel-ui | storefront-user | storefront-admin | adda247 )
		if [ -z "$arg5" ]; then
			echo "You have not selected environment for which you are building\n usage: build.sh -a applicationName [-b branchName] environment";
			exit 1;
		else
			case "$arg5" in
				staging )
				customBuild=true;
				cusenv=staging1;
				;;
				staging2 | staging3 | stagingv | alpha )
				customBuild=true;
				;;
				production)
				;;
				*)
				echo "invalid environment (valid: staging,staging2,stagingv,production)";
				exit 1
			esac
		fi;;

		*)
			echo "Invalid application name. Application does not exist";
			exit 1;;
	esac
}

 

timestamp() {
	date +"%d-%h_%H:%M:%S";
}

findEnvName()
{
    local app=$1;
    local variant=$2;
    case $app in
    	userauth )
		if [ "$arg5" = "staging" ]; then
        		envName="userauth-staging";
		elif [ "$arg5" = "production" ]; then
			envName="userauth-production";
		fi;;
    	paymentservice )
		if [ "$arg5" = "staging" ]; then
        		envName="paymentservicestaging";
		fi;;
	ytsearch )
		if [ "$arg5" = "staging" ]; then
			envName="ytsearch-staging";
		elif [ "$arg5" = "production" ]; then
			envName="ytsearchprod";
		fi ;;
	adda247 )
		if [ "$arg5" = "staging" ]; then
			envName="stagingadda247";
		elif [ "$arg5" = "staging2" ]; then
			envName="staging2adda247";
		elif [ "$arg5" = "staging3" ]; then
			envName="staging3adda247";
		elif [ "$arg5" = "stagingv" ]; then
			envName="stagingvadda247";
		elif [ "$arg5" = "alpha" ]; then
			envName="stagingadda247";
		elif [ "$arg5" = "production" ]; then
			envName="adda247prod";
		fi ;;
	admin-panel-ui )
		if [ "$arg5" = "staging" ] ;then
			envName="stagingadminui";
		elif [ "$arg5" = "staging2" ]; then
			envName="stagingadminui2";
		elif [ "$arg5" = "staging3" ]; then
			envName="stagingadminui3";
		elif [ "$arg5" = "stagingv" ]; then
			envName="stagingadminuiv";
		elif [ "$arg5" = "production" ]; then
			envName="adminuiProduction";
		fi;;
	analytics )
		if [ "$arg5" = "staging" ]; then
			envName="analyticsstaging";
		elif [ "$arg5" = "production" ]; then
			envName="analyticsprod";
		fi;;
	bigservice )
		if [ "$arg5" = "staging" ]; then
			envName="bigservicestaging";
		elif [ "$arg5" = "production" ]; then
			envName="bigserviceproduction";
		fi;;
	contentadmin )
		if [ "$arg5" = "staging" ]; then
			envName="contentadminstaging";
		elif [ "$arg5" = "production" ]; then
			envName="contentadminproduction";
		fi;;
	newcouponadmin )
		if [ "$arg5" = "staging" ]; then
			envName="newcouponadminstaging";
		elif [ "$arg5" = "production" ]; then
			envName="newcouponadminprod";
		fi;;	
	newcouponservice )
		if [ "$arg5" = "staging" ]; then
			envName="newcouponservicestaging";
		elif [ "$arg5" = "production" ]; then
			envName="newcouponserviceprod";
		fi;;	
	coupon-admin )
		if [ "$arg5" = "staging" ]; then
			envName="CouponAdminStaging";
		elif [ "$arg5" = "qa1" ]; then
			envName="couponadminqa1";
		elif [ "$arg5" = "production" ]; then
			envName="couponadminprod";
		fi;;
	couponservice )
		if [ "$arg5" = "staging" ]; then
			envName="CouponServiceStaging";
		elif [ "$arg5" = "qa1" ]; then
			envName="couponserviceqa1";
		elif [ "$arg5" = "production" ]; then
			envName="couponserviceprod";
		fi;;
	erp )
		if [ "$arg5" = "staging" ]; then
          		envName="erpstaging";
		elif [ "$arg5" = "production" ]; then
			envName="erpProduction";
		fi;;
	extraservice )
		if [ "$arg5" = "staging" ]; then
			envName="extraservicestaging";
		elif [ "$arg5" = "production" ]; then
			envName="extraserviceproduction";
		fi;;
	franchise )
		if [ "$arg5" = "staging" ]; then
			envName="franchisestaging";
		elif [ "$arg5" = "production" ]; then
			envName="franchiseprod";
		fi;;
	pushservice )
		if [ "$arg5" = "staging" ]; then
			envName="pushservicestaging";
		elif [ "$arg5" = "production" ]; then
			envName="pushserviceproduction";
		fi;;
	ranking )
		if [ "$arg5" = "staging" ]; then
			envName="rankingstaging";
		elif [ "$arg5" = "production" ]; then
			envName="rankingproduction";
		fi;;
	store-elastic-search )
		if [ "$arg5" = "staging" ]; then
			envName="StoreElasticSearchStaging";
		elif [ "$arg5" = "staging2" ]; then
			envName="search2prod";
		elif [ "$arg5" = "production" ]; then
			envName="StoreElasticSearch-env";
		fi;;
	storefront-admin )
		if [ "$arg5" = "staging" ]; then
			envName="StoreFrontAdminStaging1";
		elif [ "$arg5" = "staging2" ]; then
			envName="StoreFrontAdminStaging2";
		elif [ "$arg5" = "staging3" ]; then
			envName="storefrontadminstaging3";
		elif [ "$arg5" = "stagingv" ]; then
			envName="StoreFrontAdminStagingv";
		elif [ "$arg5" = "qa1" ]; then
			envName="storefrontadminqa1";
		elif [ "$arg5" = "production" ]; then
			envName="StorefrontAdminProduction";
		fi;;
	storefront-user )
		if [ "$arg5" = "staging" ]; then
			envName="stagingstoreuser1";
		elif [ "$arg5" = "staging2" ]; then
			envName="stagingstoreuser2";
		elif [ "$arg5" = "staging3" ]; then
			envName="stagingstoreuser3";
		elif [ "$arg5" = "stagingv" ]; then
			envName="stagingstoreuserv";
		elif [ "$arg5" = "alpha" ]; then
			envName="storefrontuserprod2";
		elif [ "$arg5" = "production" ]; then
			envName="storefrontuserprod";
		fi;;
	testseries )
		if [ "$arg5" = "staging" ]; then
			envName="testseriesstaging";
		elif [ "$arg5" = "qa1" ]; then
			envName="testseriesqa1";
		elif [ "$arg5" = "production" ]; then
			envName="testseriesprod";
		fi;;
	timeline )
		if [ "$arg5" = "staging" ]; then
			envName="Timeline-stag-env";
		elif [ "$arg5" = "qa1" ]; then
			envName="timelineqa1";
		elif [ "$arg5" = "production" ]; then
			envName="timeline-env";
		fi;;
        mars )
                if [ "$arg5" = "staging" ]; then
                        envName="stagingmars";
                fi;;
        appInstall )
                if [ "$arg5" = "production" ]; then
                        envName="appinstallproduction";
                fi;;
        mailingservice )
                if [ "$arg5" = "production" ]; then
                        envName="mailingservice";
                fi;;
	doubts )
                if [ "$arg5" = "staging" ]; then
                        envName="doubtsstaging";
		elif [ "$arg5" = "staging2" ]; then
			envName="doubtsprod2";
		elif [ "$arg5" = "production" ]; then
			envName="doubtsprod";
                fi;;
        socialclient )
                if [ "$arg5" = "staging" ]; then
                        envName="socialclientstaging";
		elif [ "$arg5" = "production" ]; then
			envName="socialclientprod";
		fi;;
	Video-Streaming-server )
		if [ "$arg5" = "staging" ]; then
			envName="videoserverstaging";
		elif [ "$arg5" = "production" ]; then
			envName="videoserverproduction";
		fi;;
	* )
 		echo "No Environment mapped for this";;
    	esac
}

buildPackage()
{
	local app=$1;
	local repoPath=$2;
	local brnch=$3;
	if [ -z "$brnch" ]
	then
		echo "Branch is not specified. Aborting"; exit 1;
	fi
	cd $repoPath
    	echo -e "\033[4;91mBuilding package $app from $brnch branch \033[0m";
	#drop unfinished changes
	git stash  
	# switch/checkout required branch
	git fetch
	git checkout $brnch
	if [[ $? -ne 0 ]]; then
    	echo "Branch does not exist. Run again. Exiting";
    	exit $?
	fi
	git pull origin $brnch
	if [ "$customBuild" == true ];then
		/usr/local/src/apache-maven/bin/mvn clean install  -Denv.name=$cusenv
	else 
		/usr/local/src/apache-maven/bin/mvn clean install 
	fi
    	if [[ $? -ne 0 ]]; then
    	echo -e "\033[33;5mBuild Failed. Check code again. Exiting\033[0m";
		exit $?
	fi
}

findAppWarName()
{
	local app=$1
	case $app in
	userauth)
		appwarname="userauthrest";
		appwarkey="in/careerpower/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	paymentservice)
		appwarname="payment";
		appwarkey="in/careerpower/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	admin-panel-ui)
		appwarname="adminpaneluimaven";
		appwarkey="org/springframework/boot/$appwarname/0.0.1/$appwarname-0.0.1.war";;
	analytics)
		appwarname=$appname;
		appwarkey="in/careerpower/$appwarname/1.5.7.RELEASE/$appwarname-1.5.7.RELEASE.war";;
	appInstall)
		appwarname="appinstall-service";
		appwarkey="in/careerpower/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	contentadmin)
		appwarname="contentadmin";
		appwarkey="in/careerpower/$appwarname/1.3.3.RELEASE/$appwarname-1.3.3.RELEASE.war";;
	erp)
	 	appwarname="erp-webapp-war";
		appwarkey="in/careerpower/erp/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	franchise)
		appwarname="franchise-webapp-war";
		appwarkey="in/careerpower/franchise/$appwarname/1.0.0/$appwarname-1.0.0.war";;	
	mailingservice)
		appwarname="mailing-service";
		appwarkey="in/careerpower/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	pushservice)
		appwarname="push-service";
		appwarkey="in/careerpower/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	ranking)
		appwarname="test-ranking-service";
		appwarkey="in/careerpower/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	testseries)
		appwarname="testseries-wrapper";
		appwarkey="in/careerpower/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	timeline)
		appwarname="Timeline";
		appwarkey="in/careerpower/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	Video-Streaming-server)
		appwarname="video-service";
		appwarkey="org/springframework/boot/$appwarname/2.0.0.RELEASE/$appwarname-2.0.0.RELEASE.war";;
	store-elastic-search)
		appwarname="adda_package_search";
		appwarkey="com/adda/search/$appwarname/0.0.1-SNAPSHOT/$appwarname-0.0.1-SNAPSHOT.war";;
	storefront-user)
		appwarname="storefront-user";
		appwarkey="in/careerpower/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	storefront-admin)
		appwarname="storefront-admin";
		appwarkey="in/careerpower/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	coupon-admin)
		appwarname="coupon-admin";
		appwarkey="in/careerpower/coupon/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	couponadmin)
		appwarname="couponadmin";
		appwarkey="in/careerpower/coupon/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	newcouponadmin)
		appwarname="couponadmin";
		appwarkey="in/careerpower/coupon/$appwarname/2.0.0/$appwarname-2.0.0.war";;
	newcouponservice)
		appwarname="couponservice";
		appwarkey="in/careerpower/coupon/$appwarname/2.0.0/$appwarname-2.0.0.war";;
	couponservice)
		appwarname="coupon-service-web";
		appwarkey="in/careerpower/coupon/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	socialclient )
		appwarname="socialclient";
		appwarkey="in/careerpower/$appwarname/0.0.1/$appwarname-0.0.1.war";;
	bigservice)
		appwarname="bigservice";
		appwarkey="$appwarname-$branch.zip";;
	extraservice)
		appwarname="extraservice";
		appwarkey="$appwarname-$branch.zip";;
	mars)
		appwarname="exam-master";
		appwarkey="in/careerpower/mars/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	doubts)
		appwarname="doubts";
		appwarkey="in/careerpower/$appwarname/0.0.1/$appwarname-0.0.1.war";;
	*)
		unset appwarname;
		unset appwarkey;;
	esac
}


findAppPath()
{
	local app=$1
	case $app in
	userauth)
		gitpath=$gitHome"servercp/userauth";;
	paymentservice)
		gitpath=$gitHome"paymentservice";;
   	ytsearch)
        	gitpath=$gitHome"ytsearch";;
	bigservice)
		gitpath=$gitHome"deployment-scripts/bigservices";;
	extraservice)
		gitpath=$gitHome"deployment-scripts/extraservices";;
	common-parent)
		gitpath=$gitHome"servercp/commons-parent";;
	admin-panel-ui)
		gitpath=$gitHome"adminpaneluimaven";;
	analytics)
		gitpath=$gitHome"servercp/analytics";;
	appInstall)
		gitpath=$gitHome"servercp/appinstall";;
	admin-panel-commons)
		gitpath=$gitHome"admin-panel-commons";;
	contentadmin)
		gitpath=$gitHome"servercp/contentadmin";;
	crud)
		gitpath=$gitHome"crud";;
	commons)
		gitpath=$gitHome"commons";;
	erp-enquiry)
		gitpath=$gitHome"erp/erp-enquiry";;
	erp)
		gitpath=$gitHome"erp";;
	franchise)
		gitpath=$gitHome"franchise/franchise-webapp-war";;
	franchise-theme)
		gitpath=$gitHome"franchise/franchise-theme";;
	mailingservice)
		gitpath=$gitHome"servercp/mailing-service";;
	pushservice)
		gitpath=$gitHome"servercp/push-service";;
	ranking)
		gitpath=$gitHome"servercp/test-ranking/test-ranking-service";;
	testseries)
		gitpath=$gitHome"servercp/testseries";;
	timeline)
		gitpath=$gitHome"timeline-server";;
	magazines-service)
		gitpath=$gitHome"servercp/magazines";;
	articles-service)
		gitpath=$gitHome"servercp/articles";;
	capsules-service)
		gitpath=$gitHome"servercp/capsules";;
	currentaffairs-service)
		gitpath=$gitHome"servercp/currentaffairs";;
	jobalerts-service)
		gitpath=$gitHome"servercp/jobalerts";;
	youtube-videos-service)	
		gitpath=$gitHome"servercp/youtube-videos";;
	Video-Streaming-server)
		gitpath=$gitHome"server-video";;
	commons-parent)
		gitpath=$gitHome"servercp/commons-parent";;
	commons-auth-filters)
		gitpath=$gitHome"servercp/commons-parent/commons-auth-filters";;
	store-elastic-search)
		gitpath=$gitHome"adda_package_search";;
	storefront)
		gitpath=$gitHome"storefront";;
	storefront-user)
		gitpath=$gitHome"storefront/storefront-user";;
	storefront-admin)
		gitpath=$gitHome"storefront/storefront-admin";;
	coupon)
		gitpath=$gitHome"coupon";;
	coupon-admin)
		gitpath=$gitHome"coupon/coupon-admin";;
	couponadmin)
		gitpath=$gitHome"couponnew/couponadmin";;
	coupon-entities)
		gitpath=$gitHome"couponnew/coupon-entities";;
	couponcommons)
		gitpath=$gitHome"couponnew/couponcommons";;
	newcoupon)
		gitpath=$gitHome"couponnew";;
	newcouponadmin)
		gitpath=$gitHome"couponnew/coupon-admin";;
	newcouponservice)
		gitpath=$gitHome"couponnew/couponservice";;
	couponservice)
		gitpath=$gitHome"coupon/coupon-service-web";;
	storefront-jpa-entities)
		gitpath=$gitHome"storefront/storefront-jpa-entities";;
	storefront-core)
		gitpath=$gitHome"storefront/storefront-core";;
	socialclient )
		gitpath=$gitHome"socialclient";;	
	mars)
		gitpath=$gitHome"marsexammaster/admin";;
	mars-common-entities)
		gitpath=$gitHome"marsexammaster/common-entities";;
	mars-commons)
		gitpath=$gitHome"marsexammaster/commons";;
	adda247)
		gitpath=$gitHome"henosis";;
	beta-store)
		gitpath=$gitHome"web-store";;
	doubts)
		gitpath=$gitHome"doubts";;
	*) 
		unset gitpath;;
	esac
}


findDependency()
{
	local app=$1
	local brch=$2
	case $app in 
	mars)
		findAppPath mars-common-entities;
		buildPackage mars-common-entities $gitpath $brch;
		findAppPath mars-commons;
		buildPackage mars-commons $gitpath $brch;;
	userauth)
		findAppPath common-parent;
		buildPackage common-parent $gitpath $brch;;
	contentadmin)
		findAppPath admin-panel-commons;
		buildPackage admin-panel-commons $gitpath master; 
		findAppPath commons-parent;
		buildPackage commons-parent $gitpath master;;
	erp)
		findAppPath crud;
		buildPackage crud $gitpath master;
		findAppPath commons;
		buildPackage commons $gitpath master;;
	storefront-core)
		findAppPath commons;
        	buildPackage commons $gitpath master;;
	franchise)
		findAppPath franchise-theme;
		buildPackage franchise-theme $gitpath $brch;;
	storefront-user)
		findAppPath commons;
        	buildPackage commons $gitpath master;
		findAppPath commons-parent;
        	buildPackage commons-parent $gitpath master;
		findAppPath storefront-jpa-entities;
		buildPackage storefront-jpa-entities $gitpath $brch;
		findAppPath storefront-core;
		buildPackage storefront-core $gitpath $brch;;
	timeline)
		findAppPath commons-parent;
		buildPackage commons-parent $gitpath master;
		findAppPath magazines-service;
		buildPackage magazines-service $gitpath master; 
		findAppPath articles-service;
		buildPackage articles-service $gitpath master;
		findAppPath capsules-service;
		buildPackage capsules-service $gitpath master;
		findAppPath currentaffairs-service;
		buildPackage currentaffairs-service $gitpath master;
		findAppPath jobalerts-service;
		buildPackage jobalerts-service $gitpath master;
		findAppPath youtube-videos-service;
		buildPackage youtube-videos-service $gitpath master;
		findAppPath testseries;
		buildPackage testseries $gitpath master;;
	Video-Streaming-server)
		findAppPath commons-parent;
		buildPackage commons-parent $gitpath master;;
	store-elastic-search)
		findAppPath commons;
        	buildPackage commons $gitpath master;
		findAppPath commons-parent;
       		buildPackage commons-parent $gitpath master;
        	findAppPath storefront-jpa-entities;
        	buildPackage storefront-jpa-entities $gitpath master;		
		findAppPath storefront-core;
		buildPackage storefront-core $gitpath master;
		findAppPath commons-parent;
		buildPackage commons-parent $gitpath master;;
	coupon-admin)
		findAppPath coupon;
		buildPackage coupon $gitpath $brch;
		findAppPath commons-parent;
		buildPackage commons-parent $gitpath master;
		findAppPath admin-panel-commons;
		buildPackage admin-panel-commons $gitpath master;;
	newcouponadmin)
		findAppPath commons-parent;
		buildPackage commons-parent $gitpath master;
		findAppPath storefront-jpa-entities;
        	buildPackage storefront-jpa-entities $gitpath master;
        	findAppPath storefront-core;
        	buildPackage storefront-core $gitpath master;
		findAppPath admin-panel-commons;
		buildPackage admin-panel-commons $gitpath masterspringfix;
		findAppPath newcoupon;
        	buildPackage newcoupon $gitpath $brch;;
	couponservice)
		findAppPath commons-parent;
		buildPackage commons-parent $gitpath master;	
		findAppPath coupon;
		buildPackage coupon $gitpath $brch;;
	newcouponservice)
		findAppPath commons-parent;
		buildPackage commons-parent $gitpath master;
		findAppPath storefront-jpa-entities;
       		buildPackage storefront-jpa-entities $gitpath master;
        	findAppPath storefront-core;
        	buildPackage storefront-core $gitpath master;
		findAppPath newcoupon;
		buildPackage newcoupon $gitpath $brch;;
	pushservice)
		findAppPath commons-parent;
		buildPackage commons-parent $gitpath master;
		findAppPath admin-panel-commons;
		buildPackage admin-panel-commons $gitpath master;;
	ranking)
		findAppPath commons-parent;
		buildPackage commons-parent $gitpath master;;
	storefront-admin)
		findAppPath admin-panel-commons;
		buildPackage admin-panel-commons $gitpath master;
		findAppPath commons;
		buildPackage commons $gitpath master;
		findAppPath storefront;
		buildPackage storefront $gitpath $brch;;
	testseries)
		findAppPath commons-parent;
		buildPackage commons-parent $gitpath master;;			
	doubts)
		findAppPath commons;
                buildPackage commons $gitpath master;;
	socialclient)
                findAppPath commons-parent;
                buildPackage commons-parent $gitpath master;;
	*)
		echo "No Dependency packages needed";;
	esac
}

noteit()
{
	local prod="false";
	local sts="started";
	local bot="devops-bot.py";
	findEnvName $appname $arg5;
	if [ "$arg5" = "production" ]; then
		prod="true";
		bot="devops-bot-devops.py";
	fi
	mysql -u$dbuser -p$dbpass -h$dbhost $dbname -e "INSERT INTO $dbtable (\`time\`, \`appname\`, \`environment\`, \`branch\`, \`remark\`, \`versionlabel\`,\`user\`, \`isprod\`, \`status\` ) VALUES (now(), '$appname', '$envName', '$branch','$msg','$appname-$branch-$msg-$buildtime','$user','$prod','$sts')";
	groupmsg=$appname": Deployment of "$branch" branch started on "$envName".";
	python /home/ec2-user/devops/${bot} "${groupmsg}";
}

# verify application name is correct or not 
verifyAppName $appname;

case  $appname in
	beta-store)
		echo "Building package $appname from $branch branch ";
		env=$arg5;
	    	findAppPath $appname;
	    	cd $gitpath;
	    	git stash;
        	git fetch --all --tags --prune ;
	    	git checkout tags/$tag;	
		if [[ $? -ne 0 ]]; then
    			echo "Branch does not exist. Run again. Exiting"
        		exit $?
	    	fi
		git pull origin $branch;
	    	buildtime=$(timestamp);
		npm install;
		bower install;
		npm run build-prod;
		aws s3 sync webapp/assets/  s3://adda247-storefront/ --profile prod;
		exit 0;;
	ytsearch)
		echo "Building package $appname from $branch branch ";
		env=$arg5;
	    	findAppPath $appname;
	    	cd $gitpath;
	    	git stash;
	    	git fetch;
	    	git checkout $branch;
	    	if [[ $? -ne 0 ]]; then
        		echo "Branch does not exist. Run again. Exiting"
        		exit $?
     		fi
       		git pull origin $branch;
		buildtime=$(timestamp);
		#mv app/main.lua.${env} app/main.lua;
		#mv app/youtube.lua.${env} app/youtube.lua;
		zip ../$appname.zip -x *.git* -r * .[^.]* ;
		mv ../$appname.zip /home/ec2-user/.m2/repository/$appname-$branch-$msg-$buildtime.zip;
		aws s3 sync /home/ec2-user/.m2/repository s3://adda247-builds-repo --exclude "*" --include "*.war" --include "*.zip" --profile s3user
		find /home/ec2-user/.m2/repository/ -type f -name "*.zip" -exec rm -f {} \;

		# create application version.
		aws elasticbeanstalk create-application-version --application-name $appname --version-label "$appname-$branch-$msg-$buildtime" --description "automated build of $appname from $branch branch" --source-bundle S3Bucket="adda247-builds-repo",S3Key="$appname-$branch-$msg-$buildtime.zip";
		findEnvName $appname $arg5;
        	aws elasticbeanstalk update-environment --environment-name $envName --version-label "$appname-$branch-$msg-$buildtime";
        	if [[ $? -ne 0 ]]; then
                	echo "Environment Deploy Failed. Check again. Exiting";
                	exit $?
            	fi
            	noteit ;
		exit 0;;
	adda247)
		echo "Building package $appname from $branch branch ";
		env=$arg5;
 		findAppPath $appname;
		cd $gitpath;
		git stash;
		git fetch;
		git checkout $branch;
	    	if [[ $? -ne 0 ]]; then
	    		echo "Branch does not exist. Run again. Exiting"
        		exit $?
  	    	fi
		git pull origin $branch;
		buildtime=$(timestamp);
		#npm install;
		if [ "$env" = "alpha" ]; then
			npm run production;
		else
			npm run $env;
		fi
		zip -x *.git* -r adda247-unity * .[^.]*
		mv adda247-unity.zip  /home/ec2-user/.m2/repository/$appname-$branch-$env-$buildtime.zip;
        	aws s3 sync /home/ec2-user/.m2/repository s3://adda247-builds-repo --exclude "*" --include "*.war" --include "*.zip" --profile s3user;
        	rm -f /home/ec2-user/.m2/repository/*.zip;
       		rm -f /home/ec2-user/.m2/repository/*.war;
        	aws elasticbeanstalk create-application-version --application-name $appname --version-label "$appname-$branch-$msg-$buildtime" --description "automated build of $appname from $branch branch using $env configuration" --source-bundle S3Bucket="adda247-builds-repo",S3Key="$appname-$branch-$env-$buildtime.zip";
		findEnvName $appname $arg5;
		if [ ! -z "$envName" ];then
        		while [ `aws elasticbeanstalk describe-environment-health --environment-name $envName --attribute-names All --query 'Status' --output=text` != "Ready" ]
                	do
                        	sleep 5;
                	done
        		aws elasticbeanstalk update-environment --environment-name $envName --version-label "$appname-$branch-$msg-$buildtime";
        		if [[ $? -ne 0 ]]; then
                		echo "Environment Deploy Failed. Check again. Exiting";
                		exit $?
        		fi
		else
        		echo "No Environment mapped to deploy automatic ";
        		exit 1;
		fi
		noteit;
		exit 0;;	
	bigservice)
        	echo "Building package $appname from $branch branch ";
        	cd $gitHome/servercp/bigservices;
        	git stash;
        	git fetch;
	    	git checkout master;
        	if [[ $? -ne 0 ]]; then
        		echo "Branch does not exist. Run again. Exiting";
        		exit $?
        	fi
        	git pull origin master;
		rm -rf $gitHome/{temp,bundle};
		mkdir $gitHome/{temp,bundle};
		cd $gitHome/temp;
		git clone git@github.com:metiseduventures/servercp.git;
        	cd $gitHome/temp/servercp;
        	git checkout $branch;
        	if [[ $? -ne 0 ]]; then
        		echo "Branch does not exist. Run again. Exiting";
        		exit $?
        	fi
        	git pull origin $branch;
		cp $gitHome/servercp/bigservices/pom.xml $gitHome/temp/servercp/;
		/usr/local/src/apache-maven/bin/mvn clean install;
		if [[ $? -ne 0 ]]; then
        		echo "Build Failed. Check code again. Exiting";
         		exit $?
        	fi
		cp $gitHome/temp/servercp/ebooks/ebooks-service/target/ebooks-service-1.0.0.war.original $gitHome/bundle/ebooks.war;
		cp $gitHome/temp/servercp/currentaffairs/currentaffairs-wrapper/target/currentaffairs-wrapper-1.0.0.war.original $gitHome/bundle/currentaffairs.war;
		cp $gitHome/temp/servercp/testseries/testseries-wrapper/target/testseries-wrapper-1.0.0.war.original $gitHome/bundle/testseries.war;
		cp $gitHome/temp/servercp/articles/articles-wrapper/target/articles-wrapper-1.0.0.war.original $gitHome/bundle/articles.war;
		cp $gitHome/temp/servercp/jobalerts/jobalerts-wrapper/target/jobalerts-wrapper-1.0.0.war.original $gitHome/bundle/jobalerts.war;
		cp $gitHome/temp/servercp/magazines/magazines-wrapper/target/magazines-wrapper-1.0.0.war.original $gitHome/bundle/magazines.war;
		cp $gitHome/temp/servercp/capsules/capsules-wrapper/target/capsules-wrapper-1.0.0.war.original $gitHome/bundle/capsules.war;
		cp $gitHome/temp/servercp/alerts/alerts-wrapper/target/alerts-wrapper-1.0.0.war.original $gitHome/bundle/alerts.war;
		cp $gitHome/temp/servercp/GlobalConfig/target/GlobalConfig-1.0.0.war $gitHome/bundle/GlobalConfig.war;
		cp $gitHome/temp/servercp/youtube-videos/youtube-videos-wrapper/target/youtube-videos-wrapper-1.0.0.war.original $gitHome/bundle/youtube-videos.war;
		cp $gitHome/temp/servercp/bookmarks/target/bookmarks-1.0.0.war.original $gitHome/bundle/bookmarks.war;
		cp -r $gitHome/servercp/bigservices/.ebextensions $gitHome/bundle/
		cd $gitHome/bundle;
		buildtime=$(timestamp);
		findAppWarName $appname;
		zip -r bigservice-$branch.zip ebooks.war currentaffairs.war testseries.war articles.war jobalerts.war magazines.war capsules.war alerts.war GlobalConfig.war youtube-videos.war bookmarks.war .ebextensions
		cp $gitHome/bundle/bigservice-$branch.zip /home/ec2-user/.m2/repository/$appwarname-$branch-$buildtime.zip;
		aws s3 sync /home/ec2-user/.m2/repository s3://adda247-builds-repo --exclude "*" --include "*.war" --include "*.zip" --profile s3user;
		find /home/ec2-user/.m2/repository/ -type f -name "*.war" -exec rm -f {} \;
		aws elasticbeanstalk create-application-version --application-name $appname --version-label "$appname-$branch-$msg-$buildtime" --description "automated build of $appname from $branch branch" --source-bundle S3Bucket="adda247-builds-repo",S3Key="$appwarname-$branch-$buildtime.zip";
        	findEnvName $appname $arg5;
        	aws elasticbeanstalk update-environment --environment-name $envName --version-label "$appname-$branch-$msg-$buildtime";
        	if [[ $? -ne 0 ]]; then
            		echo "Environment Deploy Failed. Check again. Exiting";
            		exit $?
        	fi
            	noteit ;
		exit 0;;
	extraservice)
		echo "Building package $appname from $brnch branch ";
		cd $gitHome/servercp/extraservices;
		git stash;
		git fetch;
		git checkout master;
		if [[ $? -ne 0 ]]; then
    			echo "Branch does not exist. Run again. Exiting";
    			exit $?
		fi
		git pull origin master;
		rm -rf $gitHome/{temp,bundle};
		mkdir $gitHome/{temp,bundle};
		cd $gitHome/temp;
		git clone git@github.com:metiseduventures/servercp.git;
		cd $gitHome/temp/servercp;
		git checkout $branch;
        	if [[ $? -ne 0 ]]; then
        		echo "Branch does not exist. Run again. Exiting";
           	 	exit $?
        	fi
		git pull origin $brnch;
		cp $gitHome/servercp/extraservices/pom.xml $gitHome/temp/servercp/;
		/usr/local/src/apache-maven/bin/mvn clean install;
        	if [[ $? -ne 0 ]]; then
        		echo "Build Failed. Check code again. Exiting";
            		exit $?
        	fi
		cp $gitHome/temp/servercp/useranalytics/useranalytics-service/target/useranalytics-service-1.0.0.war.original $gitHome/bundle/analytics.war;
		cp $gitHome/temp/servercp/miscellaneous/miscellaneous-service/target/miscellaneous-service-1.0.0.war $gitHome/bundle/miscellaneous.war;
		cp $gitHome/temp/servercp/appConfig/target/appConfig-1.0.0.war.original $gitHome/bundle/appConfig.war;
		cp $gitHome/temp/servercp/paymentstatus/target/paymentstatus-1.4.2.RELEASE.war.original $gitHome/bundle/paymentstatus.war;
		cp -r $gitHome/servercp/extraservices/.ebextensions $gitHome/bundle/
	 	cd $gitHome/bundle;
		buildtime=$(timestamp);
		findAppWarName $appname;
		zip -r extraservice-$branch.zip appConfig.war analytics.war miscellaneous.war paymentstatus.war .ebextensions
		cp $gitHome/bundle/extraservice-$branch.zip /home/ec2-user/.m2/repository/$appwarname-$branch-$buildtime.war;;		
	*)
		#build dependency packages 
		findDependency $appname $branch;
		#main package build
		findAppPath $appname;
		buildPackage $appname $gitpath $branch;
		findAppWarName $appname;
		buildtime=$(timestamp);
		mv /home/ec2-user/.m2/repository/$appwarkey /home/ec2-user/.m2/repository/$appwarname-$branch-$buildtime.war;;
esac


# sync war files to s3 bucket (s3://adda247-builds-repo)
aws s3 sync /home/ec2-user/.m2/repository s3://adda247-builds-repo --exclude "*" --include "*.war" --include "*.zip" --profile s3user
find /home/ec2-user/.m2/repository/ -type f -name "*.war" -exec rm -f {} \;

# create application version 
if [ "$appname" = "newcouponadmin" ]; then
	appnametwist="coupon-admin";
elif [ "$appname" = "newcouponservice" ]; then
	appnametwist="couponservice";
else
	appnametwist=$appname;
fi

aws elasticbeanstalk create-application-version --application-name $appnametwist --version-label "$appname-$branch-$msg-$buildtime" --description "automated build of $appname from $branch branch" --source-bundle S3Bucket="adda247-builds-repo",S3Key="$appwarname-$branch-$buildtime.war";

findEnvName $appname $arg5;
if [ ! -z "$envName" ];then
	while [ `aws elasticbeanstalk describe-environment-health --environment-name $envName --attribute-names All --query 'Status' --output=text` != "Ready" ]
		do
			sleep 5;
		done
	aws elasticbeanstalk update-environment --environment-name $envName --version-label "$appname-$branch-$msg-$buildtime";
	if [[ $? -ne 0 ]]; then
    		echo "Environment Deploy Failed. Check again. Exiting";
    		exit $?
	fi
else
	echo "No Environment mapped to deploy automatic ";
	exit 1;
fi
noteit;
