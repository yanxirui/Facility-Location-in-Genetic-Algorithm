% 对个体按适应度大小进行排序，并且保存最佳个体
% population_size: 种群大小
% chromosome_size: 染色体长度

function rank(population_size, chromosome_size)
global fitness_value;   % 种群适应度
global fitness_sum;     % 种群累计适应度
global best_fitness_store;
global fitness_average;
global best_fitness;
global best_individual;
global best_generation;
global population;
global G;

for i=1:population_size    
    fitness_sum(i) = 0.;
end

min_index = 1;
temp = 1;
temp_chromosome(chromosome_size)=0;

% 遍历种群 
% 冒泡排序
% 最后population(i)的适应度随i递增而递增，population(1)最小，population(population_size)最大
for i=1:population_size
    min_index = i;
    for j = i+1:population_size
        if fitness_value(j) < fitness_value(min_index);
            min_index = j;
        end
    end
    
    if min_index ~= i
        % 交换 fitness_value(i) 和 fitness_value(min_index) 的值
        temp = fitness_value(i);
        fitness_value(i) = fitness_value(min_index);
        fitness_value(min_index) = temp;
        % 此时 fitness_value(i) 的适应度在[i,population_size]上最小
        
        % 交换 population(i) 和 population(min_index) 的染色体串
        for k = 1:chromosome_size
            temp_chromosome(k) = population(i,k);
            population(i,k) = population(min_index,k);
            population(min_index,k) = temp_chromosome(k);
        end
    end
end

% fitness_sum(i) = 前i个个体的适应度之和
for i=1:population_size
    if i==1
        fitness_sum(i) = fitness_sum(i) + fitness_value(i);    
    else
        fitness_sum(i) = fitness_sum(i-1) + fitness_value(i);
    end
end

% fitness_average(G) = 第G次迭代 个体的平均适应度
fitness_average(G) = fitness_sum(population_size)/population_size;

% 更新最大适应度和对应的迭代次数，保存最佳个体(最佳个体的适应度最大)
if fitness_value(population_size) > best_fitness
    best_fitness = fitness_value(population_size);
    best_generation = G;
    
    for j=1:chromosome_size
        best_individual(j) = population(population_size,j);
    end
end
best_fitness_store(G) =best_fitness ;

clear i;
clear j;
clear k;
clear min_index;
clear temp;
clear temp1;
end