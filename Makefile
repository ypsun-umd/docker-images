#################
# Configuration #
#################

PANDOC_VERSION ?= edge

ifeq ($(PANDOC_VERSION),edge)
PANDOC_COMMIT          ?= master
else
PANDOC_COMMIT          ?= $(PANDOC_VERSION)
endif


###########
# Helpers #
###########

# Used to specify the build context path for Docker.
makefile_dir := $(dir $(realpath Makefile))

# Provide a standardized date format, which could be used for tagging
date := $(shell date "+%Y%m%d")

# Keep this target first so that `make` with no arguments will print this rather
# than potentially engaging in expensive builds.
.PHONY: show-args
show-args:
	@printf "PANDOC_VERSION (i.e. image version tag): %s\n" $(PANDOC_VERSION)
	@printf "pandoc_commit=%s\n" $(PANDOC_COMMIT)


################
# centos7-base #
################

.PHONY: centos7-base-latest centos7-base-clion

centos7-base-latest:
	docker build \
	    --tag umdlhcb/centos7-base:$(date) \
	    -f $(makefile_dir)/centos7-base/Dockerfile-base $(makefile_dir)/centos7-base
	docker tag umdlhcb/centos7-base:$(date) umdlhcb/centos7-base:latest


################################################################################
# Alpine images and tests                                                      #
################################################################################
.PHONY: alpine alpine-latex test-alpine test-alpine-latex
alpine:
	docker build \
	    --tag yipengsun/pandoc-core:$(PANDOC_VERSION) \
	    --build-arg pandoc_commit=$(PANDOC_COMMIT) \
	    -f $(makefile_dir)/alpine/Dockerfile $(makefile_dir)
alpine-latex:
	docker build \
	    --tag yipengsun/pandoc-latex:$(PANDOC_VERSION) \
	    --build-arg base_tag=$(PANDOC_VERSION) \
	    -f $(makefile_dir)/alpine/latex/Dockerfile $(makefile_dir)
