# OWASP Threat Dragon - AWS Ansible/Cloudformation Deploy Scripts
Cloudformation JSON and Ansible Playbook to install all pre-requisites and the latest, production version of OWASP Threat Dragon on an AWS AMI EC2 instance.

## Background

OWASP Threat Dragon is an online threat modelling application which is based [here](https://github.com/mike-goodwin/owasp-threat-dragon).  This project aims to provide a simple way to install Threat Dragon into AWS.

## Prerequisites

* A *nix based computer to run the Bash glue scripts on.
* An AWS account is required, with a user already created and configured. (Complete with keys and IAM permissions for creating Cloudformation Stacks and EC2 Instances.)
* Ansible needs to be installed and configured correctly.  Information about the installation of Ansible can be found [here](http://docs.ansible.com/ansible/intro_installation.html).
* A [GitHub](https://github.com) Account.
* AWS CLI needs to be installed and configured correctly.  Information about the installation of Ansible can be found [here](http://docs.aws.amazon.com/cli/latest/userguide/installing.html).
* A Free [Microsoft Azure account](https://account.windowsazure.com/signup).  At the moment Threat Dragon requires 'Azure Table Storage' to run.  There is no alternative at the moment but to use this, but I am working on a fully native AWS solution as soon as possible.
*

## How to Deploy

1) The first thing that needs to be done is run the Cloudformation script which sets up the infrastructure.  You will need your external IP address, What Availability Zone you want the EC2 instance installed in and the name of your IAM key pair;
> run-cf-td.sh build

2) Once the infrastructure is set up and the instance is running, you can run the Ansible script to install Threat Dragon.  For this, you will need to obtain the Public IP address of the EC2 instance.

3) Store the Public IP address of the EC2 Instance in **/etc/ansible/hosts** as shown below;
> [aws]
> 52.48.40.235

4) Change directory to the location of the **deploy_td.yaml** file.

5) Run;
> ansible-playbook deploy_td.yaml --inventory-file=/etc/ansible/hosts -u ec2-user --key-file=aws_key.pem --sudo

6) Essentially, that should take care of the installation.  Simply SSH onto the EC2 instance, cd to **/home/ec2-user/owasp-threat-dragon/** and run;

> npm start