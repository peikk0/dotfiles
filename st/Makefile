ST_GIT?=	git://git.suckless.org/st
ST_REF?=	master
BUILD?=		$(CURDIR)/build
DESTDIR?=	$(HOME)/.local/bin

default: all

$(BUILD):
	git clone -b $(ST_REF) $(ST_GIT) $(BUILD)

checkout: $(BUILD)
	cd $(BUILD) && git fetch --all && git checkout $(ST_REF) && git pull

$(BUILD)/st.c: $(BUILD)

$(BUILD)/config.h: config.h
	cp $< $@

$(BUILD)/st: $(BUILD)/st.c $(BUILD)/config.h
	cd $(BUILD) && make

terminfo: $(BUILD)
	cd $(BUILD) && tic -sx st.info

all: $(BUILD)/st

install: all
	install -m 0775 $(BUILD)/st $(DESTDIR)

.PHONY: checkout all install
