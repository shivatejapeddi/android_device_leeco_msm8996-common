#!/vendor/bin/sh
################################################################################
# helper functions to allow Android init like script
function write() {
    echo -n $2 > $1
}
function copy() {
    cat $1 > $2
}
################################################################################
    # Enable bus-dcvs
    write /sys/class/devfreq/soc:qcom,cpubw/governor "bw_hwmon"
    write /sys/class/devfreq/soc:qcom,cpubw/polling_interval 50
    write /sys/class/devfreq/soc:qcom,cpubw/min_freq 1525
    write /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/mbps_zones "1525 5195 11863 13763"
    write /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/sample_ms 4
    write /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/io_percent 34
    write /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/hist_memory 20
    write /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/hyst_length 10
    write /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/low_power_ceil_mbps 0
    write /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/low_power_io_percent 34
    write /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/low_power_delay 20
    write /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/guard_band_mbps 0
    write /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/up_scale 250
    write /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/idle_mbps 1600

done
for memlat in /sys/class/devfreq/*qcom,memlat-cpu* ; do
    write $memlat/governor "mem_latency"
    write $memlat/polling_interval 10
done
setprop sys.post_boot.parsed 1
# On debuggable builds, enable console_suspend if uart is enabled to save power
# Otherwise, disable console_suspend to get better logging for kernel crashes
if [[ $(getprop ro.debuggable) == "1" && ! -e /sys/class/tty/ttyHSL0 ]]
then
    write /sys/module/printk/parameters/console_suspend N
fi
