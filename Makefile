-include local.mk

connect:
	adb connect $(DEVICE_IP):$(DEVICE_PORT)

install-android: build-apk
	flutter install $(DEVICE_IP):$(DEVICE_PORT)

build-apk:
	flutter build apk