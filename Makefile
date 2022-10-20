dev:
	hugo server -D

build:
	hugo --gc --minify --verbose

update-theme:
	git submodule update --remote --merge

