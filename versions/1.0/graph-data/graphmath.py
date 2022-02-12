import matplotlib.pyplot as plt
  
x = []
y = []
z = []
for line in open('graphdata.txt', 'r'):
    lines = [i for i in line.split()]
    x.append(lines[0])
    y.append(int(lines[1]))
    z.append(int(lines[2]))
      
plt.plot(x, y, 'g', label='CPU Usage')
plt.plot(x, z, 'r', label='MEM Usage')
plt.legend()
plt.savefig('plot.png', dpi=300, bbox_inches='tight')
  
plt.show()
