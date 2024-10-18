 > [!IMPORTANT]  
> Okteto Stacks is now deprecated. Okteto now fully supports the Docker Compose format. [Learn more here](https://www.okteto.com/docs/tutorials/compose-getting-started/).

# Okteto Stacks

A developer-first application format for running containerized applications in k8s

## Why do we need Okteto Stacks?
Helm is a powerful technology to pack you applications and deploy to Kubernetes. It has a powerful engine that makes your application definition declarative. You create new objects or modified them, and Helm takes care of upgrading your resources or deleting the ones you don't need anymore.

But learning Helm can be too complex for the majority of use cases. Developers just want to define the docker image, ports, command, environment variables, volumes and little more. **Stacks** understands a simple docker-compose like format and uses the Helm templating system to translate this format into Kubernetes resources. Stacks relies on Helm to deploy to Kubernetes, taking advantage of Helm declarative approach and its ecosystem.

## Sample

The next sample is the Okteto Stack definition for the well-known Voting App application. As you can see, it is about 30 lines of yaml:

```yaml
services:
  vote:
    public: true
    image: okteto/vote:1
    replicas: 2
    ports:
      - 80

  result:
    public: true
    image: okteto/result:1
    command: node server.js
    ports:
      - 80

  worker:
    image: okteto/worker:1
    stop_grace_period: 60

  db:
    image: postgres:9.4
    environment:
      - POSTGRES_HOST_AUTH_METHOD=trust
    ports:
      - 5432
    volumes:
      - /var/lib/postgresql/data
    resources:
      cpu: 300m
      memory: 500Mi
      storage: 5Gi

  redis:
    image: redis:alpine
    ports:
      - 6379
```

The equivalent Helm chart would have more than 400 lines of yaml!

Useful links:

- [Getting started guide](https://github.com/okteto/stacks-getting-started)
- [Stack manifest reference](https://okteto.com/docs/reference/stacks)
- [Stacks CLI](https://okteto.com/docs/reference/cli#stack)
