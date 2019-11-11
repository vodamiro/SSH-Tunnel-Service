FROM ubuntu

# Install SSHD
RUN apt-get update
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
VOLUME [ "/root/.ssh/"]

# Create remote user
RUN useradd remote
RUN mkdir /home/remote
VOLUME [ "/home/remote/.ssh/"]
RUN chown remote:remote /home/remote

# Configure SSHD
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#GatewayPorts no/GatewayPorts yes/' /etc/ssh/sshd_config
RUN sed -i 's/#ClientAliveInterval 0/ClientAliveInterval 15/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN echo 'AllowUsers root' >> /etc/ssh/sshd_config
RUN echo 'AllowUsers remote' >> /etc/ssh/sshd_config

EXPOSE 22
EXPOSE 10000:10100
CMD ["/usr/sbin/sshd", "-D"]