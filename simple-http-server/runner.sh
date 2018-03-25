#!/usr/bin/env bash

CLASSPATH=$(echo lib/*.jar | tr ' ' ':')

/opt/jdk/bin/java -cp $CLASSPATH:. HttpServerLauncher