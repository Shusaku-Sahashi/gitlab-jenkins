FROM jenkins

USER root

RUN apt-get update \
  && apt-get install -y \
  apt-utils \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common \
  && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
  && apt-key fingerprint 0EBFCD88 \
  && add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable" \
  && apt-get update \
  && apt-get install -y docker-ce \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && usermod -aG docker jenkins

RUN cd tmp/ \
  && wget https://updates.jenkins-ci.org/latest/jenkins.war \
  && mv ./jenkins.war /usr/share/jenkins/

USER jenkins
