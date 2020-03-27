#!/bin/bash

val=(" " " " " " " " " " " " " " " " " ")
echo "user ip: x"
echo "cpu ip: 0"
echo "----------------"
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
		else
			toss_result="H"
		fi
	else
		read -p "INVALID INPUT: press Enter to try again, E to exit>> " tryexit
		if [[ -z "$tryexit" ]]
		then
			TossChoice
		elif [ $tryexit == "e" ]
		then
			Terminate
		fi 
	
	fi
}

TossChoice

#USER PLAYING
if [ "$toss_result" == "T" ]
then
	echo "You won the Toss. Start playing."
	echo "enter row(1-3), col(1-3):"
	read -p "Row No:" r
	read -p "Col No:" c
	i=$(($(( (($(($r-1)) ))*3)) + $(($c-1)) ))
	val[$i]="x"
fi

#COMPUTER PLAYING
if [ "$toss_result" == "H" ]
then
	echo "CPU won the toss."
	echo "computer's turn"
fi

echo ""
echo " ${val[0]} | ${val[1]} | ${val[2]} "
echo "---|---|---"
echo " ${val[3]} | ${val[4]} | ${val[5]} "
echo "---|---|---"
echo " ${val[6]} | ${val[7]} | ${val[8]} "









