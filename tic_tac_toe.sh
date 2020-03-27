#!/bin/bash
 
echo "----WELCOME TO TIC TAC TOE------"
echo "  you will play against the CPU"

#play board creation

val=(" " " " " " " " " " " " " " " " " ")
echo "----------------------------------"
echo "user ip: x               cpu ip: 0"
echo "----------------------------------"
echo  "press T to do a toss"
read toss_choice

Terminate(){
	echo "---------------YOU'R OUT OF THE GAME--------------"
	exit 
}

TossChoice (){
	if [ $toss_choice == "T" ] || [ $toss_choice == "t" ]
	then
		if [ $(($RANDOM%2)) -eq 0 ]
		then 
			toss_result="T"
			echo "You won the toss. Start playing.."
			# PlayUser
		else
			toss_result="H"
			echo "CPU won the toss."
			# PlayCPU
		fi
	else
		read -p "INVALID INPUT: press Enter to try again, E to exit>> " tryexit
		if [[ -z "$tryexit" ]]
		then
			TossChoice
		elif [ "$tryexit" == "e" ]
		then
			Terminate
		fi 
	
	fi
}

TossChoice

echo " ${val[0]} | ${val[1]} | ${val[2]} "
echo "---|---|---"
echo " ${val[3]} | ${val[4]} | ${val[5]} "
echo "---|---|---"
echo " ${val[6]} | ${val[7]} | ${val[8]} "


# ResetBoard(){
# 	case $1 in 
# 		"r")
		
# }