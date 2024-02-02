Set-AWSCredential

aws configure

input the information asked for
Accesskey
Secretkey


aws configure list - will show user AWS CLI configuration. 



Set-AWSCredential -AccessKey AKIASZC5LAK5BNPDFKPH -SecretKey YO6QZ+pODZ3Bbu1S6soHQhgBS48YA7YnnaS5tMXW -StoreAs jimmy.johannsen

aws --version

aws help config-vars - This is where you find the GOLD about variables

example: aws s3 help

Description
***********

This section explains prominent concepts and notations in the set of
high-level S3 commands provided.


Path Argument Type
==================

Whenever using a command, at least one path argument must be
specified.  There are two types of path arguments: "LocalPath" and
"S3Uri".

"LocalPath": represents the path of a local file or directory.  It can
be written as an absolute path or relative path.

"S3Uri": represents the location of a S3 object, prefix, or bucket.
This must be written in the form "s3://mybucket/mykey" where
"mybucket" is the specified S3 bucket, "mykey" is the specified S3
key.  The path argument must begin with "s3://" in order to denote
that the path argument refers to a S3 object. Note that prefixes are
separated by forward slashes. For example, if the S3 object "myobject"
had the prefix "myprefix", the S3 key would be "myprefix/myobject",
and if the object was in the bucket "mybucket", the "S3Uri" would be
"s3://mybucket/myprefix/myobject".

-- More  --

Create and delete S3 Bucket

New-S3Bucket -BucketName summersite-example -Region us-east-1
remove-s3bucket -bucketname summersite-example

list buckets
aws s3api list-buckets --query "Buckets[].Name"

copy to S3 bucket
aws s3 cp "E:\GoProData\Import\2019-05-14\HERO4 Silver Cam1\gp020159.mp4" s3://2018summersite

Delete from bucket
aws s3 rm s3://2018summersite/dog.jpg/
Get-S3Object -BucketName YOUR_BUCKET | % { Remove-S3Object -BucketName YOUR_BUCKET -Key $_.Key -Force:$true }

Security group

aws ec2 create-security-group --group-name my-sg --description "My security group"
aws ec2 delete-security-group --group-name my-sg

Create Website in existing bucket
Write-S3BucketWebsite -BucketName 2018summersite -WebsiteConfiguration_IndexDocumentSuffix in
dex.html -WebsiteConfiguration_ErrorDocument error.html