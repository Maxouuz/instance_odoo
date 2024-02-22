#!/bin/bash

#On remove les saves des anciennes instances
rm -rf /home/maxence/Documents/school/sae6/save_sql/*

#on va dans le dossier terraform
cd /home/maxence/Documents/school/sae6/terraform/

#Destroy infrastructure
terraform destroy