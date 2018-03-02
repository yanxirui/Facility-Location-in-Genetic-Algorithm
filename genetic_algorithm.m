% Genetic Algorithm for Functional Maximum Problem
% f(x) = x+10*sin(5*x)+7*cos(4*x), x∈[0,9]
% Created by Shengjia Yan @2016/4/26

% population_size: 输入种群大小
% chromosome_size: 输入染色体长度
% generation_size: 输入迭代次数
% cross_rate: 输入交叉概率
% mutate_rate: 输入变异概率
% elitism: 输入是否精英选择
% m: 输出最佳个体
% n: 输出最佳适应度
% p: 输出最佳个体出现迭代次数
% q: 输出最佳个体自变量值
function [m,n,p,q] = genetic_algorithm(population_size, chromosome_size, generation_size, cross_rate, mutate_rate, elitism,least,most)

global G ;              % 当前迭代次数
global fitness_value;   % 当前代适应度矩阵
global best_fitness;    % 历代最佳适应值
global fitness_average; % 历代平均适应值矩阵
global best_individual; % 历代最佳个体
global best_generation; % 最佳个体出现代
global best_fitness_store;
global Distance;

global Flow;
global FixedHubCost;

fitness_average = zeros(generation_size, 1); % 将 generation_size*1 的零矩阵赋给 fitness_average
best_fitness_store = zeros(1,generation_size);
disp [ysj genetic algorithm]

fitness_value(population_size) = 0.;
best_fitness = -10e10;
best_generation = 0;

init(population_size, chromosome_size,least,most); % 初始化

for G=1:generation_size   
    fitness(population_size, chromosome_size);                % 计算适应度 
    rank(population_size, chromosome_size);                   % 对个体按适应度大小进行排序
    selection(population_size, chromosome_size, elitism);     % 选择操作
    crossover(population_size, chromosome_size, cross_rate);  % 交叉操作
    mutation(population_size, chromosome_size, mutate_rate);  % 变异操作
end

plotGA(generation_size);% 打印算法迭代过程

best_individual   % 获得最佳个体
best_fitness       % 获得最佳适应度
p = best_generation;    % 获得最佳个体出现时的迭代次数


clear i;
clear j;

