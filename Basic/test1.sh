#!/bin/bash

# Define the file path
file_path="/jumpbox/apache-tomcat/webapps/ec2box/WEB-INF/classes/EC2BoxConfig.properties"

# Define the new values
new_awsProtocol="awsProtocol=http"
new_awsProxyHost="awsProxyHost=squid-frontend-int-elb.am-preview.sony.local."
new_awsProxyPort="awsProxyPort=80"

# Update the specified lines in the file
awk -v new_protocol="new_awsProtocol" -v new_host="$new_awsProxyHost" -v new_port="$new_awsProxyPort" '
{
    if ($1 == "awsProxyHost=" && $2 == "") {
        print new_host
    } else if ($1 == "awsProxyPort=" && $2 == "") {
        print new_port
    } else {
        print $0
    }
}' EC2BoxConfig.properties > EC2BoxConfig.properties.tmp

# Replace the original file with the updated content
mv "$file_path.tmp" "$file_path"
