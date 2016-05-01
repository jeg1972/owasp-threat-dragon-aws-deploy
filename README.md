# OWASP Threat Dragon - AWS Ansible Deploy Script
Ansible Playbook to install all pre-requisites and the latest, production version of OWASP Threat Dragon on an AWS AMI EC2 instance.

**Pre-requisites**   
It requires the following pre-requisites to be already set up;    
* A valid AWS EC2 instance must be running with a Public IP address (If you just want to try it out, it will run on a t2.micro instance.  It is up to you to sort out the correct IAM role and Security Group etc.)   
* A working Ansible Provisioner

**How to Deploy**   
It's a very simple method;   
1) Make sure you have port 22 enabled in the Security Group of the EC2 Instance so that Ansible can connect.   
2) Store the Public IP address of the EC2 Instance in **/etc/ansible/hosts** as shown below;   
> [aws]   
> 52.48.40.235   

3) Change directory to the location of the **deploy_td.yaml** file.   
4) Run; 
> ansible-playbook deploy_td.yaml --inventory-file=/etc/ansible/hosts -u ec2-user --key-file=aws_key.pem --sudo

5) Essentially, that should take care of the installation.  Simply SSH onto the EC2 instance, cd to **/home/ec2-user/owasp-threat-dragon/** and run;   

> npm start
