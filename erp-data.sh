#!/bin/bash

HOST="erpdb-prod-slave.cgit7qfnncrf.us-east-1.rds.amazonaws.com"
USER="prodteam"
PASS="v{u~)qbZC@kG3yn("
DB="erp"

ENQUIRY="enquiry.csv"
ADMISSION="admission.csv"
CALLBACK="enquiry_callback.csv"

sdate=$(date '+%Y-%m-01')
echo $sdate

EMAILS="piyush.dubey@adda247.com pramod.patil@adda247.com sneha.gangwar@adda247.com"
#EMAILS="pramod.patil@adda247.com"

QUERY1="select es.name,es.phoneNo, e.centerId,c.branchName,e.createdAt from enquiry e inner join enquiryStudent es
on e.enquiryStudentId = es.id  inner join center c on c.id = e.centerId
where e.createdAt >= '$sdate' order by c.id"

#echo $QUERY1
QUERY2="select s.name, s.phoneNo, c.id as centerId,c.branchName, a.id as admissionId, a.createdAt from admission a inner join
student s on a.studentId = s.id inner join center c on a.centerId = c.id
where  a.createdAt >= '$sdate' order by a.centerId"

QUERY3="select e.createdAt,phoneNo,centerId,c.branchName from enquiryCallback e
inner join center c on e.centerId = c.id
where e.createdAt >= '$sdate' order by centerId"


mysql -h $HOST -u $USER -p$PASS -D $DB -e "$QUERY1" > "$ENQUIRY"
mysql -h $HOST -u $USER -p$PASS -D $DB -e "$QUERY2" > "$ADMISSION"
mysql -h $HOST -u $USER -p$PASS -D $DB -e "$QUERY3" > "$CALLBACK"


uuencode "$ENQUIRY" "$ENQUIRY" | mail -s "ERP Data" $EMAILS
uuencode "$ADMISSION" "$ADMISSION" | mail -s "ERP Data" $EMAILS
uuencode "$CALLBACK" "$CALLBACK" | mail -s "ERP Data" $EMAILS

