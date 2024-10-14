#!/bin/bash

level=0
attempts=0
option=-1
get_number=-1
declare -a difficulty_type=("\e[32mEasy\e[0m " "\e[33mMedium\e[0m" "\e[31mHard\e[0m")

welcome_message(){
	clear
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	printf "@           \e[33mWelcome to the Number Guessing Game!\e[0m               @
@       I'm thinking of a number between 1 and 100.            @
@     You have until 10 chances to guess the correct number.   @\n"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
}

ask_level(){
	printf "Please select the difficulty level:
		1. \e[32mEasy\e[0m (10 chances)
		2. \e[33mMedium\e[0m (5 chances)
		3. \e[31mHard\e[0m (3 chances)\n"

	while true
	do
		read -r -p "Enter your choice: " level

		if [ "$level" -lt 1 ] || [ "$level" -gt 3 ]; then
			echo -e "\e[31mWrong Option\e[0m"
		else
			break
		fi
	done
	echo -e "Great! You have selected the ${difficulty_type[$level-1]} difficulty level."
	echo "Let's start the game!"
	if [ "$level" -eq 1 ]; then
		attempts=10
	elif [ "$level" -eq 2 ]; then
		attempts=5
	else
		attempts=3
	fi
	get_number=$((RANDOM % 100))
	sleep 3
	clear
	run_game
}

run_game(){
	time_jogo=$(date +%s)
	while true
	do
		number_is="greater"
		echo -e "Level: ${difficulty_type[$level-1]} - Attempts: $attempts"
		read -r -p "Enter your choice: " option

		if [ ! "$option" -eq "$get_number" ]; then
			if [ "$get_number" -lt "$option" ]; then
				number_is="less"
			fi
			clear
			echo "Incorrect! The number is ${number_is} than ${option}."
			((attempts--))
			if [ $attempts -eq 0 ]; then
				clear
				echo -e "\e[31mYou Loose\e[0m"
				break
			fi 
		else
			echo -e "\e[32mCongratulations!\e[0m You guessed the correct number in ${attempts} attempts."
			break
		fi
	done

	time_jogo=$(($(date +%s) - (time_jogo)))

	time_jogo=$(((10800) + (time_jogo)))
	time_jogo=$(date -d @$time_jogo '+%H:%M:%S')

	echo "Time: " "$time_jogo"
	

	read -r -p "Do you want replay?(Y/n): " ask_opt
	ask_opt=$(echo "$ask_opt" | tr "[:lower:]" "[:upper:]")

	if [ "$ask_opt" == "Y" ]; then
		sleep 0.5
		clear
		ask_level
	else
		echo "Ok exiting..."
		exit
	fi
}


welcome_message
sleep 2
ask_level

