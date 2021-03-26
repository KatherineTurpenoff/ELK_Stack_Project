## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![image](/Images/RedTeamDiagram_Project.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the .yml file, provided below, may be used to install only certain pieces of it, such as Filebeat.

- [yml_Playbooks](/yml_Playbooks/) 

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting inbound access to the network.

- The load balancer protects the network from DDoS attacks by distributing traffic evenly amongst the virtual machines. 
- The Jump Box is the single point of access within the network that is only available to the administrator. Additionally, a single point of access is easier to monitor then multiple access points.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the file system and system metrics.

- Filebeat tails and monitors log files within the assigned virtual machines and sends the logs to either Logstash for further processing or to Elasticsearch for indexing.
- Metricbeat collects the statistics and metrics from the network, including CPU usage, memory, file system, etc.

The configuration details of each machine may be found below.

| Name     | Function   | IP Address | Operating System |
|----------|------------|------------|------------------|
| Jump Box | Gateway    | 10.0.0.4   | Linux            |
| Web-1    | Web Server | 10.0.0.5   | Linux            |
| Web-2    | Web Server | 10.0.0.6   | Linux            |
| Web-3    | Web Server | 10.0.0.7   | Linux            |
| ELK      | Monitoring | 10.1.0.5   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- The administrator's personal IP address is the only address with access to the Jump Box machine.

Machines within the network can only be accessed by the Jump Box VM.
- The Jump Box machine, with IP 10.0.0.4, has access to every machine within the network, including the ELK sever.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | Personal IP          |
| Web-1    | No                  | 10.0.0.4             |
| Web-2    | No                  | 10.0.0.4             |
| Web-3    | No                  | 10.0.0.4             |
| ELK      | No                  | 10.0.0.4             |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- The automated configuration is advantagious because it minimalizes the chance of errors and is more timely. Going forward, the preconfigured files can also be easily edited with future updates.

The playbook implements the following tasks:
- First Task: install docker.io
- Second Task: install python3
- Third Task: install docker module
- Fourth Task: increase the virtual memory
- Fifth Task: download and launch the docker ELK container
- Sixth Task: docker on boot (this command makes sure that docker is automatically started everytime the webservers are booted up)

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![image](Images/Docker_ps.PNG)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1: 10.0.0.5
- Web-2: 10.0.0.6
- Web-3: 10.0.0.7

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the _____ file to _____.
- Update the _____ file to include...
- Run the playbook, and navigate to ____ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running?

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
