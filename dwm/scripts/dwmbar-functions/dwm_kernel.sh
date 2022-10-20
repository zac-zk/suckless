#!/bin/sh

dwm_kernel(){
	cpu_usage=$(top -bn 1 | grep '^%Cpu' | tr -d 'usy,' | awk '{print $2 }')
	mem_free=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}')/1024))M
	cpu_temp=$(tlp-stat -t | grep CPU |awk '{print $4}')

	echo -e " $mem_free $cpu_usage% $cpu_temp°C"
}

dwm_kernel
