import matplotlib.pyplot as plt
import numpy as np
plt.style.use('seaborn-dark-palette')
x = np.arange(0.0, 1.0, 0.01)
y = np.sin(x)
plt.plot(x, y)

plt.xlabel('x')
plt.ylabel('y')
plt.title('Plot of function sin')
plt.grid(False)

plt.xlim( x.min() - 0.01, x.max() + 0.01 )
plt.ylim( y.min() - 0.01, y.max() + 0.01 )

plt.show()
