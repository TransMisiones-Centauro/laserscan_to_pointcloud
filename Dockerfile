FROM osrf/ros:noetic-desktop-full

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y git \
 && rm -rf /var/lib/apt/lists/*

# Clone ROS package
RUN  mkdir -p /catkin_ws/src
RUN git clone --recurse-submodules \
      https://github.com/TransMisiones-Centauro/laserscan_to_pointcloud.git\
      /catkin_ws/src/laserscan_to_pointcloud

# Install dependencies
RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && apt-get update \
 && rosdep install -r -y \
     --from-paths /catkin_ws/src \
     --ignore-src \
 && rm -rf /var/lib/apt/lists/*

# Build package
RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && cd /catkin_ws \
 && catkin_make -j1

# Source workspace
RUN sed --in-place --expression \
      '$isource "/catkin_ws/devel/setup.bash"' \
      /ros_entrypoint.sh

