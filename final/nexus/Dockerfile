FROM debian:buster

RUN apt-get update && apt-get install -y ansible

ADD files /tmp/files

RUN ansible-galaxy install geerlingguy.java && ansible-galaxy install ansible-thoteam.nexus3-oss && ansible-playbook /tmp/files/nexus.yaml

CMD /etc/init.d/nexus run 