%锦标赛选择法
% population_size: 种群大小
% chromosome_size: 染色体长度
% elitism: 是否精英选择

function selection(population_size, chromosome_size, elitism)
global population;      % 前代种群
global population_new;  % 新一代种群
global fitness_value;

%每一次取出来的数量
Tournum = 4;
TakeOut = zeros(1,Tournum);
num = 0;%目前产生的新一代种群数量

%每次取TourNum个出来 保存最优的个体，知道种群数量一致
while(num ~= population_size)
    for i = 1:Tournum
        a = rand();
        b = a*population_size + 1;
        b= floor(b);
        TakeOut(i) = b;
    end
    take =-10000000000; 
    for i = 1:Tournum
        if(fitness_value(TakeOut(i))>take)
            c = TakeOut(i);
            take = fitness_value(TakeOut(i));
        end
    end
    num = num + 1;
    for i = 1:chromosome_size
        population_new(num,i) = population(c,i);
    end
end

% 是否精英选择
if elitism
    p = population_size-1;
else
    p = population_size;
end

for i=1:p
   for j=1:chromosome_size
       % 如果精英选择，将population中前population_size-1个个体更新，最后一个最优个体保留
       population(i,j) = population_new(i,j);
   end
end

clear i;
clear j;
clear population_new;
clear first;
clear last;
clear idx;
clear mid;
 

