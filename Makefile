JSONNET_SRC=$(shell find ./jsonnet -type f -not -path "./jsonnet/vendor*")
JSONNET_VENDOR=jsonnet/vendor


.PHONY: build-jsonnet
	build-jsonnet: jsonnet gojsontoyaml $(JSONNET_SRC) $(JSONNET_VENDOR)
	    ./scripts/generate.bash
