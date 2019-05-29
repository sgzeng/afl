#!/bin/bash

set -e
set -x

OPTION=$1
AFL_PATH=$(pwd)

cd $AFL_PATH
rm -rf ./afl_out/*
####################################################################################
###########################/ The general cases /####################################
####################################################################################
# The root directory of AFL:
export AFL_ROOT=/home/haochen/work/reinforcement_learning/afl
# The output directory of AFL:
export OUTPUT=/home/haochen/work/reinforcement_learning/afl/afl_out
####################################################################################
############################/ Target program: The_Longest_Road /####################
####################################################################################
# The input directory of AFL
export INPUT=/home/haochen/work/reinforcement_learning/target/afl_in_The_Longest_Road
# The target program of afl instrumented version:
export AFL_CMDLINE=/home/haochen/work/reinforcement_learning/target/afl_instrumented/The_Longest_Road_afl
# The target program of Non-instrumented version:
export QSYM_CMDLINE=/home/haochen/work/reinforcement_learning/target/original_bins/CROMU_00030.elf
####################################################################################
if [ "$OPTION" == "master" ] || [ "$OPTION" == "m" ] ; then
    # run AFL master
    $AFL_ROOT/afl-fuzz -M afl-master -m none -i $INPUT -o $OUTPUT -- $AFL_CMDLINE
fi
if [ "$OPTION" == "slave" ] || [ "$OPTION" == "s" ] ; then
    # run AFL slave
    $AFL_ROOT/afl-fuzz -S afl-slave -m none -i $INPUT -o $OUTPUT -- $AFL_CMDLINE
fi
