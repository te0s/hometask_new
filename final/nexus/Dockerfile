FROM debian:buster
RUN apt-get update && apt-get install -y rsync ansible

COPY ./nexus.yml /temp/nexus.yml

RUN ansible-galaxy install ansible-thoteam.nexus3-oss && ansible-playbook /temp/nexus.yml

EXPOSE 81

CMD /etc/init.d/nexus run
