dev:
	hugo server -D --disableFastRender

build:
	hugo --gc --minify --verbose

build:
	hugo -D --gc --minify --verbose

update-theme:
	git submodule update --remote --merge

