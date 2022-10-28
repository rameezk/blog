POST_TITLE ?= $(shell bash -c 'read -p "title[e.g. my-super-title]: " title; echo $$title')
CURRENT_YEAR := $(shell bash -c 'date "+%Y"')
CURRENT_DATE := $(shell bash -c 'date "+%Y-%m-%d"')

dev:
	hugo server -D

build:
	hugo --gc --minify --verbose

update-theme:
	git submodule update --remote --merge

new-post:
	@hugo new -k post posts/$(CURRENT_YEAR)/$(CURRENT_DATE)--$(POST_TITLE)

