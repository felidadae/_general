echo "Follow manual: https://developer.nvidia.com/cuda-downloads"
read ""

#check if works
cd resources
nvcc -ccbin clang-3.8 *.cu
./a.out
