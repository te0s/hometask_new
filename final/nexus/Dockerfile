FROM debian:buster

RUN apt-get clean && apt-get update \
&& apt-get install -y ansible

ADD files /tmp/files

RUN ansible-galaxy install ansible-thoteam.nexus3-oss \
&& ansible-playbook /tmp/files/nexus_setup.yml

EXPOSE 81

ENTRYPOINT service nexus start && bash