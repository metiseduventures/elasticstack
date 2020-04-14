osm_lagstash
=========

An Ansible Role for logstash which default install logstash 5 but can ce dynamic by passing extra-vars or changing the values in ```vars/main.yml```


Supported OS
------------
```This role will work on the following operating systems:

   * Centos 6
   * Centos 7
   * Ubuntu 14/16
   * Debian 14/16
   * Redhat 6/7
```
 
Requirements
------------
Java8 must be installed on the systems. JAVA_HOME must be defined either implicitely or explicitely.
Selinux must be disabled on the centOS/Redhat base systems.

Role Variables
--------------

Available variables are listed below, along with default values (see defaults/main.yml):

logstash_ms_heap_size: 128m

logstash_mx_heap_size: 512m

Node_name: Test

Queue_page_capacity: 250mb

Queue_max_bytes: 512mb

Http_host: "0.0.0.0"

Http_port: "9600"

elasticSearchIp: 192.168.0.225

Dependencies
------------

It depends on java8 and java_home and will fail if java is not found in the system

Example Playbook
----------------

Including an example of how to use osm_logstash role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: default
      roles:
         - { role: osm_logstash }

License
-------

BSD

Author Information
------------------

###### www.opstree.com

###### blog.opstree.com

