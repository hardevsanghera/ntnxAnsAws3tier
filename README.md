# ntnxAnsAws3tier
<p>Ansible playbooks to deploy 3-tier Tasks Laravel web app with MySQL dbserver (on Nutanix AHV) and nginx web servers on AWS.</p>
<p>The main playbook has copious comments: ntnxawsplay.yaml</p>

<h2>Application Architecture</h2>
<p>This 3 tier application, a webapp, is deployed, using Ansible, with MySQL as the back-end database.  Two nginx servers make up the middle layer and the front-end loadbalancer is implemened using HAProxy.  The latter two layers are deployed onto AWS and the dtabase server is deployed onto a Nutanix AHV cluster.  The dtabase layer and the midle webserver layer communicate over an ssh tunnel - this means there's no need for an AWS site-site vpn and one the app has been deployed any user anywhere from any device with a browser can enter the public IP address of the loadbalancer and get to the Task Manager webapp.</p>
<img src="images/arch-ansible-small.jpeg" 
     width="500" 
     height="auto" />
     
<h2>Application UI</h2>
<img src="images/taskappiphone-small2.jpeg" 
     width="200" 
     height="auto" />

<h2>Pre-requisites</h2>
<p>I used an Ubuntu 20.04.1 workstation VM running under VirtualBox.</p>
<ol>
     <li>Ansible core 2.13.2</li>
     <li>Nutanix Ansible Module: https://github.com/nutanix/nutanix.ansible - great blog walk-thru: https://www.nutanix.dev/2022/08/05/getting-started-with-the-nutanix-ansible-module/</li>
     <li>AWS Account with valid API key and secret key, if you can run the aws cli then you rshould be good with the permissions you have</li>
     <li>AWS VPC including subnet, key pair (pem file)</li>
     <li>Nutanix AHV based cluster manged by Prism Central, with credentials</li>
     <li>CentOS 7 AHV disk image, from here: http://download.nutanix.com/Calm/CentOS-7-x86_64-1908.qcow2 - the getImageplay.yaml Ansible playbook will fetch the image for you - edit it first.
</ol>
<h1>How to install and get the webapp working</h1>
<ol>
     <li></li>
     <li></li>
     <li></li>
     <li></li>
     <li></li>
     <li></li>
     <li></li>
</ul>
<h1>Issues and Observations</h1>
<ul>
     <li></li>
     <li></li>
     <li></li>
     <li></li>
     <li></li>
     <li></li>
     <li></li>
</ul>
