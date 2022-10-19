dev:
	hugo server -D --disableFastRender

build:
	hugo

update-theme:
	git submodule update --remote --merge

