#! /vendor/bin/sh

# common functions
symlink() {
	ln -sn $1 $2;
}

# mount system (which could be root or /system depending on ROM) and vendor as rw
mount -o remount,rw /
mount -o remount,rw /system
mount -o remount,rw /vendor


# symlink camera
symlink /vendor/bin/mm-qcamera-daemon /vendor/bin/mm-qcamera-daemon
symlink /vendor/etc/imx230_chromatix.xml /system/etc/imx230_chromatix.xml
symlink /vendor/etc/imx230_lg_chromatix.xml /system/etc/imx230_lg_chromatix.xml
symlink /vendor/etc/imx230_sunny_chromatix.xml /system/etc/imx230_sunny_chromatix.xml
symlink /vendor/etc/msm8996_camera.xml /system/etc/msm8996_camera.xml
symlink /vendor/etc/ov8865_chromatix.xml /system/etc/ov8865_chromatix.xml
symlink /vendor/etc/ov8865_ofilm_chromatix /system/etc/ov8865_ofilm_chromatix.xml
symlink /vendor/lib/libamipengine.so /system/lib/libamipengine.so
symlink /vendor/lib/libarcsoft_antishaking.so /system/lib/libarcsoft_antishaking.so
symlink /vendor/lib/libarcsoft_beautyshot.so /system/lib/libarcsoft_beautyshot.so
symlink /vendor/lib/libarcsoft_beautyshot_image_algorithm.so /system/lib/libarcsoft_beautyshot_image_algorithm.so
symlink /vendor/lib/libarcsoft_beautyshot_video_algorithm.so /system/lib/libarcsoft_beautyshot_video_algorithm.so
symlink /vendor/lib/libarcsoft_hdr.so /system/lib/libarcsoft_hdr.so
symlink /vendor/lib/libarcsoft_hdr_detection.so /system/lib/libarcsoft_hdr_detection.so
symlink /vendor/lib/libarcsoft_night_shot.so /system/lib/libarcsoft_night_shot.so
symlink /vendor/lib/libarcsoft_nighthawk.so /system/lib/libarcsoft_nighthawk.so
symlink /vendor/lib/libarcsoft_panorama_burstcapture.so /system/lib/libarcsoft_panorama_burstcapture.so
symlink /vendor/lib/libarcsoft_smart_denoise.so /system/lib/libarcsoft_smart_denoise.so
symlink /vendor/lib/libcamera_letv_algo.so /system/lib/libcamera_letv_algo.so
symlink /vendor/lib/libletv_algo_jni.so /system/lib/libletv_algo_jni.so
symlink /vendor/lib/libLetvCameraImageSDK.so /system/lib/libLetvCameraImageSDK.so
symlink /vendor/lib/libmm-qcamera.so /system/lib/libmm-qcamera.so
symlink /vendor/lib/libmpbase.so /system/lib/libmpbase.so
symlink /vendor/lib/libmpkernel.so /system/lib/libmpkernel.so
symlink /vendor/lib/libmpstream.so /system/lib/libmpstream.so
symlink /vendor/lib/libmputility.so /system/lib/libmputility.so
symlink /vendor/lib/libqrDec.so /system/lib/libqrDec.so
symlink /vendor/lib/libzeusisCameraAlgoSceneDetection.so /system/lib/libzeusisCameraAlgoSceneDetection.so
if [ ! -d "/system/etc/camera" ]; then mkdir /system/etc/camera; fi
chmod 755 /system/etc/camera
cd /vendor/etc/camera/
for f in *; do
	symlink /vendor/etc/camera/$f /system/etc/camera/$f
done

# remount system and vendor as ro
mount -o remount,ro /
mount -o remount,ro /system
mount -o remount,ro /vendor