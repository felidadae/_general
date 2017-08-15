# https://medium.com/@at15/install-nvidia-cuda-on-ubuntu-17-04-823300ab7bcc
sudo apt-get install -y nvidia-cuda-dev nvidia-cuda-toolkit

#check if works
cd resources
nvcc -ccbin clang-3.8 *.cu
./a.out
