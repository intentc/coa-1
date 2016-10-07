
The COA Virtual Appliance is essentials a single vm with openstack-ansible AIO: http://docs.openstack.org/developer/openstack-ansible/liberty/developer-docs/quickstart-aio.html deployed.

Once you download VirtualBox, you can import this by going to File>>Import Appliance.

You need to have at least 8GB allocated to the Appliance.

Also ensure you have a host-only network created by going to VirtualBox>>Preferences>>Network

Make sure you have a vboxnet0 in the list.  If you look at the vboxnet0, it should be 192.168.56.1

Once the appliance boots up, you can log into directly by signing in with:

u: root
p: vagrant

Then try running this command:

lxc-ls --f

you should see a list of all the containers on the system.  The system is fully booted once all the containers have ip addresses.

After this, reinitialize the database by running this script:

./reinitialize.sh

once this completes, you can open up your web browser and navigate to:  http://192.168.56.56

u: admin
p: admin

When you are done playing with it you should create a snapshot of the appliance.  This prevents you from having to go through the above steps every time you want to use it.  Simply restore to the snapshot.

### From Dennis DeMarco

If you have errors when booting instances:

sudo service nova-compute restart

sudo lxc-attach -n aio1_nova_conductor_container-######

service nova-conductor restart

exit

### If you have issues creating volumes:

To fix the cinder volumes,

Go into /etc/lvm.conf change the filter to filter = [“a/sda5/“, “a/loop.*/“,”r/.*/“ ]

The change is to fix just the loop, to read that.

Now issue a :

Losetup /dev/loop4 /openstack/cinder.img

Run:

pvscan 

should go the cinder-volumes group

sudo service cinder-volume restart


To provision your environment with the same resources in class, please copy paste the the following:

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

###Creating users
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

###Creating human_resources stuff
neutron net-create private --os-username demo --os-project-name human_resources --os-user-domain-id default --os-project-domain-id default --os-auth-url http://172.29.236.100:5000/v3 --os-password demo

neutron subnet-create --name private-subnet private 192.168.1.0/24 --dns-nameserver 8.8.8.8 --os-username demo --os-project-name human_resources --os-user-domain-id default --os-project-domain-id default --os-auth-url http://172.29.236.100:5000/v3 --os-password demo

nova --os-user-name demo --os-project-name human_resources --os-user-domain-id default --os-project-domain-id default --os-auth-url http://172.29.236.100:5000/v3 --os-password demo boot --flavor 1 --image cirros instance1

nova --os-user-name demo --os-project-name human_resources --os-user-domain-id default --os-project-domain-id default --os-auth-url http://172.29.236.100:5000/v3 --os-password demo boot --flavor 1 --image cirros instance2

cinder --os-username demo --os-project-name human_resources --os-user-domain-id default --os-project-domain-id default --os-auth-url http://172.29.236.100:5000/v3 --os-password demo create 1 --name volume1

sleep 60

nova --os-user-name demo --os-project-name human_resources --os-user-domain-id default --os-project-domain-id default --os-auth-url http://172.29.236.100:5000/v3 --os-password demo stop instance2

###Remove demo user from extra projects
openstack role remove --project accounting --user demo _member_

openstack role remove --project human_resources --user demo _member_

openstack role remove --project information_technology --user demo _member_

openstack role remove --project marketing --user demo _member_
