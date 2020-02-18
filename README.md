# Okteto Stack (WIP)
A developer-first application format for running containerized applications in k8s

## Why do we need Okteto Stacks?
Helm is a powerful technology to pack you applications and deploy to Kubernetes. It has a powerful engine that makes your application definition declarative. You create new objects or modified them, and Helm takes care of upgrading your resources or deleting the ones you don't need anymore.

But exposing helm templates to a developer is just overkill for the majority of use cases. Developers just want to define the docker image, ports, command, environment variables, volumes and little more. **Stacks** understands a simple docker-compose like format and uses the Helm templating system to traslate this format into Kubernetes resources. Stacks relies on Helm to deploy to Kubernetes, taking advantage of Helm declarative approach.

Also, Helm does not cover the full development cycle, like re-building docker images when needed, query application logs or check metrics. The Okteto Stack CLI will also cover these scenarios.

## Sample

The next sample is the Stack definition for the well-known Voting App application. As you can see, it is about 25 lines of yaml:

```yaml
services:
  vote:
    public: true
    image: dockersamples/examplevotingapp_vote:before
    replicas: 2
    env:
      - OPTION_A=Compose
      - OPTION_B=Helm
    ports:
      - 80

  result:
    public: true
    image: dockersamples/examplevotingapp_result:before
    command: node server.js
    ports:
      - 80

  worker:
    image: dockersamples/examplevotingapp_worker

  db:
    image: postgres:9.4
    ports:
      - 5432
    volumes:
      - /var/lib/postgresql/data

  redis:
    image: redis:alpine
    ports:
      - 6379
```

The equivalent Helm chart would have more than 400 lines of yaml!

To deploy this stack yaml, execute:

```console
helm install test chart -f okteto-stack.yaml
```

To destroy it:

```console
helm uninstall test
```

To render the Kubernetes manifests:

```console
helm template test ./chart -f okteto-stack.yaml
```

# Future work

- `okteto stack deploy` and `okteto stack destroy` commands to abstract the Helm based implementation.
- Add `build` directives to the staack yaml format.
- Support environment variables extrapolation.
- `okteto stack ps`, `okteto stack logs`, `okteto stack exec` and `okteto stack metrics`.