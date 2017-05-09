
#To compile GLFW for X11, you need to have the X11 and OpenGL header packages installed, as well as the basic development tools like GCC and make. For example, on Ubuntu and other distributions based on Debian GNU/Linux, you need to install the xorg-dev and libgl1-mesa-dev packages. The former pulls in all X.org header packages and the latter pulls in the Mesa OpenGL development packages. Note that using header files and libraries from Mesa during compilation will not tie your binaries to the Mesa implementation of OpenGL.
git clone https://github.com/glfw/glfw.git
sudo apt install xorg-dev
sudo apt install libgl1-mesa-dev

cd glfw
cmake .
mkdir glfw-build
cd glfw-build
cmake ..
cd ..
make
sudo make install
