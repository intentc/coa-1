
The COA Virtual Appliance is essentials a single vm with openstack-ansible AIO: http://docs.openstack.org/developer/openstack-ansible/liberty/developer-docs/quickstart-aio.html deployed.

Once you download VirtualBox, you can import this by going to File>>Import Appliance.

You need to have at least 8GB allocated to the Appliance.

Also ensure you have a host-only network created by going to VirtualBox>>Preferences>>Network

Make sure you have a vboxnet0 in the list.  If you look at the vboxnet0, it should be 192.168.56.1

Once the appliance boots up, you can log into directly by signing in with:

u: root
p: vagrant

Then try running this command:

lxc-ls -f

>  root@controller:~# lxc-ls -f
>  NAME                                          STATE    IPV4                                           IPV6  AUTOSTART
>  -----------------------------------------------------------------------------------------------------------------------------------
>  aio1_aodh_container-53128e5e                  RUNNING  10.255.255.31, 172.29.237.216                  -     YES (onboot, openstack)
>  aio1_ceilometer_api_container-d8c6509a        RUNNING  10.255.255.238, 172.29.237.130                 -     YES (onboot, openstack)
>  aio1_ceilometer_collector_container-42d3b0e6  RUNNING  10.255.255.111, 172.29.236.239                 -     YES (onboot, openstack)
>  aio1_cinder_api_container-a952f7bf            RUNNING  10.255.255.41, 172.29.236.181, 172.29.246.74   -     YES (onboot, openstack)
>  aio1_cinder_scheduler_container-099c6885      RUNNING  10.255.255.215, 172.29.238.47                  -     YES (onboot, openstack)
>  aio1_galera_container-9397b8ed                RUNNING  10.255.255.7, 172.29.239.8                     -     YES (onboot, openstack)
>  aio1_galera_container-cc28cf51                RUNNING  10.255.255.171, 172.29.239.231                 -     YES (onboot, openstack)
>  aio1_galera_container-e9b772e6                RUNNING  10.255.255.198, 172.29.237.73                  -     YES (onboot, openstack)
>  aio1_glance_container-617a47c2                RUNNING  10.255.255.223, 172.29.238.81, 172.29.245.72   -     YES (onboot, openstack)
>  aio1_heat_apis_container-8bc183c6             RUNNING  10.255.255.76, 172.29.236.110                  -     YES (onboot, openstack)
>  aio1_heat_engine_container-9661d8e0           RUNNING  10.255.255.119, 172.29.239.249                 -     YES (onboot, openstack)
>  aio1_horizon_container-05389398               RUNNING  10.255.255.52, 172.29.238.193                  -     YES (onboot, openstack)
>  aio1_horizon_container-447fb0b3               RUNNING  10.255.255.173, 172.29.237.210                 -     YES (onboot, openstack)
>  aio1_keystone_container-44aced24              RUNNING  10.255.255.121, 172.29.236.201                 -     YES (onboot, openstack)
>  aio1_keystone_container-45287f30              RUNNING  10.255.255.251, 172.29.237.142                 -     YES (onboot, openstack)
>  aio1_memcached_container-4ec567fd             RUNNING  10.255.255.75, 172.29.236.61                   -     YES (onboot, openstack)
>  aio1_neutron_agents_container-102303d7        RUNNING  10.255.255.157, 172.29.236.158, 172.29.241.88  -     YES (onboot, openstack)
>  aio1_neutron_server_container-36c8d355        RUNNING  10.255.255.237, 172.29.238.88                  -     YES (onboot, openstack)
>  aio1_nova_api_metadata_container-dd087b00     RUNNING  10.255.255.193, 172.29.236.162                 -     YES (onboot, openstack)
>  aio1_nova_api_os_compute_container-1ef90ff5   RUNNING  10.255.255.118, 172.29.239.171                 -     YES (onboot, openstack)
>  aio1_nova_cert_container-20495443             RUNNING  10.255.255.39, 172.29.236.183                  -     YES (onboot, openstack)
>  aio1_nova_conductor_container-b5587a66        RUNNING  10.255.255.4, 172.29.238.56                    -     YES (onboot, openstack)
>  aio1_nova_console_container-80273e3e          RUNNING  10.255.255.117, 172.29.238.184                 -     YES (onboot, openstack)
>  aio1_nova_scheduler_container-c216221d        RUNNING  10.255.255.135, 172.29.238.10                  -     YES (onboot, openstack)
>  aio1_rabbit_mq_container-2f998b79             RUNNING  10.255.255.26, 172.29.239.104                  -     YES (onboot, openstack)
>  aio1_rabbit_mq_container-36f9ae06             RUNNING  10.255.255.71, 172.29.237.126                  -     YES (onboot, openstack)
>  aio1_rabbit_mq_container-d971ca78             RUNNING  10.255.255.214, 172.29.239.137                 -     YES (onboot, openstack)
>  aio1_repo_container-adf01246                  RUNNING  10.255.255.16, 172.29.239.18                   -     YES (onboot, openstack)
>  aio1_repo_container-f6f97946                  RUNNING  10.255.255.154, 172.29.237.85                  -     YES (onboot, openstack)
>  aio1_rsyslog_container-60f045d8               RUNNING  10.255.255.139, 172.29.237.94                  -     YES (onboot, openstack)
>  aio1_swift_proxy_container-bf8f97c3           RUNNING  10.255.255.183, 172.29.239.21, 172.29.244.161  -     YES (onboot, openstack)
>  aio1_utility_container-81456e51               RUNNING  10.255.255.44, 172.29.237.131                  -     YES (onboot, openstack)
>  root@controller:~#

you should see a list of all the containers on the system.  The system is fully booted once all the containers have ip addresses.

After this, reinitialize the database by running this script:

./reinitialize.sh

