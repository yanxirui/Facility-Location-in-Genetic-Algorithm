% population_size: 种群大小
% chromosome_size: 染色体长度
% mutate_rate: 变异概率

function mutation(population_size, chromosome_size, mutate_rate)
global population;

for i=1:population_size
    if rand < mutate_rate
        %找出枢纽点
        num = 0; hub = zeros(1,1);  
            for k = 1:chromosome_size
                if (population(i,k)==k) %找出是枢纽的点 
                    num = num + 1;
                    hub(num) = k;
                end
            end
        %随机选择变异种类
        a = rand();
        b = a*3 + 1;
        b = floor(b);
        if(num == 1) 
            b = 3;
        end

        switch b
            case 1 %单个节点移动
                %找出一个节点
                while(true)
                    a = rand();
                    c = a*chromosome_size + 1;
                    c = floor(c);
                    if(population(i,c) ~= c) 
                        break;
                    end
                end
                d = 0;
                a  = rand();
                d = a*num + 1;
                d = floor(d);
                d = hub(d);
                population(i,c) = d;
            %两个节点交换
            case 2
                %找出两个连接不同枢纽的节点交换
                while(true)
                    a = rand();
                    c = a*chromosome_size + 1;
                    c = floor(c);
                    if(population(i,c) ~= c) 
                        break;
                    end
                end
                while(true)
                    a = rand();
                    c2 = a*chromosome_size + 1;
                    c2 = floor(c2);
                    if(population(i,c2) ~= c2 ) 
                        break;
                    end
                end
                temp = population(i,c2);
                population(i,c2) = population(i,c);
                population(i,c) = temp;
            case 3
               %一个节点和一个枢纽交换
               a = rand();
               c = a*num + 1;
               c = floor(c);%找出枢纽
               c = hub(c);
               %找出该枢纽的所有节点
               node = zeros(1,1);nodeNum = 0;
               for k = 1:chromosome_size
                   if(population(i,k)==c && k~=c)
                       nodeNum = nodeNum + 1;
                       node(nodeNum) = k;
                   end
               end
               %随机选取一个节点
               a = rand();
               d = a*nodeNum + 1;
               d = floor(d);
               d = node(d);
               for k = 1:chromosome_size
                   if(population(i,k)==c)
                       population(i,k)=d;
                   end
               end
        end

    end
end

clear i;
clear mutate_position;

