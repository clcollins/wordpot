FROM centos:centos7

LABEL maintainer Alexander Merck <alexander.t.merck@gmail.com>
LABEL name "wordpot"
LABEL version "0.1"
LABEL release "2"
LABEL summary "Wordpot Honeypot container"
LABEL description "Wordpot is a Wordpress honeypot which detects probes for plugins, themes, timthumb and other common files used to fingerprint a wordpress installation."
LABEL authoritative-source-url "https://github.com/CommunityHoneyNetwork/wordpot"
LABEL changelog-url "https://github.com/CommunityHoneyNetwork/wordpot/commits/master"

# Set DOCKER var - used by Wordpot init to determine logging
ENV DOCKER "yes"

RUN useradd wordpot \
      && usermod -aG users wordpot

RUN yum install -y epel-release \
      && yum install -y git python2-pip \
      && yum clean all \
      && rm -rf /var/cache/yum

RUN pip --no-cache-dir install --upgrade pip

USER wordpot

RUN git clone --depth 1 https://github.com/threatstream/wordpot.git /home/wordpot/wordpot

WORKDIR /home/wordpot/wordpot

RUN pip --no-cache-dir install --user setuptools \
      && pip --no-cache-dir install --user --requirement requirements.txt

COPY wordpot-logger.py wordpot/logger.py
COPY wordpot.conf-default wordpot.conf

USER root
RUN chown -R wordpot.wordpot .
USER wordpot

CMD [ "python", "wordpot.py" ]
