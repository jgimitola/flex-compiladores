#!/bin/bash

PROJECT=$1
COMP_PATH="./Lab$1"

lex -o ${COMP_PATH}/dist/LAB01_Camacho_Imitola_Reyes.yy.c ${COMP_PATH}/LAB01_Camacho_Imitola_Reyes.l
gcc ${COMP_PATH}/dist/LAB01_Camacho_Imitola_Reyes.yy.c -o ${COMP_PATH}/dist/LAB01_Camacho_Imitola_Reyes.out