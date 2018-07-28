#!/bin/sh

setEnvVariables() 
{
	echo "Postgres user: "
	read user
	while [ -z $user ]; do
	      echo "Invalid user. please enter again: "
	       read user
        done	       
	echo "Postgres password: "
	read password
	while [ -z $password ]; do
		echo "Invalid password. plase enter again: "
		read password
	done
}

writeEnvFile() 
{
	echo "POSTGRES_USER=$user" > .env
	echo "POSTGRES_PASSWORD=$password" >> .env 
}

if [ ! -e .env ]; then
	echo "env file does not exist..."
	echo "creating a .env file..."
	touch .env
	setEnvVariables
	writeEnvFile
else 
	source .env
	if [ -z "$POSTGRES_USER" -o -z "$POSTGRES_PASSWORD" ]; then
		echo "variables of env file are empty..."
		setEnvVariables
		writeEnvFile
	else 
		echo "env variables are set. Do you want to change them?"
		read answer
		case $answer in 
			[yY] | [yY][Ee][Ss])      
				setEnvVariables
				writeEnvFile
				source .env
				;;
		esac
	fi
fi
# Iniciar docker-compose
echo "Building containers..."
docker-compose build
echo "Starting the containers..."
docker-compose up -d
