include $(TOPDIR)/rules.mk

PKG_NAME:=hellonux
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)
include $(INCLUDE_DIR)/package.mk

define Package/hellonux
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=hellonux
endef

define Package/hellonux/description
    hellonux
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Package/hellonux/install
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/hellonux $(1)/bin/
endef

$(eval $(call BuildPackage,hellonux))
