@echo off
REM ****************************************************************************
REM Vivado (TM) v2019.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Sat Apr 25 15:25:31 +0200 2020
REM SW Build 2552052 on Fri May 24 14:49:42 MDT 2019
REM
REM Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
echo "xsim testPushbuttonLED_tb_behav -key {Behavioral:sim_2:Functional:testPushbuttonLED_tb} -tclbatch testPushbuttonLED_tb.tcl -log simulate.log"
call xsim  testPushbuttonLED_tb_behav -key {Behavioral:sim_2:Functional:testPushbuttonLED_tb} -tclbatch testPushbuttonLED_tb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
