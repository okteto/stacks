URL?=https://okteto.github.io/stack/
DIRS = $(shell ls -d -- */)

.PHONY: all package index $(DIRS)
all: package index

package: $(DIRS)

$(DIRS):
	helm lint $@
	helm package $@ --destination $@

index:
	helm repo index --url $(URL) .
	
	
