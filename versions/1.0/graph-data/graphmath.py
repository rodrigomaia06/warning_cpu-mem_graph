import matplotlib.pyplot as plt
import numpy as np
import math

x = []
y = []
z = []
for line in open('graphdata.txt', 'r'):
    lines = [i for i in line.split()]
    x.append(lines[0])
    y.append(int(lines[1]))
    z.append(int(lines[2]))

plt.axhline(y=###cpu_percentage_warning###, color='g', linestyle='dashed')
plt.plot(x, y, 'g', label='CPU Usage')
plt.axhline(y=###ram_percentage_warning###, color='r', linestyle='dashed')
plt.plot(x, z, 'r', label='MEM Usage')
plt.xticks(np.arange(0, len(x), step=math.floor(len(x)/8)))
plt.legend()
plt.savefig('plot.png', dpi=300, bbox_inches='tight')
plt.show()
