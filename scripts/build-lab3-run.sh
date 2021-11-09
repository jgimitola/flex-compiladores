#!/bin/bash

COMP_PATH="./Lab3"

yacc -d ${COMP_PATH}/LAB02_Camacho_Imitola_Reyes.y -o ${COMP_PATH}/dist/y.tab.c
lex -o ${COMP_PATH}/dist/lex.yy.c ${COMP_PATH}/LAB02_Camacho_Imitola_Reyes.l 
cc ${COMP_PATH}/dist/y.tab.c ${COMP_PATH}/dist/lex.yy.c -o ${COMP_PATH}/dist/a.out