FROM debian:buster
RUN apt-get update && apt-get install -y ansible docker.io curl gnupg sudo daemon

COPY ./jenkins.yml /temp/jenkins.yml
COPY ./roles /etc/ansible/roles
COPY ./templates/ /templates/

RUN ansible-playbook /temp/jenkins.yml

EXPOSE 80

CMD /usr/bin/daemon --foreground --name=jenkins --inherit --env=JENKINS_HOME=/var/lib/jenkins --output=/var/log/jenkins/jenkins.log --pidfile=/var/lib/jenkins/jenkins.pid -- /usr/bin/java -Djava.awt.headless=true -Djenkins.install.runSetupWizard=false -Dhudson.security.csrf.GlobalCrumbIssuerConfiguration.DISABLE_CSRF_PROTECTION=true -jar /usr/share/java/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080 --prefix=
