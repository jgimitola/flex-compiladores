#!/bin/bash

COMP_PATH="./Lab3"

yacc -d -v ${COMP_PATH}/lab3.y -o ${COMP_PATH}/dist/y.tab.c
lex -o ${COMP_PATH}/dist/lex.yy.c ${COMP_PATH}/lab3.l 
cc ${COMP_PATH}/dist/y.tab.c ${COMP_PATH}/dist/lex.yy.c -o ${COMP_PATH}/dist/a.out