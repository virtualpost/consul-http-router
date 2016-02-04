# Consul HTTP Router

A HTTP router based on NGiNX, routing traffic to all consul registered services with an 'http-path' or 'http-subdomain' tag.

## How to use
Start this service and any services in consul tagged with the specified tag will be proxied if a request comes in that matches one of the following:

1. a host address that matches `<servicename>.*`, ie. `hello-world.domain.com`, and the service is tagged with 'http-subdomain'.
2. a url path that matches `/<servicename>/`, ie. http://domain.com/hello-world/, and the service is tagged with 'http-path'.

```
docker run -d -P --dns <consul-host-ip> --dns-search=service.consul virtualpost/consul-http-router 
```

Therefore, there are two ways to access the same service. To get the proxy to work for host-based matching, you will need to create proper DNS host entries that point to your server that runs the router container.

__NOTE:__ Each individual container instance CANNOT be tagged with both UNLESS it's able to proxy both subdomain and path-based requests.  That's not possible in most cases.  However, each consul service CAN have different container instances servicing both subdomain and path-based requests.

## Using external templates

Default nginx.conf is generated from an internal nginx template file.  This file exists in /templates.  However, you can mount an external data volume or host directory to the container to override and make use of external templates:

```
docker run -d -P --dns-search=service.consul -v /host/path/to/templates:/templates:ro virtualpost/consul-http-router
```

