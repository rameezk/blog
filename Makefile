POST_TITLE ?= $(shell bash -c 'read -p "title[e.g. my-super-title]: " title; echo $$title')
CURRENT_YEAR := $(shell bash -c 'date "+%Y"')
CURRENT_DATE := $(shell bash -c 'date "+%Y-%m-%d"')

CHANGELOG_POSTS_COUNTER ?= $(shell cat .changelog-posts-counter)

MAKE = make

dev:
	hugo server -D

build:
	hugo --gc --minify

update-theme:
	hugo mod get -u

bump-changelog-counter:
	@python scripts/bump_changelog_posts_counter.py

new-post:
	@hugo new -k post posts/$(CURRENT_YEAR)/$(CURRENT_DATE)--$(POST_TITLE)

new-changelog: bump-changelog-counter
	@hugo new -k changelog posts/$(CURRENT_YEAR)/$(CURRENT_DATE)--changelog-$(CHANGELOG_POSTS_COUNTER)-$(POST_TITLE)

