#!/bin/bash 
 
echo "----WELCOME TO TIC TAC TOE------"
echo "  you will play against the CPU"

#play board creation
ar=(" " " " " " " " " " " " " " " " " ")
echo "----------------------------------"
echo "user ip: x               cpu ip: 0"
echo "----------------------------------"
echo  "press T to do a toss"
read toss_choice

ShowTheBoard(){
	echo " ${ar[0]} | ${ar[1]} | ${ar[2]} "
	echo "---|---|---"
	echo " ${ar[3]} | ${ar[4]} | ${ar[5]} "
	echo "---|---|---"
	echo " ${ar[6]} | ${ar[7]} | ${ar[8]} "
}

Terminate(){
	echo "---------------YOU'R OUT OF THE GAME--------------"
	exit 
}

PlayCPU(){
	echo "cpu played"
	ShowTheBoard
	PlayUser
}

####

PlayUser(){
	echo "enter row(1-3), col(1-3):"
	read -p "Row No:" r
	read -p "Col No:" c
	i=$(($(( (($(($r-1)) ))*3)) + $(($c-1)) ))
	ar[$i]="x"

	ShowTheBoard
	#CheckUserWinOrLose
	PlayCPU
}

TossChoice (){
	if [ $toss_choice == "T" ] || [ $toss_choice == "t" ]
	then
		if [ $(($RANDOM%2)) -eq 0 ]
		then 
			toss_result="T"
			echo "You won the toss. Start playing.."
			PlayUser
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