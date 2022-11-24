# Image taken from https://github.com/turlucode/ros-docker-gui
FROM edcela/ros-noetic:latest

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list'

RUN sh -c 'echo "deb http://archive.ubuntu.com/ubuntu focal main multiverse restricted universe" > /etc/apt/sources.list'
RUN sh -c 'echo "deb http://archive.ubuntu.com/ubuntu focal-updates main multiverse restricted universe" > /etc/apt/sources.list'
RUN sh -c 'echo "deb http://archive.ubuntu.com/ubuntu focal-backports main multiverse restricted universe" > /etc/apt/sources.list'
RUN sh -c 'echo "deb http://archive.canonical.com/ubuntu/ focal partner" > /etc/apt/sources.list'
RUN sh -c 'echo "deb http://security.ubuntu.com/ubuntu/ focal-security main multiverse restricted universe" > /etc/apt/sources.list'


RUN apt-get update --fix-missing
RUN apt-get clean 
RUN apt-get update 
RUN apt-get check 
RUN apt-get purge ffmpeg* -y 
RUN apt-get -f satisfy ffmpeg -y


ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y gnupg


RUN wget http://packages.ros.org/ros.key -O - | sudo apt-key add -



# # Build Pangolin
RUN apt-get update
RUN apt install -y libtiff5-dev 
RUN cd /tmp && git clone https://github.com/stevenlovegrove/Pangolin && \
    cd Pangolin && git checkout v0.6 && mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=-std=c++11 .. && \
    make -j$nproc && make install && \
    cd / && rm -rf /tmp/Pangolin
    


COPY ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x  /ros_entrypoint.sh
ENV ROS_DISTRO noetic
ENV LANG en_US.UTF-8

ENTRYPOINT ["/ros_entrypoint.sh"]

USER $USERNAME
# terminal colors with xterm
ENV TERM xterm
RUN mkdir /ORB_SLAM3
WORKDIR /ORB_SLAM3
CMD ["bash"]
