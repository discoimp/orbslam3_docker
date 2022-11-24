# ORB_SLAM3 docker

This docker is based on ROS noetic on ubuntu 20.04.

This page only runs the CPU version of the original (https://github.com/jahaniam/orbslam3_docker.git) github.

To check if you are running the nvidia driver, simply run `nvidia-smi` and see if get anything.

Based on which graphic driver you are running, you should choose the proper docker. 

---

## Compilation and Running

Steps to compile the Orbslam3 on the sample dataset:

- `./download_dataset_sample.sh`
- `build_container_cpu.sh`

Now you should see ORB_SLAM3 is compiling. 
To run a test example:
- `docker exec -it orbslam3 bash`
- `cd /ORB_SLAM3/Examples&&./euroc_examples.sh`

---

You can use vscode remote development.
- `docker exec -it orbslam3 bash`
- `subl /ORB_SLAM3`
