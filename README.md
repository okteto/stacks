# Mola (WIP)
A developer-first application format for containerized applications running in k8s

## Why do we need Mola?
Helm is a powerful technology to pack you applications and deploy to Kubernetes. It has a powerful enfine that makes your applications declarative. You create new objects or modified them, annd Helm takes care of upgrading your resources or deleting the ones you don't need anymore.

But exposing helm templates to a developer is jst overkill for the majority of use cases. Developers just want to define the docker image, ports, command, environment variables, volumes and little more. *Mola* understand a simple docker-compose like format and uses the Helm templating system to traslate this format into Kubernetes resources. Mola relies on Helm to deploy to Kubernetes, taking advantage of Helm declarative approach.

Also, Helm does not cover the full development cycle, like re-building docker images wheen needed, query application logs or check metrics. 

## Sample

The next sample is the Mola definition for the tipical webapp application based on Django. As you can see, it is about 30 lines of yaml:

```yaml
services:
 frontend:
   public: true
   image: okteto/frontend:latest
   build: frontend/Dockerfile
   ports:
     - 80
 
 api:
   image: okteto/api:latest
   build: api/Dockerfile
   replicas: 2
   ports:
     - 8080
 
 worker:
   image: okteto/api:latest
   build: api/Dockerfile
   command: ./run_celery.sh
 
 db:
   image: postgres:9.4
   environment:
     - POSTGRES_PASSWORD=$PASSWORD
     - POSTGRES_DB=postgres
   ports:
     - 5432
   volumes:
     - /data
 
 cache:
   image: redis:2.8.19
   ports:
     - 6379
```

The equivalent Helm chart would have more than 400 lines of yaml! To deploy this mola yaml, execute:

```console
helm install sample ./chart -f mola.yaml
```

To destroy it:

```console
helm uninstall
```

To render the Kubernetes manifests:

```console
helm template ./chart -f mola.yaml
```

# Future work

- `mola deploy` and `mola destroy` commands to abstract the Helm based implementation.
- Add `build` directives to the mola yaml format.
- Add directives to expose public services.
- `mola logs`, `mola exec` and `mola meetrics`.