>  root@controller:~# ./reinitialize.sh
>  + cd /opt/openstack-ansible/playbooks
>  + openstack-ansible -e galera_ignore_cluster_state=true galera-install.yml
>  Variable files: "-e @/etc/openstack_deploy/user_conf_files.yml -e @/etc/openstack_deploy/user_secrets.yml -e @/etc/openstack_deploy/user_variables.yml "
>
>  PLAY [Galera container config] ************************************************
>
>  GATHERING FACTS ***************************************************************
>  ok: [aio1_galera_container-cc28cf51]
>  ok: [aio1_galera_container-9397b8ed]
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [Use the lxc-openstack aa profile] **************************************
>  ok: [aio1_galera_container-e9b772e6 -> aio1]
>  ok: [aio1_galera_container-9397b8ed -> aio1]
>  ok: [aio1_galera_container-cc28cf51 -> aio1]
>
>  TASK: [Galera extra lxc config] ***********************************************
>  changed: [aio1_galera_container-9397b8ed -> aio1]
>  changed: [aio1_galera_container-e9b772e6 -> aio1]
>  changed: [aio1_galera_container-cc28cf51 -> aio1]
>
>  TASK: [Wait for container ssh] ************************************************
>  ok: [aio1_galera_container-9397b8ed -> aio1]
>  ok: [aio1_galera_container-cc28cf51 -> aio1]
>  ok: [aio1_galera_container-e9b772e6 -> aio1]
>
>  PLAY [Install galera server] **************************************************
>
>  TASK: [apt_package_pinning | Add apt pin preferences] *************************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [pip_install | Create pip config directory] *****************************
>  ok: [aio1_galera_container-9397b8ed] => (item=/opt)
>  ok: [aio1_galera_container-9397b8ed] => (item=/root/.cache)
>  ok: [aio1_galera_container-9397b8ed] => (item=/root/.cache/pip)
>
>  TASK: [pip_install | Drop pip file(s)] ****************************************
>  ok: [aio1_galera_container-9397b8ed] => (item={'dest': u'/root/.cache/pip/selfcheck.json', 'src': 'selfcheck.json'})
>
>  TASK: [pip_install | Get Modern PIP] ******************************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [pip_install | Get Modern PIP using fallback URL] ***********************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [pip_install | Install PIP] *********************************************
>  changed: [aio1_galera_container-9397b8ed]
>
>  TASK: [pip_install | Install PIP (fall back mode)] ****************************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [pip_lock_down | Create pip config directory] ***************************
>  ok: [aio1_galera_container-9397b8ed] => (item=/root/.pip)
>  ok: [aio1_galera_container-9397b8ed] => (item=/root/.pip/base)
>  ok: [aio1_galera_container-9397b8ed] => (item=/root/.pip/links.d)
>  ok: [aio1_galera_container-9397b8ed] => (item=/root/.cache)
>  ok: [aio1_galera_container-9397b8ed] => (item=/root/.cache/pip)
>
>  TASK: [pip_lock_down | Drop pip lockdown file(s)] *****************************
>  ok: [aio1_galera_container-9397b8ed] => (item={'dest': u'/root/.pip/pip-link-build.py', 'src': 'pip-link-build.py', 'mode': '0755'})
>
>  TASK: [pip_lock_down | Drop pip global config(s)] *****************************
>  ok: [aio1_galera_container-9397b8ed] => (item={'dest': u'/root/.pip/base/global.conf', 'src': 'global.conf.j2', 'config_type': 'ini', 'config_overrides': {}})
>
>  TASK: [pip_lock_down | Drop pip link file(s)] *********************************
>  ok: [aio1_galera_container-9397b8ed] => (item={'link': u'http://172.29.236.100:8181/os-releases/12.0.14/', 'name': 'openstack_release'})
>
>  TASK: [pip_lock_down | Execute pip config builder] ****************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_client | Add galera apt-keys] ***********************************
>  ok: [aio1_galera_container-9397b8ed] => (item={'key_name': 'mariadb', 'hash_id': '0xcbcb082a1bb943db', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>  ok: [aio1_galera_container-9397b8ed] => (item={'key_name': 'percona-xtrabackup', 'hash_id': '0x1c4cbdcdcd2efd2a', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>
>  TASK: [galera_client | Add galera apt-keys using fallback keyserver] **********
>  skipping: [aio1_galera_container-9397b8ed] => (item={'key_name': 'mariadb', 'hash_id': '0xcbcb082a1bb943db', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>  skipping: [aio1_galera_container-9397b8ed] => (item={'key_name': 'percona-xtrabackup', 'hash_id': '0x1c4cbdcdcd2efd2a', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>
>  TASK: [galera_client | Drop galera repo pin] **********************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_client | Add galera repo(s)] ************************************
>  ok: [aio1_galera_container-9397b8ed] => (item={'repo': u'deb https://mirror.rackspace.com/mariadb/repo/10.0/ubuntu trusty main', 'state': 'present'})
>  ok: [aio1_galera_container-9397b8ed] => (item={'repo': u'deb https://repo.percona.com/apt trusty main', 'state': 'present'})
>
>  TASK: [galera_client | Download the galera package] ***************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_client | Update apt sources] ************************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_client | Install galera packages] *******************************
>  changed: [aio1_galera_container-9397b8ed] => (item=libaio1,libc6,libdbd-mysql-perl,libgcc1,libgcrypt11,libmariadbclient-dev,libstdc++6,mariadb-client,mariadb-client-core-10.0)
>
>  TASK: [galera_client | UnInstall system xtrabackup packages] ******************
>  ok: [aio1_galera_container-9397b8ed] => (item=percona-xtrabackup,xtrabackup)
>
>  TASK: [galera_client | Install galera package] ********************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_client | Install pip packages] **********************************
>  ok: [aio1_galera_container-9397b8ed] => (item=MySQL-python)
>  ok: [aio1_galera_container-9397b8ed] => (item=python-memcached)
>  ok: [aio1_galera_container-9397b8ed] => (item=pycrypto)
>
>  TASK: [galera_client | Drop local .my.cnf file] *******************************
>  ok: [aio1_galera_container-9397b8ed] => (item={'dest': '/root/.my.cnf', 'src': 'client.my.cnf.j2', 'config_type': 'ini', 'config_overrides': {}})
>
>  TASK: [galera_server | Check major galera install version] ********************
>  changed: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Check for any galera install version] ******************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Check if major version of Galera is installed] *********
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Set fact to ignore cluster state] **********************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Stop MariaDB] ******************************************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Find old sources] **************************************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Remove old sources] ************************************
>  skipping: [aio1_galera_container-9397b8ed] => (item=old_sources.stdout_lines)
>
>  TASK: [galera_server | Update apt sources (Forced)] ***************************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | UN-Install galera-server package] **********************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Confirm service connectivity] **************************
>  changed: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Check that WSREP is ready] *****************************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Set running state fact] ********************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Check for cluster state failure] ***********************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Gather mysql facts] ************************************
>  failed: [aio1_galera_container-9397b8ed] => {"failed": true}
>  msg: Mysql fact collection failed: "ERROR 2003 (HY000): Can't connect to MySQL server on '127.0.0.1' (111 "Connection refused")".
>  ...ignoring
>
>  TASK: [galera_server | Check for cluster state failure] ***********************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Check for cluster state failure] ***********************
>  skipping: [aio1_galera_container-9397b8ed] => (item=aio1_galera_container-9397b8ed)
>
>  TASK: [galera_server | set_fact ] *********************************************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Update apt sources] ************************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Install galera pre packages] ***************************
>  ok: [aio1_galera_container-9397b8ed] => (item=debconf-utils,libaio1,libc6,libdbd-mysql-perl,libgcc1,libgcrypt11,libstdc++6,python-software-properties,software-properties-common)
>
>  TASK: [galera_server | Add galera apt-keys] ***********************************
>  ok: [aio1_galera_container-9397b8ed] => (item={'key_name': 'mariadb', 'hash_id': '0xcbcb082a1bb943db', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>  ok: [aio1_galera_container-9397b8ed] => (item={'key_name': 'percona-xtrabackup', 'hash_id': '0x1c4cbdcdcd2efd2a', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>
>  TASK: [galera_server | Add galera apt-keys using fallback keyserver] **********
>  skipping: [aio1_galera_container-9397b8ed] => (item={'key_name': 'mariadb', 'hash_id': '0xcbcb082a1bb943db', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>  skipping: [aio1_galera_container-9397b8ed] => (item={'key_name': 'percona-xtrabackup', 'hash_id': '0x1c4cbdcdcd2efd2a', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>
>  TASK: [galera_server | Drop galera repo pin] **********************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Add galera repo(s)] ************************************
>  ok: [aio1_galera_container-9397b8ed] => (item={'repo': u'deb https://mirror.rackspace.com/mariadb/repo/10.0/ubuntu trusty main', 'state': 'present'})
>  ok: [aio1_galera_container-9397b8ed] => (item={'repo': u'deb https://repo.percona.com/apt trusty main', 'state': 'present'})
>
>  TASK: [galera_server | Download the galera package] ***************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Prevent galera from starting on install] ***************
>  changed: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Drop limits config] ************************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Preseed galera password(s)] ****************************
>  ok: [aio1_galera_container-9397b8ed] => (item={'vtype': 'string', 'question': 'mysql-server/root_password', 'name': u'mariadb-galera-server-10.0', 'value': u'aa8a8bfb44df0925e903a1'})
>  ok: [aio1_galera_container-9397b8ed] => (item={'vtype': 'string', 'question': 'mysql-server/root_password_again', 'name': u'mariadb-galera-server-10.0', 'value': u'aa8a8bfb44df0925e903a1'})
>
>  TASK: [galera_server | Update apt sources] ************************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Install galera packages] *******************************
>  changed: [aio1_galera_container-9397b8ed] => (item=mariadb-client,mariadb-galera-server-10.0,galera-3,qpress,rsync,socat)
>
>  TASK: [galera_server | UnInstall system xtrabackup packages] ******************
>  ok: [aio1_galera_container-9397b8ed] => (item=percona-xtrabackup,xtrabackup)
>
>  TASK: [galera_server | Install galera package] ********************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Install pip packages] **********************************
>  ok: [aio1_galera_container-9397b8ed] => (item=MySQL-python)
>  ok: [aio1_galera_container-9397b8ed] => (item=python-memcached)
>  ok: [aio1_galera_container-9397b8ed] => (item=pycrypto)
>
>  TASK: [galera_server | Create the local directories] **************************
>  changed: [aio1_galera_container-9397b8ed] => (item={'owner': 'mysql', 'path': '/var/lib/mysql', 'mode': '2755'})
>  changed: [aio1_galera_container-9397b8ed] => (item={'owner': 'mysql', 'path': '/var/log/mysql', 'mode': '2755'})
>  ok: [aio1_galera_container-9397b8ed] => (item={'owner': 'mysql', 'path': '/var/log/mysql_logs/', 'group': 'syslog', 'mode': '2755'})
>  ok: [aio1_galera_container-9397b8ed] => (item={'path': '/etc/mysql/conf.d'})
>
>  TASK: [galera_server | Drop mariadb config(s)] ********************************
>  ok: [aio1_galera_container-9397b8ed] => (item={'dest': '/etc/mysql/my.cnf', 'src': 'my.cnf.j2', 'config_type': 'ini', 'config_overrides': {}})
>  ok: [aio1_galera_container-9397b8ed] => (item={'dest': '/etc/mysql/conf.d/cluster.cnf', 'src': 'cluster.cnf.j2', 'config_type': 'ini', 'config_overrides': {}})
>  changed: [aio1_galera_container-9397b8ed] => (item={'dest': '/etc/mysql/debian.cnf', 'src': 'debian.cnf.j2', 'config_type': 'ini', 'config_overrides': {}})
>
>  TASK: [galera_server | fix mysql startup timeout] *****************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Drop mariadb config(s)] ********************************
>  ok: [aio1_galera_container-9397b8ed] => (item={'dest': '/etc/default/mysql', 'src': 'mysql_defaults.j2'})
>
>  TASK: [galera_server | remove default mysql_safe_syslog] **********************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Remove policy-rc] **************************************
>  changed: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Start MySQL] *******************************************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Confirm service connectivity] **************************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Check that WSREP is ready] *****************************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Set running state fact] ********************************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Run MySQL Upgrade] *************************************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Confirm service connectivity] **************************
>  changed: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Check that WSREP is ready] *****************************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Set running state fact] ********************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Start cluster with wsrep] ******************************
>  changed: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Wait for operational state] ****************************
>  changed: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | set_fact ] *********************************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  NOTIFIED: [galera_server | Restart mysql] *************************************
>  skipping: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Confirm service connectivity] **************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Check that WSREP is ready] *****************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Set running state fact] ********************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [galera_server | Create galera users] ***********************************
>  ok: [aio1_galera_container-9397b8ed] => (item={'priv': '*.*:ALL,GRANT', 'state': 'present', 'password': u'aa8a8bfb44df0925e903a1', 'host': '%', 'name': u'root'})
>  ok: [aio1_galera_container-9397b8ed] => (item={'priv': '*.*:ALL', 'state': 'absent', 'password': u'aa8a8bfb44df0925e903a1', 'host': 'localhost', 'name': u'root'})
>  ok: [aio1_galera_container-9397b8ed] => (item={'priv': '*.*:USAGE', 'state': 'present', 'password': u'', 'host': '%', 'name': u'monitoring'})
>  ok: [aio1_galera_container-9397b8ed] => (item={'priv': '*.*:USAGE', 'state': 'present', 'password': u'', 'host': 'localhost', 'name': u'monitoring'})
>
>  TASK: [rsyslog_client | Ensure ownership on working directory is correct] *****
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [rsyslog_client | Rsyslog apt repository] *******************************
>  skipping: [aio1_galera_container-9397b8ed] => (item=rsyslog_client_apt_repos)
>
>  TASK: [rsyslog_client | Update apt sources] ***********************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [rsyslog_client | Install rsyslog packages] *****************************
>  ok: [aio1_galera_container-9397b8ed] => (item=rsyslog,logrotate)
>
>  TASK: [rsyslog_client | Stop rsyslog] *****************************************
>  changed: [aio1_galera_container-9397b8ed]
>
>  TASK: [rsyslog_client | Rsyslog Setup] ****************************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [rsyslog_client | Find all log files] ***********************************
>  changed: [aio1_galera_container-9397b8ed]
>
>  TASK: [rsyslog_client | Write rsyslog config for found log files] *************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [rsyslog_client | Union the log files] **********************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [rsyslog_client | Write rsyslog target file] ****************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [rsyslog_client | Write log rotate file] ********************************
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [rsyslog_client | Configure logrotate to compress logs by default] ******
>  ok: [aio1_galera_container-9397b8ed]
>
>  TASK: [rsyslog_client | Start rsyslog] ****************************************
>  changed: [aio1_galera_container-9397b8ed]
>
>  TASK: [system_crontab_coordination | Create crontab] **************************
>  changed: [aio1_galera_container-9397b8ed]
>
>  TASK: [apt_package_pinning | Add apt pin preferences] *************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [pip_install | Create pip config directory] *****************************
>  ok: [aio1_galera_container-e9b772e6] => (item=/opt)
>  ok: [aio1_galera_container-e9b772e6] => (item=/root/.cache)
>  ok: [aio1_galera_container-e9b772e6] => (item=/root/.cache/pip)
>
>  TASK: [pip_install | Drop pip file(s)] ****************************************
>  ok: [aio1_galera_container-e9b772e6] => (item={'dest': u'/root/.cache/pip/selfcheck.json', 'src': 'selfcheck.json'})
>
>  TASK: [pip_install | Get Modern PIP] ******************************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [pip_install | Get Modern PIP using fallback URL] ***********************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [pip_install | Install PIP] *********************************************
>  changed: [aio1_galera_container-e9b772e6]
>
>  TASK: [pip_install | Install PIP (fall back mode)] ****************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [pip_lock_down | Create pip config directory] ***************************
>  ok: [aio1_galera_container-e9b772e6] => (item=/root/.pip)
>  ok: [aio1_galera_container-e9b772e6] => (item=/root/.pip/base)
>  ok: [aio1_galera_container-e9b772e6] => (item=/root/.pip/links.d)
>  ok: [aio1_galera_container-e9b772e6] => (item=/root/.cache)
>  ok: [aio1_galera_container-e9b772e6] => (item=/root/.cache/pip)
>
>  TASK: [pip_lock_down | Drop pip lockdown file(s)] *****************************
>  ok: [aio1_galera_container-e9b772e6] => (item={'dest': u'/root/.pip/pip-link-build.py', 'src': 'pip-link-build.py', 'mode': '0755'})
>
>  TASK: [pip_lock_down | Drop pip global config(s)] *****************************
>  ok: [aio1_galera_container-e9b772e6] => (item={'dest': u'/root/.pip/base/global.conf', 'src': 'global.conf.j2', 'config_type': 'ini', 'config_overrides': {}})
>
>  TASK: [pip_lock_down | Drop pip link file(s)] *********************************
>  ok: [aio1_galera_container-e9b772e6] => (item={'link': u'http://172.29.236.100:8181/os-releases/12.0.14/', 'name': 'openstack_release'})
>
>  TASK: [pip_lock_down | Execute pip config builder] ****************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_client | Add galera apt-keys] ***********************************
>  ok: [aio1_galera_container-e9b772e6] => (item={'key_name': 'mariadb', 'hash_id': '0xcbcb082a1bb943db', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>  ok: [aio1_galera_container-e9b772e6] => (item={'key_name': 'percona-xtrabackup', 'hash_id': '0x1c4cbdcdcd2efd2a', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>
>  TASK: [galera_client | Add galera apt-keys using fallback keyserver] **********
>  skipping: [aio1_galera_container-e9b772e6] => (item={'key_name': 'mariadb', 'hash_id': '0xcbcb082a1bb943db', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>  skipping: [aio1_galera_container-e9b772e6] => (item={'key_name': 'percona-xtrabackup', 'hash_id': '0x1c4cbdcdcd2efd2a', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>
>  TASK: [galera_client | Drop galera repo pin] **********************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_client | Add galera repo(s)] ************************************
>  ok: [aio1_galera_container-e9b772e6] => (item={'repo': u'deb https://mirror.rackspace.com/mariadb/repo/10.0/ubuntu trusty main', 'state': 'present'})
>  ok: [aio1_galera_container-e9b772e6] => (item={'repo': u'deb https://repo.percona.com/apt trusty main', 'state': 'present'})
>
>  TASK: [galera_client | Download the galera package] ***************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_client | Update apt sources] ************************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_client | Install galera packages] *******************************
>  changed: [aio1_galera_container-e9b772e6] => (item=libaio1,libc6,libdbd-mysql-perl,libgcc1,libgcrypt11,libmariadbclient-dev,libstdc++6,mariadb-client,mariadb-client-core-10.0)
>
>  TASK: [galera_client | UnInstall system xtrabackup packages] ******************
>  ok: [aio1_galera_container-e9b772e6] => (item=percona-xtrabackup,xtrabackup)
>
>  TASK: [galera_client | Install galera package] ********************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_client | Install pip packages] **********************************
>  ok: [aio1_galera_container-e9b772e6] => (item=MySQL-python)
>  ok: [aio1_galera_container-e9b772e6] => (item=python-memcached)
>  ok: [aio1_galera_container-e9b772e6] => (item=pycrypto)
>
>  TASK: [galera_client | Drop local .my.cnf file] *******************************
>  ok: [aio1_galera_container-e9b772e6] => (item={'dest': '/root/.my.cnf', 'src': 'client.my.cnf.j2', 'config_type': 'ini', 'config_overrides': {}})
>
>  TASK: [galera_server | Check major galera install version] ********************
>  changed: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Check for any galera install version] ******************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Check if major version of Galera is installed] *********
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Set fact to ignore cluster state] **********************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Stop MariaDB] ******************************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Find old sources] **************************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Remove old sources] ************************************
>  skipping: [aio1_galera_container-e9b772e6] => (item=old_sources.stdout_lines)
>
>  TASK: [galera_server | Update apt sources (Forced)] ***************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | UN-Install galera-server package] **********************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Confirm service connectivity] **************************
>  changed: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Check that WSREP is ready] *****************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Set running state fact] ********************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Check for cluster state failure] ***********************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Gather mysql facts] ************************************
>  failed: [aio1_galera_container-e9b772e6] => {"failed": true}
>  msg: Mysql fact collection failed: "ERROR 2003 (HY000): Can't connect to MySQL server on '127.0.0.1' (111 "Connection refused")".
>  ...ignoring
>
>  TASK: [galera_server | Check for cluster state failure] ***********************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Check for cluster state failure] ***********************
>  skipping: [aio1_galera_container-e9b772e6] => (item=aio1_galera_container-e9b772e6)
>
>  TASK: [galera_server | set_fact ] *********************************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Update apt sources] ************************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Install galera pre packages] ***************************
>  ok: [aio1_galera_container-e9b772e6] => (item=debconf-utils,libaio1,libc6,libdbd-mysql-perl,libgcc1,libgcrypt11,libstdc++6,python-software-properties,software-properties-common)
>
>  TASK: [galera_server | Add galera apt-keys] ***********************************
>  ok: [aio1_galera_container-e9b772e6] => (item={'key_name': 'mariadb', 'hash_id': '0xcbcb082a1bb943db', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>  ok: [aio1_galera_container-e9b772e6] => (item={'key_name': 'percona-xtrabackup', 'hash_id': '0x1c4cbdcdcd2efd2a', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>
>  TASK: [galera_server | Add galera apt-keys using fallback keyserver] **********
>  skipping: [aio1_galera_container-e9b772e6] => (item={'key_name': 'mariadb', 'hash_id': '0xcbcb082a1bb943db', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>  skipping: [aio1_galera_container-e9b772e6] => (item={'key_name': 'percona-xtrabackup', 'hash_id': '0x1c4cbdcdcd2efd2a', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>
>  TASK: [galera_server | Drop galera repo pin] **********************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Add galera repo(s)] ************************************
>  ok: [aio1_galera_container-e9b772e6] => (item={'repo': u'deb https://mirror.rackspace.com/mariadb/repo/10.0/ubuntu trusty main', 'state': 'present'})
>  ok: [aio1_galera_container-e9b772e6] => (item={'repo': u'deb https://repo.percona.com/apt trusty main', 'state': 'present'})
>
>  TASK: [galera_server | Download the galera package] ***************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Prevent galera from starting on install] ***************
>  changed: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Drop limits config] ************************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Preseed galera password(s)] ****************************
>  ok: [aio1_galera_container-e9b772e6] => (item={'vtype': 'string', 'question': 'mysql-server/root_password', 'name': u'mariadb-galera-server-10.0', 'value': u'aa8a8bfb44df0925e903a1'})
>  ok: [aio1_galera_container-e9b772e6] => (item={'vtype': 'string', 'question': 'mysql-server/root_password_again', 'name': u'mariadb-galera-server-10.0', 'value': u'aa8a8bfb44df0925e903a1'})
>
>  TASK: [galera_server | Update apt sources] ************************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Install galera packages] *******************************
>  changed: [aio1_galera_container-e9b772e6] => (item=mariadb-client,mariadb-galera-server-10.0,galera-3,qpress,rsync,socat)
>
>  TASK: [galera_server | UnInstall system xtrabackup packages] ******************
>  ok: [aio1_galera_container-e9b772e6] => (item=percona-xtrabackup,xtrabackup)
>
>  TASK: [galera_server | Install galera package] ********************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Install pip packages] **********************************
>  ok: [aio1_galera_container-e9b772e6] => (item=MySQL-python)
>  ok: [aio1_galera_container-e9b772e6] => (item=python-memcached)
>  ok: [aio1_galera_container-e9b772e6] => (item=pycrypto)
>
>  TASK: [galera_server | Create the local directories] **************************
>  changed: [aio1_galera_container-e9b772e6] => (item={'owner': 'mysql', 'path': '/var/lib/mysql', 'mode': '2755'})
>  changed: [aio1_galera_container-e9b772e6] => (item={'owner': 'mysql', 'path': '/var/log/mysql', 'mode': '2755'})
>  ok: [aio1_galera_container-e9b772e6] => (item={'owner': 'mysql', 'path': '/var/log/mysql_logs/', 'group': 'syslog', 'mode': '2755'})
>  ok: [aio1_galera_container-e9b772e6] => (item={'path': '/etc/mysql/conf.d'})
>
>  TASK: [galera_server | Drop mariadb config(s)] ********************************
>  ok: [aio1_galera_container-e9b772e6] => (item={'dest': '/etc/mysql/my.cnf', 'src': 'my.cnf.j2', 'config_type': 'ini', 'config_overrides': {}})
>  ok: [aio1_galera_container-e9b772e6] => (item={'dest': '/etc/mysql/conf.d/cluster.cnf', 'src': 'cluster.cnf.j2', 'config_type': 'ini', 'config_overrides': {}})
>  changed: [aio1_galera_container-e9b772e6] => (item={'dest': '/etc/mysql/debian.cnf', 'src': 'debian.cnf.j2', 'config_type': 'ini', 'config_overrides': {}})
>
>  TASK: [galera_server | fix mysql startup timeout] *****************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Drop mariadb config(s)] ********************************
>  ok: [aio1_galera_container-e9b772e6] => (item={'dest': '/etc/default/mysql', 'src': 'mysql_defaults.j2'})
>
>  TASK: [galera_server | remove default mysql_safe_syslog] **********************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Remove policy-rc] **************************************
>  changed: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Start MySQL] *******************************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Confirm service connectivity] **************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Check that WSREP is ready] *****************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Set running state fact] ********************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Run MySQL Upgrade] *************************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Confirm service connectivity] **************************
>  changed: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Check that WSREP is ready] *****************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Set running state fact] ********************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Start cluster with wsrep] ******************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Wait for operational state] ****************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | set_fact ] *********************************************
>  skipping: [aio1_galera_container-e9b772e6]
>
>  NOTIFIED: [galera_server | Restart mysql] *************************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Confirm service connectivity] **************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Check that WSREP is ready] *****************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Set running state fact] ********************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [galera_server | Create galera users] ***********************************
>  skipping: [aio1_galera_container-e9b772e6] => (item={'priv': '*.*:ALL,GRANT', 'state': 'present', 'password': u'aa8a8bfb44df0925e903a1', 'host': '%', 'name': u'root'})
>  skipping: [aio1_galera_container-e9b772e6] => (item={'priv': '*.*:ALL', 'state': 'absent', 'password': u'aa8a8bfb44df0925e903a1', 'host': 'localhost', 'name': u'root'})
>  skipping: [aio1_galera_container-e9b772e6] => (item={'priv': '*.*:USAGE', 'state': 'present', 'password': u'', 'host': '%', 'name': u'monitoring'})
>  skipping: [aio1_galera_container-e9b772e6] => (item={'priv': '*.*:USAGE', 'state': 'present', 'password': u'', 'host': 'localhost', 'name': u'monitoring'})
>
>  TASK: [rsyslog_client | Ensure ownership on working directory is correct] *****
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [rsyslog_client | Rsyslog apt repository] *******************************
>  skipping: [aio1_galera_container-e9b772e6] => (item=rsyslog_client_apt_repos)
>
>  TASK: [rsyslog_client | Update apt sources] ***********************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [rsyslog_client | Install rsyslog packages] *****************************
>  ok: [aio1_galera_container-e9b772e6] => (item=rsyslog,logrotate)
>
>  TASK: [rsyslog_client | Stop rsyslog] *****************************************
>  changed: [aio1_galera_container-e9b772e6]
>
>  TASK: [rsyslog_client | Rsyslog Setup] ****************************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [rsyslog_client | Find all log files] ***********************************
>  changed: [aio1_galera_container-e9b772e6]
>
>  TASK: [rsyslog_client | Write rsyslog config for found log files] *************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [rsyslog_client | Union the log files] **********************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [rsyslog_client | Write rsyslog target file] ****************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [rsyslog_client | Write log rotate file] ********************************
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [rsyslog_client | Configure logrotate to compress logs by default] ******
>  ok: [aio1_galera_container-e9b772e6]
>
>  TASK: [rsyslog_client | Start rsyslog] ****************************************
>  changed: [aio1_galera_container-e9b772e6]
>
>  TASK: [system_crontab_coordination | Create crontab] **************************
>  changed: [aio1_galera_container-e9b772e6]
>
>  TASK: [apt_package_pinning | Add apt pin preferences] *************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [pip_install | Create pip config directory] *****************************
>  ok: [aio1_galera_container-cc28cf51] => (item=/opt)
>  ok: [aio1_galera_container-cc28cf51] => (item=/root/.cache)
>  ok: [aio1_galera_container-cc28cf51] => (item=/root/.cache/pip)
>
>  TASK: [pip_install | Drop pip file(s)] ****************************************
>  ok: [aio1_galera_container-cc28cf51] => (item={'dest': u'/root/.cache/pip/selfcheck.json', 'src': 'selfcheck.json'})
>
>  TASK: [pip_install | Get Modern PIP] ******************************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [pip_install | Get Modern PIP using fallback URL] ***********************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [pip_install | Install PIP] *********************************************
>  changed: [aio1_galera_container-cc28cf51]
>
>  TASK: [pip_install | Install PIP (fall back mode)] ****************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [pip_lock_down | Create pip config directory] ***************************
>  ok: [aio1_galera_container-cc28cf51] => (item=/root/.pip)
>  ok: [aio1_galera_container-cc28cf51] => (item=/root/.pip/base)
>  ok: [aio1_galera_container-cc28cf51] => (item=/root/.pip/links.d)
>  ok: [aio1_galera_container-cc28cf51] => (item=/root/.cache)
>  ok: [aio1_galera_container-cc28cf51] => (item=/root/.cache/pip)
>
>  TASK: [pip_lock_down | Drop pip lockdown file(s)] *****************************
>  ok: [aio1_galera_container-cc28cf51] => (item={'dest': u'/root/.pip/pip-link-build.py', 'src': 'pip-link-build.py', 'mode': '0755'})
>
>  TASK: [pip_lock_down | Drop pip global config(s)] *****************************
>  ok: [aio1_galera_container-cc28cf51] => (item={'dest': u'/root/.pip/base/global.conf', 'src': 'global.conf.j2', 'config_type': 'ini', 'config_overrides': {}})
>
>  TASK: [pip_lock_down | Drop pip link file(s)] *********************************
>  ok: [aio1_galera_container-cc28cf51] => (item={'link': u'http://172.29.236.100:8181/os-releases/12.0.14/', 'name': 'openstack_release'})
>
>  TASK: [pip_lock_down | Execute pip config builder] ****************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_client | Add galera apt-keys] ***********************************
>  ok: [aio1_galera_container-cc28cf51] => (item={'key_name': 'mariadb', 'hash_id': '0xcbcb082a1bb943db', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>  ok: [aio1_galera_container-cc28cf51] => (item={'key_name': 'percona-xtrabackup', 'hash_id': '0x1c4cbdcdcd2efd2a', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>
>  TASK: [galera_client | Add galera apt-keys using fallback keyserver] **********
>  skipping: [aio1_galera_container-cc28cf51] => (item={'key_name': 'mariadb', 'hash_id': '0xcbcb082a1bb943db', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>  skipping: [aio1_galera_container-cc28cf51] => (item={'key_name': 'percona-xtrabackup', 'hash_id': '0x1c4cbdcdcd2efd2a', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>
>  TASK: [galera_client | Drop galera repo pin] **********************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_client | Add galera repo(s)] ************************************
>  ok: [aio1_galera_container-cc28cf51] => (item={'repo': u'deb https://mirror.rackspace.com/mariadb/repo/10.0/ubuntu trusty main', 'state': 'present'})
>  ok: [aio1_galera_container-cc28cf51] => (item={'repo': u'deb https://repo.percona.com/apt trusty main', 'state': 'present'})
>
>  TASK: [galera_client | Download the galera package] ***************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_client | Update apt sources] ************************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_client | Install galera packages] *******************************
>  changed: [aio1_galera_container-cc28cf51] => (item=libaio1,libc6,libdbd-mysql-perl,libgcc1,libgcrypt11,libmariadbclient-dev,libstdc++6,mariadb-client,mariadb-client-core-10.0)
>
>  TASK: [galera_client | UnInstall system xtrabackup packages] ******************
>  ok: [aio1_galera_container-cc28cf51] => (item=percona-xtrabackup,xtrabackup)
>
>  TASK: [galera_client | Install galera package] ********************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_client | Install pip packages] **********************************
>  ok: [aio1_galera_container-cc28cf51] => (item=MySQL-python)
>  ok: [aio1_galera_container-cc28cf51] => (item=python-memcached)
>  ok: [aio1_galera_container-cc28cf51] => (item=pycrypto)
>
>  TASK: [galera_client | Drop local .my.cnf file] *******************************
>  ok: [aio1_galera_container-cc28cf51] => (item={'dest': '/root/.my.cnf', 'src': 'client.my.cnf.j2', 'config_type': 'ini', 'config_overrides': {}})
>
>  TASK: [galera_server | Check major galera install version] ********************
>  changed: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Check for any galera install version] ******************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Check if major version of Galera is installed] *********
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Set fact to ignore cluster state] **********************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Stop MariaDB] ******************************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Find old sources] **************************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Remove old sources] ************************************
>  skipping: [aio1_galera_container-cc28cf51] => (item=old_sources.stdout_lines)
>
>  TASK: [galera_server | Update apt sources (Forced)] ***************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | UN-Install galera-server package] **********************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Confirm service connectivity] **************************
>  changed: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Check that WSREP is ready] *****************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Set running state fact] ********************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Check for cluster state failure] ***********************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Gather mysql facts] ************************************
>  failed: [aio1_galera_container-cc28cf51] => {"failed": true}
>  msg: Mysql fact collection failed: "ERROR 2003 (HY000): Can't connect to MySQL server on '127.0.0.1' (111 "Connection refused")".
>  ...ignoring
>
>  TASK: [galera_server | Check for cluster state failure] ***********************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Check for cluster state failure] ***********************
>  skipping: [aio1_galera_container-cc28cf51] => (item=aio1_galera_container-cc28cf51)
>
>  TASK: [galera_server | set_fact ] *********************************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Update apt sources] ************************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Install galera pre packages] ***************************
>  ok: [aio1_galera_container-cc28cf51] => (item=debconf-utils,libaio1,libc6,libdbd-mysql-perl,libgcc1,libgcrypt11,libstdc++6,python-software-properties,software-properties-common)
>
>  TASK: [galera_server | Add galera apt-keys] ***********************************
>  ok: [aio1_galera_container-cc28cf51] => (item={'key_name': 'mariadb', 'hash_id': '0xcbcb082a1bb943db', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>  ok: [aio1_galera_container-cc28cf51] => (item={'key_name': 'percona-xtrabackup', 'hash_id': '0x1c4cbdcdcd2efd2a', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>
>  TASK: [galera_server | Add galera apt-keys using fallback keyserver] **********
>  skipping: [aio1_galera_container-cc28cf51] => (item={'key_name': 'mariadb', 'hash_id': '0xcbcb082a1bb943db', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>  skipping: [aio1_galera_container-cc28cf51] => (item={'key_name': 'percona-xtrabackup', 'hash_id': '0x1c4cbdcdcd2efd2a', 'keyserver': 'hkp://keyserver.ubuntu.com:80', 'fallback_keyserver': 'hkp://p80.pool.sks-keyservers.net:80'})
>
>  TASK: [galera_server | Drop galera repo pin] **********************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Add galera repo(s)] ************************************
>  ok: [aio1_galera_container-cc28cf51] => (item={'repo': u'deb https://mirror.rackspace.com/mariadb/repo/10.0/ubuntu trusty main', 'state': 'present'})
>  ok: [aio1_galera_container-cc28cf51] => (item={'repo': u'deb https://repo.percona.com/apt trusty main', 'state': 'present'})
>
>  TASK: [galera_server | Download the galera package] ***************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Prevent galera from starting on install] ***************
>  changed: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Drop limits config] ************************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Preseed galera password(s)] ****************************
>  ok: [aio1_galera_container-cc28cf51] => (item={'vtype': 'string', 'question': 'mysql-server/root_password', 'name': u'mariadb-galera-server-10.0', 'value': u'aa8a8bfb44df0925e903a1'})
>  ok: [aio1_galera_container-cc28cf51] => (item={'vtype': 'string', 'question': 'mysql-server/root_password_again', 'name': u'mariadb-galera-server-10.0', 'value': u'aa8a8bfb44df0925e903a1'})
>
>  TASK: [galera_server | Update apt sources] ************************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Install galera packages] *******************************
>  changed: [aio1_galera_container-cc28cf51] => (item=mariadb-client,mariadb-galera-server-10.0,galera-3,qpress,rsync,socat)
>
>  TASK: [galera_server | UnInstall system xtrabackup packages] ******************
>  ok: [aio1_galera_container-cc28cf51] => (item=percona-xtrabackup,xtrabackup)
>
>  TASK: [galera_server | Install galera package] ********************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Install pip packages] **********************************
>  ok: [aio1_galera_container-cc28cf51] => (item=MySQL-python)
>  ok: [aio1_galera_container-cc28cf51] => (item=python-memcached)
>  ok: [aio1_galera_container-cc28cf51] => (item=pycrypto)
>
>  TASK: [galera_server | Create the local directories] **************************
>  changed: [aio1_galera_container-cc28cf51] => (item={'owner': 'mysql', 'path': '/var/lib/mysql', 'mode': '2755'})
>  changed: [aio1_galera_container-cc28cf51] => (item={'owner': 'mysql', 'path': '/var/log/mysql', 'mode': '2755'})
>  ok: [aio1_galera_container-cc28cf51] => (item={'owner': 'mysql', 'path': '/var/log/mysql_logs/', 'group': 'syslog', 'mode': '2755'})
>  ok: [aio1_galera_container-cc28cf51] => (item={'path': '/etc/mysql/conf.d'})
>
>  TASK: [galera_server | Drop mariadb config(s)] ********************************
>  ok: [aio1_galera_container-cc28cf51] => (item={'dest': '/etc/mysql/my.cnf', 'src': 'my.cnf.j2', 'config_type': 'ini', 'config_overrides': {}})
>  ok: [aio1_galera_container-cc28cf51] => (item={'dest': '/etc/mysql/conf.d/cluster.cnf', 'src': 'cluster.cnf.j2', 'config_type': 'ini', 'config_overrides': {}})
>  changed: [aio1_galera_container-cc28cf51] => (item={'dest': '/etc/mysql/debian.cnf', 'src': 'debian.cnf.j2', 'config_type': 'ini', 'config_overrides': {}})
>
>  TASK: [galera_server | fix mysql startup timeout] *****************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Drop mariadb config(s)] ********************************
>  ok: [aio1_galera_container-cc28cf51] => (item={'dest': '/etc/default/mysql', 'src': 'mysql_defaults.j2'})
>
>  TASK: [galera_server | remove default mysql_safe_syslog] **********************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Remove policy-rc] **************************************
>  changed: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Start MySQL] *******************************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Confirm service connectivity] **************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Check that WSREP is ready] *****************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Set running state fact] ********************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Run MySQL Upgrade] *************************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Confirm service connectivity] **************************
>  changed: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Check that WSREP is ready] *****************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Set running state fact] ********************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Start cluster with wsrep] ******************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Wait for operational state] ****************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | set_fact ] *********************************************
>  skipping: [aio1_galera_container-cc28cf51]
>
>  NOTIFIED: [galera_server | Restart mysql] *************************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Confirm service connectivity] **************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Check that WSREP is ready] *****************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Set running state fact] ********************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [galera_server | Create galera users] ***********************************
>  skipping: [aio1_galera_container-cc28cf51] => (item={'priv': '*.*:ALL,GRANT', 'state': 'present', 'password': u'aa8a8bfb44df0925e903a1', 'host': '%', 'name': u'root'})
>  skipping: [aio1_galera_container-cc28cf51] => (item={'priv': '*.*:ALL', 'state': 'absent', 'password': u'aa8a8bfb44df0925e903a1', 'host': 'localhost', 'name': u'root'})
>  skipping: [aio1_galera_container-cc28cf51] => (item={'priv': '*.*:USAGE', 'state': 'present', 'password': u'', 'host': '%', 'name': u'monitoring'})
>  skipping: [aio1_galera_container-cc28cf51] => (item={'priv': '*.*:USAGE', 'state': 'present', 'password': u'', 'host': 'localhost', 'name': u'monitoring'})
>
>  TASK: [rsyslog_client | Ensure ownership on working directory is correct] *****
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [rsyslog_client | Rsyslog apt repository] *******************************
>  skipping: [aio1_galera_container-cc28cf51] => (item=rsyslog_client_apt_repos)
>
>  TASK: [rsyslog_client | Update apt sources] ***********************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [rsyslog_client | Install rsyslog packages] *****************************
>  ok: [aio1_galera_container-cc28cf51] => (item=rsyslog,logrotate)
>
>  TASK: [rsyslog_client | Stop rsyslog] *****************************************
>  changed: [aio1_galera_container-cc28cf51]
>
>  TASK: [rsyslog_client | Rsyslog Setup] ****************************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [rsyslog_client | Find all log files] ***********************************
>  changed: [aio1_galera_container-cc28cf51]
>
>  TASK: [rsyslog_client | Write rsyslog config for found log files] *************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [rsyslog_client | Union the log files] **********************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [rsyslog_client | Write rsyslog target file] ****************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [rsyslog_client | Write log rotate file] ********************************
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [rsyslog_client | Configure logrotate to compress logs by default] ******
>  ok: [aio1_galera_container-cc28cf51]
>
>  TASK: [rsyslog_client | Start rsyslog] ****************************************
>  changed: [aio1_galera_container-cc28cf51]
>
>  TASK: [system_crontab_coordination | Create crontab] **************************
>  changed: [aio1_galera_container-cc28cf51]
>
>  PLAY RECAP ********************************************************************
>  aio1_galera_container-9397b8ed : ok=74   changed=17   unreachable=0    failed=0
>  aio1_galera_container-cc28cf51 : ok=72   changed=15   unreachable=0    failed=0
>  aio1_galera_container-e9b772e6 : ok=72   changed=15   unreachable=0    failed=0
>
>  root@controller:~#

once this completes, you can open up your web browser and navigate to:  http://192.168.56.56

u: admin
p: admin

When you are done playing with it you should create a snapshot of the appliance.  This prevents you from having to go through the above steps every time you want to use it.  Simply restore to the snapshot.

> I created "COA-snapshot".

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

losetup /dev/loop4 /openstack/cinder.img; pvscan ; sudo service cinder-volume restart


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
