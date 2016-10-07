#!/usr/bin/env bash

set -x

#### To provision your environment with the same resources in class, please copy paste the the following:

source openrc

openstack project create --domain default accounting

openstack project create --domain default human_resources

openstack project create --domain default information_technology

openstack project create --domain default marketing

openstack role add --project accounting --user admin admin

openstack role add --project human_resources --user admin admin

openstack role add --project information_technology --user admin admin

openstack role add --project marketing --user admin admin

openstack role add --project accounting --user demo _member_

openstack role add --project human_resources --user demo _member_

openstack role add --project information_technology --user demo _member_

openstack role add --project marketing --user demo _member_

### Creating users

openstack user create --domain default --project accounting --password mypassword --email jsmith@example.com --enable jennys

openstack role add --project accounting --user jennys _member_

openstack user create --domain default --project accounting --password mypassword --email lisaw@example.com --enable lisaw

openstack role add --project accounting --user lisaw _member_

openstack user create --domain default --project human_resources --password mypassword --email tonyc@example.com --enable tonyc

openstack role add --project human_resources --user tonyc _member_

openstack user create --domain default --project marketing --password mypassword --email bridgetz@example.com --enable bridgetz

openstack role add --project marketing --user bridgetz _member_

openstack user create --domain default --project marketing --password mypassword --email mikeo@example.com --enable mikeo

openstack role add --project marketing --user mikeo _member_

openstack user create --domain default --project information_technology --password mypassword --email sallyp@example.com --enable sallyp

openstack role add --project information_technology --user sallyp _member_

openstack user create --domain default --project information_technology --password mypassword --email stephanieu@example.com --enable stephanieu

openstack role add --project information_technology --user stephanieu _member_

### Creating human_resources stuff

neutron net-create private --os-username demo --os-project-name human_resources --os-user-domain-id default --os-project-domain-id default --os-auth-url http://172.29.236.100:5000/v3 --os-password demo

neutron subnet-create --name private-subnet private 192.168.1.0/24 --dns-nameserver 8.8.8.8 --os-username demo --os-project-name human_resources --os-user-domain-id default --os-project-domain-id default --os-auth-url http://172.29.236.100:5000/v3 --os-password demo

nova --os-user-name demo --os-project-name human_resources --os-user-domain-id default --os-project-domain-id default --os-auth-url http://172.29.236.100:5000/v3 --os-password demo boot --flavor 1 --image cirros instance1

nova --os-user-name demo --os-project-name human_resources --os-user-domain-id default --os-project-domain-id default --os-auth-url http://172.29.236.100:5000/v3 --os-password demo boot --flavor 1 --image cirros instance2

cinder --os-username demo --os-project-name human_resources --os-user-domain-id default --os-project-domain-id default --os-auth-url http://172.29.236.100:5000/v3 --os-password demo create 1 --name volume1

sleep 60

nova --os-user-name demo --os-project-name human_resources --os-user-domain-id default --os-project-domain-id default --os-auth-url http://172.29.236.100:5000/v3 --os-password demo stop instance2

