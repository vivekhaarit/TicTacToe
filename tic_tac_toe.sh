#!/bin/bash


val=(" " " " " " " " " " " " " " " " " ")
echo "user ip: x"
echo "cpu ip: 0"
echo "----------------"
echo  "press T to do a toss"
read toss_choice

ShowTheBoard(){
	echo " ${val[0]} | ${val[1]} | ${val[2]} "
	echo "---|---|---"
	echo " ${val[3]} | ${val[4]} | ${val[5]} "
	echo "---|---|---"
	echo " ${val[6]} | ${val[7]} | ${val[8]} "
}

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

RowCheck(){
	for((i=0;i<6;i++))
	do
		if [ "${val[$i]}" == "x" ] && [ "${val[$i+1]}" == "x" ] && [ "${val[$i+2]}" == "x" ]
		then
			echo "------------------YOU WON------------------"
			exit
		elif [ "${val[$i]}" == "o" ] && [ "${val[$i+1]}" == "o" ] && [ "${val[$i+2]}" == "o" ]
		then
			echo "----------------- CPU WON-------------------"
			exit
		fi
		i=$(($i+2))
	done
}

ColumnCheck(){
	for((i=0;i<3;i++))
	do
		if [ "${val[$i]}" == "x" ] && [ "${val[$i+3]}" == "x" ] && [ "${val[$i+6]}" == "x" ]
		then
			echo "------------------YOU WON------------------"
			exit
		elif [ "${val[$i]}" == "o" ] && [ "${val[$i+3]}" == "o" ] && [ "${val[$i+6]}" == "o" ]
		then
			echo "----------------- CPU WON-------------------"
			exit
		fi
	done
}

DiagonalCheck(){
	if [ "${val[0]}" == "x" ] && [ "${val[4]}" == "x" ] && [ "${val[8]}" == "x" ]
	then 
		echo "------------------------YOU WON--------------------------"
		exit
	elif [ "${val[0]}" == "o" ] && [ "${val[4]}" == "o" ] && [ "${val[8]}" == "o" ]
	then 
		echo "------------------------CPU WON--------------------------"
		exit
	elif [ "${val[2]}" == "x" ] && [ "${val[4]}" == "x" ] && [ "${val[6]}" == "x" ]
	then
		echo "-------------------------YOU WON---------------------------"
		exit
	elif [ "${val[2]}" == "o" ] && [ "${val[4]}" == "o" ] && [ "${val[6]}" == "o" ]
	then
		echo "-------------------------CPU WON---------------------------"
		exit
	fi
}

CPUCheckForCornersAndCentre(){
	for ((i=0;i<5;i++))				#checking for all the corners and a centre
	do
		local places=$(($(($RANDOM%5))*2))
		if [ "${val[$places]}" == " " ]
		then 
			val[$places]="o"
			ShowTheBoard
			CheckWinOrLose
			CheckDrawMatch
			PlayUser
		fi
	done	
}

CPUCheckForEdges(){
	for ((i=0;i<4;i++))
	do
		local places=$(($(($RANDOM%4))*2+1))
		if [ "${val[$places]}" == " " ]
		then 
			val[$places]="o"
			ShowTheBoard
			CheckWinOrLose
			CheckDrawMatch
			PlayUser
		fi
	done
}

CheckWinOrLose(){
	RowCheck
	ColumnCheck
	DiagonalCheck
}

CheckDrawMatch(){
	count=0;
	for ((i=0;i<9;i++))
	do
		if [ "${val[$i]}" != " " ]
		then
			((count++))
		else
			break
		fi
	done
	if [ $count -eq 9 ]
	then
		echo "------------------DRAW MATCH---------------------"
		exit
	fi
}

TossChoice

PlayUser(){
	echo "enter row(1-3), col(1-3):"
	read -p "Row No:" r
	read -p "Col No:" c
	i=$(($(( (($(($r-1)) ))*3)) + $(($c-1)) ))
	val[$i]="x"
	
	ShowTheBoard
	CheckWinOrLose
	CheckDrawMatch
	PlayCPU
}

PlayCPU(){
	echo "CPU Move..."
	sleep 1
	CPUCheckForCornersAndCentre
	CPUCheckForEdges
	ShowTheBoard
	PlayUser
}

#USER PLAYING AT FIRST TOSS
if [ "$toss_result" == "T" ]
then
	echo "You won the Toss. Start playing."
	PlayUser
fi

#COMPUTER PLAYING AT FIRST TOSS
if [ "$toss_result" == "H" ]
then
	echo "CPU won the toss."
	echo "Computer's turn"
	PlayCPU
fi
