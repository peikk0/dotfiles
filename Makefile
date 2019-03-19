DESTDIR:=	${HOME}
SET:=		lite

default: install

check:
	@/bin/sh check.sh

install:
	@/bin/sh install.sh -d ${DESTDIR} ${SET}

update: git-update install

git-update:
	@git pull origin master
	@git submodule update --init --recursive

.PHONY: default install update git-update check
