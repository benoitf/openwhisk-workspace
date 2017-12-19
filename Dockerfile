FROM registry.devshift.net/che/centos_jdk8
RUN sudo yum update -y && \
    sudo yum -y install gzip && \
    sudo yum -y install centos-release-scl && \
    sudo yum -y install rh-nodejs6 && \
    sudo yum -y install rh-python35 && \
    sudo ln -s /opt/rh/rh-nodejs6/root/usr/bin/node /usr/local/bin/nodejs && \
    sudo scl enable rh-nodejs6 'npm install --unsafe-perm -g typescript' && \
    cat /opt/rh/rh-nodejs6/enable >> /home/user/.bashrc && \
    sudo yum clean all && \
    cd $HOME && curl -LO https://github.com/apache/incubator-openwhisk-cli/releases/download/latest/OpenWhisk_CLI-latest-linux-amd64.tgz && \
    cd $HOME && tar zxf OpenWhisk_CLI-latest-linux-amd64.tgz && rm OpenWhisk_CLI-latest-linux-amd64.tgz && mkdir $HOME/bin && mv wsk $HOME/bin
ENV PATH=$HOME/bin:/opt/rh/rh-python35/root/usr/bin:/opt/rh/rh-nodejs6/root/usr/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/opt/rh/rh-python35/root/usr/lib64/:/opt/rh/rh-nodejs6/root/usr/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
#ENV PYTHONPATH=/opt/rh/rh-/root/usr/lib/python2.7/site-packages${PYTHONPATH:+:${PYTHONPATH}}
ENV MANPATH=/opt/rh/rh-nodejs6/root/usr/share/man:$MANPATH

EXPOSE 1337 3000 4200 5000 9000 8003
LABEL che:server:8003:ref=angular che:server:8003:protocol=http che:server:3000:ref=node-3000 che:server:3000:protocol=http che:server:9000:ref=node-9000 che:server:9000:protocol=http

