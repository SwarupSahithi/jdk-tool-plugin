# Use root temporarily to change permissions and install plugins
USER root

RUN mkdir -p /usr/share/jenkins/ref/plugins \
 && chmod -R 777 /usr/share/jenkins/ref/plugins \
 && jenkins-plugin-cli --plugins configuration-as-code:1775.v810dc950b_514

# Switch back to Jenkins user
USER jenkins
