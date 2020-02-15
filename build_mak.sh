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
msg="build-script-mak";
user="devops";
customBuild=false;
dbhost="localhost";
dbuser="heartprairy";
dbpass="cbbmc33JYQE5";
dbname="devops";
dbtable="deployments";
timemark='date +"%F %T"';

if [ ! -z "$arg5" ];then
	msg="$msg-$arg5";
fi

#functions
noteit()
{
	local prod="false";
	local sts="started";
	if [ "$arg5" = "production" ]; then
		prod="true";
		sts="manual";
	fi
	mysql -u$dbuser -p$dbpass -h$dbhost $dbname -e "INSERT INTO $dbtable (\`time\`, \`appname\`, \`environment\`, \`branch\`, \`remark\`, \`versionlabel\`,\`user\`, \`isprod\`, \`status\` ) VALUES (now(), '$appname', '$envName', '$branch','$msg','$appname-$branch-$msg-$buildtime','$user','$prod','$sts')";
	groupmsg=$appname": Deployment of "$branch" branch started on "$envName".";
	python /home/ec2-user/devops/devops-bot.py "${groupmsg}";
}

verifyAppName()
{
	local app=$1;
	case "$app" in
		erp | userauth | bigservice | analytics | appInstall | contentadmin | franchise | mailingservice | pushservice | ranking | testseries | timeline | Video-Streaming-server | store-elastic-search | coupon-admin | couponservice | extraservice | socialapi | newcouponadmin | ytsearch | newcouponservice ) 
		;;

		admin-panel-ui | storefront-user | storefront-admin )
		if [ -z "$arg5" ]; then
			echo "You have not selected environment for which you are building\n usage: build.sh -a applicationName [-b branchName] environment";
			exit 1;
		else
			case "$arg5" in
				staging1 | staging2 | stagingv | alpha | beta | qa1 )
				customBuild=true;
				;;
				production)
				;;
				*)
				echo "invalid environment (valid: staging1,staging2,stagingv,production)";
				exit 1
			esac
		fi;;

		unity ) 
		if [ -z "$arg5" ]; then
			echo "Making unity build for staging environment";
			arg5="staging";
		else 
			case "$arg5" in
				staging | production )
					echo "making unity build using $arg5 properties";;
				*)
					echo "Invalid Argument No 5 | Valid Values [staging/production]";
					exit 1
				esac
		fi;;
		beta-store )
        	if [ -z "$arg5" ]; then
            	echo "Making beta-store build for staging environment";
                arg5="staging";
            else
            	case "$arg5" in
                	staging )
						if [ -z "$tag" ]; then
							echo "Tag not provided";
							echo "usage : build.sh -a beta-store -b <branch> staing -t <tag>";
							exit 1;
						fi
						echo "making unity build using $arg5 properties";;
                    *)
                        echo "Invalid Argument No 5 | Valid Values [staging/production]";
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
		elif [ "$arg5" = "qa1" ]; then
			envName="userauthqa1";
		fi;;
	ytsearch )
		if [ "$args" = "staging" ]; then
			envName="ytsearch-staging";
		fi ;;
	adda247 )
		if [ "$args" = "staging" ]; then
			envName="adda247-stagingadda247";
		fi ;;
	adda247-unity )
		if [ "$args" = "staging" ]; then
			envName="Adda247Unity-env-staging";
		fi ;;
	admin-panel-ui )
		if [ "$arg5" = "staging1" ] ;then
			envName="stagingadminui";
		elif [ "$arg5" = "staging2" ]; then
			envName="stagingadminui2";
		elif [ "$arg5" = "stagingv" ]; then
			envName="stagingadminuiv";
		elif [ "$arg5" = "qa1" ]; then
			envName="adminuiqa1";
		fi;;
	analytics )
		if [ "$arg5" = "staging" ]; then
			envName="analyticsstaging";
		elif [ "$arg5" = "qa1" ]; then
			envName="analyticsqa1";
		fi;;
	bigservice )
		if [ "$arg5" = "staging" ]; then
			envName="bigservice-stag-env";
		elif [ "$arg5" = "qa1" ]; then
			envName="bigserviceqa1";
		fi;;
	contentadmin )
		if [ "$arg5" = "staging" ]; then
			envName="contentadmin-stag1-env";
		elif [ "$arg5" = "qa1" ]; then
			envName="contentadminqa1";
		fi;;
	newcouponadmin )
		if [ "$arg5" = "staging" ]; then
			envName="newcouponadminstaging";
		fi;;	
	newcouponservice )
		if [ "$arg5" = "staging" ]; then
			envName="newcouponservicestaging";
		fi;;	
	coupon-admin )
		if [ "$arg5" = "staging" ]; then
			envName="CouponAdminStaging";
		elif [ "$arg5" = "qa1" ]; then
			envName="couponadminqa1";
		fi;;
	couponservice )
		if [ "$arg5" = "staging" ]; then
			envName="CouponServiceStaging";
		elif [ "$arg5" = "qa1" ]; then
			envName="couponserviceqa1";
		fi;;
	erp )
		if [ "$arg5" = "staging" ]; then
          	envName="erpstaging";
		elif [ "$arg5" = "qa1" ]; then
			envName="erpqa1";
		fi;;
	extraservice )
		if [ "$arg5" = "staging" ]; then
			envName="extraservice-staging-env";
		elif [ "$arg5" = "qa1" ]; then
			envName="extraserviceqa1";
		fi;;
	franchise )
		if [ "$arg5" = "staging" ]; then
			envName="franchise-stag-env";
		elif [ "$arg5" = "qa1" ]; then
			envName="franchiseqa1";
		fi;;
	pushservice )
		if [ "$arg5" = "staging" ]; then
			envName="pushservice-stag-env";
		elif [ "$arg5" = "qa1" ]; then
			envName="pushserviceqa1";
		fi;;
	ranking )
		if [ "$arg5" = "staging" ]; then
			envName="ranking-stag-env";
		elif [ "$arg5" =  "qa1" ]; then
			envName="rankingqa1";
		fi;;
	store-elastic-search )
		if [ "$arg5" = "staging" ]; then
			envName="StoreElasticSearchStaging";
		elif [ "$arg5" = "qa1" ]; then
			envName="storeelasticsearchqa1";
		fi;;
	storefront-admin )
		if [ "$arg5" = "staging1" ]; then
			envName="StoreFrontAdminStaging1";
		elif [ "$arg5" = "staging2" ]; then
			envName="StoreFrontAdminStaging2";
		elif [ "$arg5" = "stagingv" ]; then
			envName="StoreFrontAdminStagingv";
		elif [ "$arg5" = "qa1" ]; then
			envName="storefrontadminqa1";
		fi;;
	storefront-user )
		if [ "$arg5" = "staging1" ]; then
			envName="stagingstoreuser1";
		elif [ "$arg5" = "staging2" ]; then
			envName="stagingstoreuser2";
		elif [ "$arg5" = "stagingv" ]; then
			envName="stagingstoreuser-v";
		elif [ "$arg5" = "qa1" ]; then
			envName="storefrontuserqa1";
		fi;;
	testseries )
		if [ "$arg5" = "staging" ]; then
			envName="testseriesstaging";
		elif [ "$arg5" = "qa1" ]; then
			envName="testseriesqa1";
		fi;;
	timeline )
		if [ "$arg5" = "staging" ]; then
			envName="Timeline-stag-env";
		elif [ "$arg5" = "qa1" ]; then
			envName="timelineqa1";
		fi;;
	Video-Streaming-server )
		if [ "$arg5" = "staging" ]; then
			envName="VideoStreamingServer-stag-env";
		elif [ "$arg5" = "qa1" ]; then
			envName="videostreamingqa1";
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
		/usr/local/src/apache-maven/bin/mvn clean install -Denv.name=$arg5
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
		appwarkey="in/careerpower/$appwarname/1.5.6.RELEASE/$appwarname-1.5.6.RELEASE.war";;
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
		appwarkey="org/springframework/boot/$appwarname/1.4.4.RELEASE/$appwarname-1.4.4.RELEASE.war";;
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
	newcouponadmin)
		appwarname="coupon-admin";
		appwarkey="in/careerpower/coupon/$appwarname/2.0.0/$appwarname-2.0.0.war";;
	newcouponservice)
		appwarname="coupon-service-web";
		appwarkey="in/careerpower/coupon/$appwarname/2.0.0/$appwarname-2.0.0.war";;
	couponservice)
		appwarname="coupon-service-web";
		appwarkey="in/careerpower/coupon/$appwarname/1.0.0/$appwarname-1.0.0.war";;
	socialapi)
		appwarname="socialclient";
		appwarkey="in/careerpower/$appwarname/0.0.1/$appwarname-0.0.1.war";;
	bigservice)
		appwarname="bigservice";
		appwarkey="$appwarname-$branch.zip";;
	extraservice)
		appwarname="extraservice";
		appwarkey="$appwarname-$branch.zip";;
	suggest)
		appwarname="suggest";
		appwarkey="in/careerpower/$appwarname/$appwarname/1.0.0/$appwarname-1.0.0.war";;
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
	coupon-entities)
		gitpath=$gitHome"couponnew/coupon-entities";;
	coupon-commons)
		gitpath=$gitHome"couponnew/coupon-commons";;
	newcoupon)
		gitpath=$gitHome"couponnew";;
	newcouponadmin)
		gitpath=$gitHome"couponnew/coupon-admin";;
	newcouponservice)
		gitpath=$gitHome"couponnew/coupon-service-web";;
	couponservice)
		gitpath=$gitHome"coupon/coupon-service-web";;
	storefront-jpa-entities)
		gitpath=$gitHome"storefront/storefront-jpa-entities";;
	storefront-core)
		gitpath=$gitHome"storefront/storefront-core";;
	socialapi)
		gitpath=$gitHome"socialclient";;
	suggest)
		gitpath=$gitHome"suggest";;
	unity)
		gitpath=$gitHome"adda247-unity";;
	beta-store)
		gitpath=$gitHome"web-store";;
	*) 
		unset gitpath;;
	esac
}


