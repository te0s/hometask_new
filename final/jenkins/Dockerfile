FROM debian:buster

RUN apt-get update && apt-get install -y ansible docker.io wget curl

ADD files /tmp/files

RUN ansible-galaxy install geerlingguy.java && ansible-galaxy install geerlingguy.jenkins && ansible-playbook /tmp/files/jenkins.yaml

CMD /usr/bin/daemon --name=jenkins --inherit --env=JENKINS_HOME=/var/lib/jenkins --output=/var/log/jenkins/jenkins.log --pidfile=/var/run/jenkins/jenkins.pid -- /usr/bin/java -Djava.awt.headless=true -Djenkins.install.runSetupWizard=false -Dhudson.security.csrf.DefaultCrumbIssuer.EXCLUDE_SESSION_ID=true -Dorg.jenkinsci.plugins.durabletask.BourneShellScript.LAUNCH_DIAGNOSTICS=true -jar /usr/share/jenkins/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080 --prefix= 