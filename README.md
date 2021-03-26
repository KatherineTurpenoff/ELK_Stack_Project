## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![image](/Images/RedTeam_Diagram_Project.png)

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
- The Jump Box is the single point of access within the network that is only available to the administrator. Additionally, a single point of access is easier to monitor for potential attacks.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the file system and system metrics.

- Filebeat tails and monitors log files within the assigned virtual machines and sends the logs to either Logstash for further processing or to Elasticsearch for indexing. The resulting data may then be compiled and viewed through Kibana.
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

- The automated configuration is ideal because it minimalizes the chance of errors and impliments the configuration at a faster pace. Going forward, the preconfigured files can also be easily edited with future updates.

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

- Filebeat tracks and collects system and file logs. By collecting this data, Filebeat can log all failed and accepted SSH login attempts. 
- Metricbeat collects staistics and metrics for the webserver machines. Through this data we can monitor CPU usage, memory, diskIO, and the number of docker containers per machine.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:

- Locate the name of your ansible container by running: docker container list -a 
- To activate and attach to your ansible run the following commands: docker start container (to start the container) docker attach container (to attach to the container)
- Once you are in your anisible container you will need to navigate to ~/etc/ansible. 
- Copy the [.yml](/yml_Playbooks/) files to the ansible directory in /etc/.
- Update the hosts file to include the webserver IPs and the elk server IP, this is done so the playbook will run on the correct machines. Run the following commands to edit the hosts file:
  
  nano hosts
  Once you are within the hosts file you will need to edit the file starting at line #20. You will need to add the names of the different servers in braces and then add the corresponding private IP addresses below the names. Example provided below:
  
[webservers]
## alpha.example.org
## beta.example.org
## 192.168.1.100
## 192.168.1.110
10.0.0.5 ansible_python_interpreter=/usr/bin/python3
10.0.0.6 ansible_python_interpreter=/usr/bin/python3
10.0.0.7 ansible_python_interpreter=/usr/bin/python3

[elk]
10.1.0.5 ansible_python_interpreter=/usr/bin/python3

- Once you have edited the hosts file make sure you copy the filebeat-config and metricbeat-config files to the ansible directory as well. They are avaible in the [.yml playbook folder](/yml_Playbooks/).
- The config files will need editing within the "Elasticsearch output" and the "Kibana" sections. 
- Within the "Elasticsearch output" section you will change the "hosts" to <["elk private IP:9200"]>
- Within the "Kibana" section you will change the "hosts" to <["elk private IP:5601"]>

Example below:

nano filebeat-config.yml 
Starting at line #1106 and #1806 edit the following:

#-------------------------- Elasticsearch output -------------------------------
output.elasticsearch:
  # Boolean flag to enable or disable the output module.
  #enabled: true

  # Array of hosts to connect to.
  # Scheme and port can be left out and will be set to the default (http and 92$
  # In case you specify and additional path, the scheme is required: http://loc$
  # IPv6 addresses should always be defined as: https://[2001:db8::1]:9200
  hosts: ["10.1.0.5:9200"]
  username: "elastic"
  password: "changeme"
  
  #============================== Kibana =====================================

# Starting with Beats version 6.0.0, the dashboards are loaded via the Kibana A$
# This requires a Kibana endpoint configuration.
setup.kibana:
  host: "10.1.0.5:5601"
  # Kibana Host
  # Scheme and port can be left out and will be set to the default (http and 56$
  # In case you specify and additional path, the scheme is required: http://loc$
  # IPv6 addresses should always be defined as: https://[2001:db8::1]:5601
  #host: "localhost:5601"
  
- The metricbeat-config file is edited the same way as indicated above.
- Once both config files have been edited you may start running the playbooks that you copied to the ansible directory.

The following commands will run each playbook:
  
  ansible-playbook install-elk.yml
  ansible-playbook filebeat-playbook.yml
  ansible-playbook metricbeat-playbook.yml

- After running each playbook, navigate to http://<Elk-Server PublicIP>:5601/app/kibana to check that the installation worked as expected.
