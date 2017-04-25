#!/bin/bash 
# author: Michael Grupp


if [[ $* == *--help* ]] || [[ $* == *-h* ]]; then
    echo "creates catkin_ws inside this repository using a symlink to sptam"
    echo "(pass --build to directly call catkin_make, --reset to remove and reset an existing catkin_ws)"
    echo -e "\nusage: $0 [--build] [--reset]"
    exit 0
fi

if [[ $* == *--reset* ]]; then
    echo -e "\n[$0] reset will overwrite current catkin_ws/"
    echo "enter 'y' to go on, any other key to exit"
    read input
    if [[ $input != y ]]; then
        exit 0
    fi
    rm -r -v catkin_ws
fi

if [ -d "catkin_ws" ]; then
    echo -e "[$0] catkin_ws/ already exists - call with '--reset' to reset existing folder"
    exit 1
fi

echo -e "\n[$0] creating catkin_ws/"
mkdir catkin_ws
cd catkin_ws/
mkdir src
cd src/
pwd
ln -s -v ../../../sptam/ sptam

if [[ $* == *--build* ]]; then
    echo -e "\n[$0] calling catkin_make in catkin_ws/"
    cd ..
    catkin_make
    echo -e "\n[$0] sourcing devel/setup.bash"
    source devel/setup.bash
    cd ..
    echo -e "...if script was not run in current shell, source manually:\nsource catkin_ws/devel/setup.bash"
fi
