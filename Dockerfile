FROM jenkins/jenkins:lts

USER root

# Uncomment below for a full installation of docker-ce
#RUN apt-get update && apt-get install -y apt-transport-https
#COPY docker.list /etc/apt/sources.list.d/docker.list
#COPY docker.key /root/docker.key
#RUN apt-key add /root/docker.key
#RUN rm /root/docker.key
#RUN apt-get update && apt-get install -y docker-ce
#RUN usermod -aG docker jenkins

# Below is a "light" docker installation, which relies on mounting the host /usr/bin/docker
RUN apt-get update && apt-get install -y libltdl7
RUN groupadd -g 999 docker
RUN usermod -aG docker jenkins

# Install the list of plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# We have installed plugins above, so skip this step in the setup. (does not appear to work)
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

USER jenkins

ENV JENKINS_OPTS --prefix=/jenkins

