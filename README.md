# PDE

## (Or, Prescriptive Data Exercise)

Using NGINX, Registrator, Consul and Consul-Template to Load Balance between Nginx Web Servers.

### How to Run

```
docker-compose build                   #make sure there are no image conflicts
docker-compose up --scale nginx-web=5  #scale the web servers up and down with this command
```

Consul API is available on `localhost:8500` and the web server is available on `localhost` - might want to change to a non-privileged port.

### How it works

Registrator connects to the docker UNIX socket to get information on containers sent to Consul. Consul-template is used in both the LB Nginx Container to provide the LB `nginx-web` container endpoints, and in the Web Server Nginx containers to provide a list of all Containers.

### Improvements

- Bootstrap Consul Server with 3 instances instead of one for HA, and add Clients across a larger pool of Container Instances/Kubernetes
- Add Service Health Checks (would necessitate another Dockerfile)
- Introduce a `rsyslog`, `statsd`, or similiar loging service for log consolidation in one endpoint
- Consul Connect would add a layer of authentication. TLS between the Nginx LB and Web Servers would prevent anonymous proxies
- `Nginx Web Servers` block would benefit from not being an `<embed>`

### Load Handling

Scaling up the web servers to 55 containers used ~4 GB and 20% of my laptop's CPU. Could probably comfortably scale up the web servers up to 200 containers, and many more with a cluster of container instances. No limits found with performance of Consul/Registrator.

### Sources

- [Setting Up an NGINX Demo Environment](https://docs.nginx.com/nginx/deployment-guides/setting-up-nginx-demo-environment/)
- [Load Balancing with NGINX and Consul Template](https://learn.hashicorp.com/tutorials/consul/load-balancing-nginx?in=consul/load-balancing)
