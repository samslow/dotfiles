#!/usr/bin/env zsh

function gos(){
	git fetch;
	gswc dev/OS-$1 origin/develop;
	gpsup;
}

function gts(){
	git fetch;
	gswc dev/TS-$1 origin/develop;
	gpsup;
}

function gqa(){
	git fetch;
	gswc dev/QAS-$1 origin/develop;
	gpsup;
}

function gif(){
	git fetch;
	gswc epic/INFO-$1 origin/develop;
	gpsup;
}
function gopt(){
	git fetch;
	gswc epic/OPTN-$1 origin/develop;
	gpsup;
}

