# Ansistrano_deploy_project

A projet to deploy web application developed with PHP using Jenkins, Ansible, bash shell etc.

Infrasturture
-------------
![image](https://github.com/gordon1991112000/ansistrano_deploy_project/blob/main/IPZ%20%20Infrastructure.png)

We have five virtual machines to form a docker swarm cluster which include three manager and two worker nodes.

Apisix
------
Apache APISIX is a dynamic, real-time, high-performance API gateway. APISIX provides rich traffic management features such as load balancing, dynamic upstream, canary release, circuit breaking, authentication, observability, and more.
![image](https://github.com/gordon1991112000/Jenkins_ansistrano_deploy/blob/main/apisix_ingress.png)

Use docker-compose in Apisix directoy to deploy the Apisix containers.

Harbor
------
Harbor is an open source registry that secures artifacts with policies and role-based access control, ensures images are scanned and free from vulnerabilities, and signs images as trusted. Harbor, a CNCF Graduated project, delivers compliance, performance, and interoperability to help you consistently and securely manage artifacts across cloud native compute platforms like Kubernetes and Docker.
![image](https://github.com/gordon1991112000/Jenkins_ansistrano_deploy/blob/main/harbor_.PNG)

Use docker-compose in harbor directory to deploy the harbor containers.

Jenkins
-------
Jenkins is an open source automation server which enables developers around the world to reliably build, test, and deploy their software.
![image](https://user-images.githubusercontent.com/8767584/166629162-43c2b2fb-c6cc-4f87-ba6a-5e50b5d7a4ca.png)

Database
--------
We are using Mariadb as the database. Three db instances are created and one will be the master and the rest are the slaves. All data will be written into the master db while it will replicate to the slaves dbs. Data will be read through the slave dbs.
Follow the manual in the Mariadb directory to create the db cluster.

There is a ansible playbook used to create a service called Maxscale. MariaDB MaxScale is a database proxy that extends the high availability, scalability, and security of MariaDB Server while at the same time simplifying application development by decoupling it from underlying database infrastructure
![image](https://github.com/gordon1991112000/Jenkins_ansistrano_deploy/blob/main/maxscle.PNG)

Prometheus & Grafana
--------------------
Prometheus is an open source monitoring system for which Grafana provides interactive visualization including charts, graphs and alert. All virtual machines can be monitored with node exported installed.
![image](https://github.com/gordon1991112000/Jenkins_ansistrano_deploy/blob/main/prometheus.PNG)
![image](https://github.com/gordon1991112000/Jenkins_ansistrano_deploy/blob/main/grafana.PNG)

ELK
---
ELK is an acronym for several open source tools: Elasticsearch, Logstash, and Kibana. Elasticsearch is the engine of the Elastic Stack, which provides analytics and search functionalities. Logstash is responsible for collecting, aggregating, and storing data to be used by Elasticsearch. Kibana provides the user interface and insights into data previously collected and analyzed by Elasticsearch.
![image](https://github.com/gordon1991112000/Jenkins_ansistrano_deploy/blob/main/elk_.PNG)
Elastic-agent is installed in VMs and containers in order to collect corresponding logs and sent to Elasticseach for further processing.
Use docker-compose in elk directory to deploy the elk containers.

Docker Swarm cluster
--------------------
We have five virtual machines to form a docker swarm cluster which include three manager and two worker nodes. In the cluster, there are different containers including contianer with php installl, container with nginx install, container with redis and memcached installed.

Also Portainer container is also created for monitoring the docker stack. Portainer is a centralized multi-cluster Container Management Platform. 
With an intuitive UI, codified best practices, and cloud-native design templates, Portainer reduces the operational complexity associated with multi-cluster container management. 
Portainer provides universal support for all orchestrators (Docker, Swarm, Nomad, Kubernetes) across all environments
![image](https://github.com/gordon1991112000/Jenkins_ansistrano_deploy/blob/main/portainer.PNG)

Also traefik containers are applied between the Apisix and the nginx.
Traefik is an open-source Edge Router that makes publishing your services a fun and easy experience. It receives requests on behalf of your system and finds out which components are responsible for handling them.
Behind Traefik, we have Portainer and two nginx containers placed in two worker nodes respectively. In the docker-compose file, we defined labels for each container with domain name binding to Traefik. Hence Traefik can handle the traffic for us to route to different services.
