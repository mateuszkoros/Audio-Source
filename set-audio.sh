#!/bin/bash

output_source=''
input_source=''

case "$1" in
	"sharkoon")
		output_source='output.*Sharkoon_Gaming_DAC'
		input_source='input.*Sharkoon_Gaming_DAC'
		;;
	"bluetooth")
		output_source='bluez_output'
		input_source='bluez_input'
		;;
esac

if [ -z "$output_source" ] || [ -z "$input_source" ]
then
	echo Failed to find audio sources
	exit 1
fi

output=`pactl list short sinks | grep $output_source`
input=`pactl list short sources | grep $input_source`

output_id=`echo $output | awk '{ print $1 }'`
input_id=`echo $input | awk '{ print $1 }'`

output_name=`echo $output | awk '{ print $2 }'`
input_name=`echo $input | awk '{ print $2 }'`

echo Setting default sink to $output_name
echo Setting default source to $input_name

pactl set-default-sink $output_id
pactl set-default-source $input_id
