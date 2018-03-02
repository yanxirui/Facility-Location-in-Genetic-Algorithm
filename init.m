% 初始化种群
% population_size: 种群大小
% chromosome_size: 染色体长度

function init(population_size, chromosome_size,least,most)
global population;
population = zeros(population_size, chromosome_size);
num_hub = 0;
for m=1:population_size
    %产生随机枢纽数num_hub
    a = rand();
    num_hub = a*(most-least+1) + least;
    num_hub= floor(num_hub);
    %随机对节点指定为枢纽点，即生成num_hub个范围为1-总节点数的随机整数
    hub = zeros(1,num_hub);
    for i = 1:num_hub
        f=1;
       while(f==1)
            a = rand();
            j = a*chromosome_size +1;
            j = floor(j);
            f = 0;
            for k=1:i-1
                if(hub(k) == j) f = 1;
                end
            end
        end
   
        hub(i) = j;
        population(m,j) = j;
    end
    %对剩下的节点随机选择一个枢纽点进行相连
    for i=1:chromosome_size
        if(population(m,i) == 0)  %找出节点
            a = rand();
            j = a*sqrt(num_hub) +1;
            j = floor(j);
            population(m,i) = hub(j);
        end
    end
    num_hub  = 0;
end

for m = 1:population_size
    %找出所有枢纽
    num = 0; hub = zeros(1,1);  
    for k = 1:chromosome_size
        if (population(m,k)==k) %找出是枢纽的点 
            num = num + 1;
            hub(num) = k;
        end
    end
    %如果有枢纽没有连点，随机把该枢纽变成其他枢纽的节点
    for k = 1:num
        number = 0;
        for n = 1:chromosome_size
            if(population(m,n)==hub(k))
                number = number + 1;
            end
        end
        if(number == 1)
            b=k;
            while(b == k || hub(b)==0)
                a = rand();
                b = a*num + 1;
                b = floor(b);
            end
            %hub(k)
            %hub(b)
            population(m,hub(k)) = hub(b);
            hub(k) = 0;
        end
    end
end

clear i;
clear j;

end

