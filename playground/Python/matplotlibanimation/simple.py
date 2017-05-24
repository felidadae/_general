import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
plt.style.use('ggplot')

def update_line(num, data, line):
	V = 100.0*(0.1*num+1.0)/100.0 
	x = np.arange(0.0, 1.0, 0.0001)
	y = np.sin( V * np.pi * x)
	line.set_data(x, y)
	return line,

fig1 = plt.figure()
data = np.random.rand(2, 25)
l, = plt.plot([], [], 'b-')
plt.xlim(0, 1)
plt.ylim(-1.1, 1.1)
# plt.xlabel('x')
# plt.title('test')
import ipdb; ipdb.set_trace()

line_ani = animation.FuncAnimation(
	fig1, 
	update_line, 
	50, 
	fargs=(data, l),
	blit=True)

myWriter = animation.FFMpegWriter(
	fps = 30, 
	extra_args=['-vcodec', 'libx264'])

line_ani.save('lines.mp4', 
	writer=myWriter, 
	dpi=330)







