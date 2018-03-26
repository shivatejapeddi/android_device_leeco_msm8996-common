####Leeco Extra Settings Module by @andr68rus
#####Add following lines to your device tree mk file to add module:
```
  # LePref settigs modules
  PRODUCT_PACKAGES += \
      LePref

  # LePref Files
  PRODUCT_COPY_FILES += \
      $(call find-copy-subdir-files,*,device/leeco/msm8996-common/lepref/files,/system/etc)
```
Enjoy it ;)
