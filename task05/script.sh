#!/bin/bash

vagrant destroy master.puppet -f
vagrant destroy slave2.puppet -f
vagrant destroy slave1.puppet -f
#ansible -i /vagrant/inventory/hosts all -m ping
#ansible-playbook -i /vagrant/inventory/hosts /vagrant/playbook.yaml
