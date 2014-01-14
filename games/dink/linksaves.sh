#!/bin/bash

if [[ $1 == "unlink" ]]; then
	echo "Game saves unlinked..."
elif [[ $1 == "link" ]]; then
	echo "Game saves linked to $2..."
fi
