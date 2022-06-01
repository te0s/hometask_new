FROM debian:buster
RUN apt-get update && apt-get install -y rsync ansible

ADD files /tmp/files

RUN ansible-galaxy install ansible-thoteam.nexus3-oss && ansible-playbook /tmp/nexus.yml

EXPOSE 81

CMD /etc/init.d/nexus run