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
