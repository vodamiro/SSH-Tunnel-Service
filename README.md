# SSH Tunnel Service

## Description

This Docker image provides SSH tunnel service. Client devices can connect to the SSH server provided by this container. These devices will be later accessible via this containe and specific port.

## Usage

1) Add maintainer's SSH public key(s) to the `data/root/authorized_keys`. These users will be able to log-in to the container remotely.
2) Add client devices' SSH public key(s) to the `data/remote/authorized_keys`. These users will be able to bridge their SSH connection via this service.
3) Modify port mappings in `docker-compose.yml`. Default values: SSH service - `11022`, bridge ports pool: `10000-10100`.
4) Run `docker-compose up --build` on the server where the SSH tunnel service should be running.
5) Launch `ssh -f -N -T -R 10000:localhost:22 remote@1.2.3.4 -p 11022` where:
   * `localhost:22` = bridged (local) port - in this case we want to tunnel access to the client's SSH port
   * `10000` = remote port for accessing bridged (local) port - must be different for each client
   * `1.2.3.4` = public IP address or hostname of the SSH tunnel service
   * `11022` = port of the tunnel SSH service

So using following command `ssh remote@1.2.3.4 -p 10000` we can access the local port of the device defined by parameters above.