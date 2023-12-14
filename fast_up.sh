#!/bin/bash

aws ec2 run-instances --image-id ami-053b0d53c279acc90 --count 1 --instance-type t2.micro --key-name key-first --security-group-ids sg-0b763d3f870f058ae --user-data file://script.sh
