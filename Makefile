NAME = composer
MAJOR = 1.2.1
MINOR = 0
VERSION = $(MAJOR)-$(MINOR)
DESCRIPTION = GetComposer.org

.PHONY: all prepare download build

all: download prepare build

prepare:
	echo " -- Ernestas Lukosevicius <ernetas@gmail.com> $(date -R)" >> package/DEBIAN/changelog
	sed -i "s/version/$(VERSION)/g" package/DEBIAN/changelog
	sed -i "s/package/$(NAME)/g" package/DEBIAN/changelog
	cat package/DEBIAN/changelog
	sed -i "s/version/$(VERSION)/g" package/DEBIAN/control
	sed -i "s/description/$(DESCRIPTION)/g" package/DEBIAN/control
	sed -i "s/package/$(NAME)/g" package/DEBIAN/control

download:
	mkdir -p package/usr/bin/
	wget https://getcomposer.org/download/$(MAJOR)/composer.phar -O package/usr/bin/composer
	chmod +x package/usr/bin/composer

build:
	dpkg -b ./package/ $(NAME)-$(VERSION).deb
	dpkg --info $(NAME)-$(VERSION).deb
	dpkg -c $(NAME)-$(VERSION).deb
