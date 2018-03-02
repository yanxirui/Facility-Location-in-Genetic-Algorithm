%打印算法迭代过程
%generation_size: 迭代次数

function plotGA(generation_size)
global best_fitness_store;
x = 1:1:generation_size;
y = best_fitness_store;
plot(x,y)
