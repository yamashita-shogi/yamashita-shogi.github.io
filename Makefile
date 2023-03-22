CURRENT_SHORTHASH := $(shell git rev-parse --short HEAD)

# GOOGLE_CLOUD_PROJECT ?= c-154-pjz-tipstar-dev

# # TODO: リポジトリ名変更後変える
# BIN_NAME := tipstar-news-feed-image-api

# # buildpack用
# GOOGLE_BUILDABLE := /workspace/cmd/$(BIN_NAME)
# BUILD_LOG_PATH := gs://tipstar-cloudbuild-log/tipstar-activity-image-api/

# DOCKER_CACHE_SRC ?= /tmp/.buildx-cache
# DOCKER_CACHE_DEST ?= /tmp/.buildx-cache-new
# DOCKER_CACHE_FROM ?= type=local,src=${DOCKER_CACHE_SRC}
# DOCKER_CACHE_TO ?= type=local,dest=${DOCKER_CACHE_DEST},mode=max

# CLOUDRUN_REGION ?= asia-northeast1
# CLOUDRUN_PORT := 8080
# #CLOUDRUN_MEMORY_LIMIT := 128Mi
# #CLOUDRUN_MIN_INSTANCES := 1
# #CLOUDRUN_MAX_CONCURRENCY := 50
# CLOUDRUN_ENV_OPT ?= ""
# ifeq ($(CLOUDRUN_ENV_OPT),)
# CLOUDRUN_OPT :=
# else
# CLOUDRUN_OPT := --update-env-vars=$(CLOUDRUN_ENV_OPT)
# endif

# # TODO: リポジトリ名変更後変数に置き換える
# IMAGE_NAME := asia-northeast1-docker.pkg.dev/$(GOOGLE_CLOUD_PROJECT)/tipstar-activity-image-api/tipstar-activity-image-api/$(BRANCH)

PROJECTNAME := $(shell basename "$(PWD)")
REGION := asia-northeast1
ECR := 184932865087.dkr.ecr.ap-northeast-1.amazonaws.com

.DEFAULT_GOAL := help

deploy:
	hexo clean && hexo deploy

#hexo new "aaa"

# Makefile config
#===============================================================
help: ## Print help
	echo "Usage: make [task]\n\nTasks:"
	perl -nle 'printf("    \033[33m%-30s\033[0m %s\n",$$1,$$2) if /^([a-zA-Z_-]*?):(?:.+?## )?(.*?)$$/' $(MAKEFILE_LIST)

.SILENT: help

.PHONY: $(shell grep -E -o '^(\._)?[a-z_-]+:' $(MAKEFILE_LIST) | sed 's/://')
