#!/usr/bin/env bash

docker run --rm -it --network host laserscan_to_pointcloud:noetic \
  roslaunch laserscan_to_pointcloud \
    laserscan_to_pointcloud_assembler.launch \
    laser_scan_topics:=scan

