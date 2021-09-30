#!/bin/bash

PROJECT=$1
COMP_PATH="./Lab$1"

lex -o ${COMP_PATH}/dist/lex.yy.c ${COMP_PATH}/lab$1.l
gcc ${COMP_PATH}/dist/lex.yy.c -o ${COMP_PATH}/dist/a.out