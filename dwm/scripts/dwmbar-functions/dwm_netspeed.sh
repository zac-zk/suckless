dwm_netspeed(){

	ether="wlan0"

	#upsp=`cat /proc/net/dev | grep $ether | awk '{print $10}'`
	dosp=`cat /proc/net/dev | grep $ether | awk '{print $2}'`

	sleep 1

	#upsp1=`cat /proc/net/dev | grep $ether | awk '{print $10}'`
	dosp1=`cat /proc/net/dev | grep $ether | awk '{print $2}'`

	#nupsp=$(printf "%.2f" `echo "scale=2;($upsp1 - $upsp)/1024/1024" | bc`)
	kb=$(printf "%d" `echo "($dosp1 - $dosp)/1024" | bc`)
	#echo -e "Upload   speed :\033[49;33m $nupsp Mb/s \033[0m"
	
	if test "$kb" -gt 1024;then
			mb=$(printf "%.2f" `echo "scale=2;$kb/1024" | bc`)
			echo -e "↓ $mb Mb/s"
	else
		echo -e "↓ $kb Kb/s"
	fi

}
