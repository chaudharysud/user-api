#!/bin/sh
# Creation of userapp-service menifiest

#introducing sleep to ensure after deletion port is not in use
sleep 10

/home/ec2-user/bin/kubectl apply -f ~/app/userApp-service.yml
