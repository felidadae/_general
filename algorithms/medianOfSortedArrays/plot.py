import math
K=100
def f(n):
    result=0.0 
    for i in range(0,K):
        divider = (math.pow(2, i))
        if n/divider < 1: 
            break
        result += math.log(n/divider)
    return result



import matplotlib.pyplot as plt
import numpy as np

x = np.arange(1, 100)
y = np.array([f(x_) for x_ in x ])
plt.plot(x, y)

plt.xlabel('x')
plt.ylabel('y')
plt.title('Plot of function ')
plt.grid(True)

plt.xlim( x.min() - 0.01, x.max() + 0.01 )
plt.ylim( y.min() - 0.01, y.max() + 0.01 )

plt.show()