findDependency()
{
	local app=$1
	local brch=$2
	case $app in 
	userauth)
		findAppPath common-parent;
		buildPackage common-parent $gitpath $brch;;
	contentadmin)
		findAppPath admin-panel-commons;
		buildPackage admin-panel-commons $gitpath masterspringfix; 
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
		buildPackage magazines-service $gitpath masterspringfix; 
		findAppPath articles-service;
		buildPackage articles-service $gitpath masterspringfix;
		findAppPath capsules-service;
		buildPackage capsules-service $gitpath masterspringfix;
		findAppPath currentaffairs-service;
		buildPackage currentaffairs-service $gitpath masterspringfix;
		findAppPath jobalerts-service;
		buildPackage jobalerts-service $gitpath masterspringfix;
		findAppPath youtube-videos-service;
		buildPackage youtube-videos-service $gitpath masterspringfix;
		findAppPath testseries;
		buildPackage testseries $gitpath masterspringfix;;
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
        buildPackage storefront-jpa-entities $gitpath newcoupon;
        findAppPath storefront-core;
        buildPackage storefront-core $gitpath newcoupon;
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
	*)
		echo "No Dependency packages needed";;
	esac
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
		zip ../$appname.zip -x *.git* -r * .[^.]* ;
		mv ../$appname.zip /home/ec2-user/.m2/repository/$appname-$branch-$msg-$buildtime.zip;
		aws s3 sync /home/ec2-user/.m2/repository s3://adda247-builds-repo --exclude "*" --include "*.war" --include "*.zip" --profile s3user
		find /home/ec2-user/.m2/repository/ -type f -name "*.zip" -exec rm -f {} \;

		# create application version.
		aws elasticbeanstalk create-application-version --application-name $appname --version-label "$appname-$branch-$msg-$buildtime" --description "automated build of $appname from $branch branch" --source-bundle S3Bucket="adda247-builds-repo",S3Key="$appname-$branch-$msg-$buildtime.zip";
		findEnvName $appname $arg5;
		echo $envName;
        aws elasticbeanstalk update-environment --environment-name ytsearch-staging --version-label "$appname-$branch-$msg-$buildtime";
        if [[ $? -ne 0 ]]; then
        	echo "Environment Deploy Failed. Check again. Exiting";
            exit $?
        fi
        noteit ;
		exit 0;;
	unity)
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
		npm i
		nvm install v10.16.1
		nvm use 10.16.1
		NODE_ENV=${env} yarn run build -- --release
		echo "Adding proxy config ${env}"
		mv -f .ebextensions/${env} .ebextensions/proxy.config
		cp -r .ebextensions build/
		cd build/
		zip -x *.git* -r adda247-unity * .[^.]*
		mv adda247-unity.zip  /home/ec2-user/.m2/repository/$appname-$branch-$env-$buildtime.zip;
        aws s3 sync /home/ec2-user/.m2/repository s3://adda247-builds-repo --exclude "*" --include "*.war" --include "*.zip" --profile s3user;
        rm -f /home/ec2-user/.m2/repository/*.zip;
        rm -f /home/ec2-user/.m2/repository/*.war;
        aws elasticbeanstalk create-application-version --application-name adda247-$appname --version-label "$appname-$branch-$env-$buildtime" --description "automated build of $appname from $branch branch using $env configuration" --source-bundle S3Bucket="adda247-builds-repo",S3Key="$appname-$branch-$env-$buildtime.zip";
        aws elasticbeanstalk update-environment --environment-name Adda247Unity-env-staging --version-label "$appname-$branch-$env-$buildtime";
		if [[ $? -ne 0 ]]; then
        	echo "Environment Deploy Failed. Check again. Exiting";
            exit $?
        fi
        noteit ;
		exit 0;;	
	bigservice)
        echo "Building package $appname from $branch branch ";
        cd $gitHome/deployment-scripts/bigservices;
        git stash;
        git fetch;
	    git checkout dev;
        if [[ $? -ne 0 ]]; then
        	echo "Branch does not exist. Run again. Exiting";
            exit $?
        fi
        git pull origin dev;
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
		cp $gitHome/deployment-scripts/bigservices/pom.xml $gitHome/temp/servercp/;
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
	 	cd $gitHome/bundle;
		buildtime=$(timestamp);
		findAppWarName $appname;
		zip -r bigservice-$branch.zip ebooks.war currentaffairs.war testseries.war articles.war jobalerts.war magazines.war capsules.war alerts.war GlobalConfig.war youtube-videos.war bookmarks.war
		cp $gitHome/bundle/bigservice-$branch.zip /home/ec2-user/.m2/repository/$appwarname-$branch-$buildtime.zip;
		aws s3 sync /home/ec2-user/.m2/repository s3://adda247-builds-repo --exclude "*" --include "*.war" --include "*.zip" --profile s3user;
		find /home/ec2-user/.m2/repository/ -type f -name "*.war" -exec rm -f {} \;
		aws elasticbeanstalk create-application-version --application-name $appname --version-label "$appname-$branch-$msg-$buildtime" --description "automated build of $appname from $branch branch" --source-bundle S3Bucket="adda247-builds-repo",S3Key="$appwarname-$branch-$buildtime.zip";
        aws elasticbeanstalk update-environment --environment-name bigservice-stag-env --version-label "$appname-$branch-$msg-$buildtime";
        if [[ $? -ne 0 ]]; then
        	echo "Environment Deploy Failed. Check again. Exiting";
            exit $?
        fi
        noteit;
        exit 0;;
	extraservice)
		echo "Building package $appname from $brnch branch ";
		cd $gitHome/deployment-scripts/extraservices;
		git stash;
		git fetch;
		git checkout dev;
		if [[ $? -ne 0 ]]; then
    		echo "Branch does not exist. Run again. Exiting";
    		exit $?
		fi
		git pull origin $brnch;
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
		cp $gitHome/deployment-scripts/extraservices/pom.xml $gitHome/temp/servercp/;
		/usr/local/src/apache-maven/bin/mvn clean install;
        if [[ $? -ne 0 ]]; then
        	echo "Build Failed. Check code again. Exiting";
            exit $?
        fi
		cp $gitHome/temp/servercp/useranalytics/useranalytics-service/target/useranalytics-service-1.0.0.war.original $gitHome/bundle/analytics.war;
		cp $gitHome/temp/servercp/miscellaneous/miscellaneous-service/target/miscellaneous-service-1.0.0.war $gitHome/bundle/miscellaneous.war;
		cp $gitHome/temp/servercp/appConfig/target/appConfig-1.0.0.war.original $gitHome/bundle/appConfig.war;
		cp $gitHome/temp/servercp/paymentstatus/target/paymentstatus-1.4.2.RELEASE.war.original $gitHome/bundle/paymentstatus.war;
	 	cd $gitHome/bundle;
		buildtime=$(timestamp);
		findAppWarName $appname;
		zip -r extraservice-$branch.zip appConfig.war analytics.war miscellaneous.war paymentstatus.war 
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


# sync war files to s3 bucket (s3://adda247-builds)
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
# update application when staging

findEnvName $appname $arg5;
case "$arg5" in
	staging1 | staging2 | stagingv | alpha | beta | qa1 | staging )
		aws elasticbeanstalk update-environment --environment-name $envName --version-label "$appname-$branch-$msg-$buildtime";
		if [[ $? -ne 0 ]]; then
        	echo "Environment Deploy Failed. Check again. Exiting";
        	exit $?
        fi
		noteit ;;
        *)
        echo "Please deploy new build with label $appname-$branch-$msg-$buildtime to application manually";;
esac
