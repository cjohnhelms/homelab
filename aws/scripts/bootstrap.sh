#!/bin/bash

adduser ansible
echo "ansible ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/ansible
dnf install -y vim git
mkdir -p /home/ansible/.ssh
cat << EOF > /home/ansible/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJM/yQdD/DrmZlWiZpmFtuTnL6EYWidZaRpqS7hnB3BY/C6DcYAoLRyzwtWIM49+OXO8fAtiYWAxcqo3SRTYM8EYDwL6JYASKI/CRJ9g6zsYBfkcmLL5hk+/6Fd12eIheo9UsoWS5b4elrwRD2MfUuVUGobF/+6o6VzbHpwEAm0uzLly3aX7cql2NE0MryMBLmAtA8YgCEBIJem7gaXurkn8MU3+M9SmkKWl4+RXTaH2nvFRkGkqCJ7dwJ/ssBor964Lxl0Y8ULKLzSOaTAfbgI8QfFJApgz/Fdna1FZCvqzlPcL/NGHzM3gVYrvkfhqc87YSZuIUaLMEXDZpOuHl5v/sGpraRgsSMH5tZx/IPToOb9efVRjdHxQn5UQEM+mrqwDhkLmIXN1S0IX5A37r2tqZhEdzvNJL2kkHcUIPXftdotcjDDeBM80EosuGqcuX3skUcDzLKvKN4GpE8w+wxexVLrq3wuuuZIoFZ8TGwt5b4XhcGVJIdyexNPztZMg0= cjohnhelms@macbook.local
EOF
chown -R ansible.ansible /home/ansible/
