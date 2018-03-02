% 计算种群个体适应度，对不同的优化目标，修改下面的函数
% population_size: 种群大小
% chromosome_size: 染色体长度

function fitness(population_size, chromosome_size)
global fitness_value;
global population;
global Distance;
global TravelTime;
global Flow;
global FixedHubCost;

distance_con = 0.5;%与距离的比例系数
HubToHub_con = 0.5;%枢纽到枢纽的衰减系数α
Time_con = 1;

% 所有种群个体适应度初始化为0
for i=1:population_size
    fitness_value(i) = 0.;    
end

for m=1:population_size
    NodeToHub = 0; %从节点到枢纽点的成本
    HubToHub = 0; %从枢纽到枢纽的成本
    HubToNode = 0; %从枢纽到节点的成本
    FixedCost  = 0; %固定成本
    TimeQ = 0;%服务质量

    Oi = 0; %从i点发出的所有（一竖排）
    Di = 0; %从i点接收到的所有（横排）
    
    %计算所有节点到枢纽的成本
    for i = 1:chromosome_size %i代表节点
        Oi = 0;
        if (population(m,i)~=i)  %找出是节点的点
            for j= 1:chromosome_size
                Oi  =  Oi + Flow(i,j);
            end
            %k代表枢纽点
            for k = 1:chromosome_size
                if (population(m,k)==k) %找出是枢纽的点 
                    if(population(m,i )== k) %如果节点i到枢纽k有连接
                        NodeToHub = NodeToHub + distance_con*Distance(i,k)*Oi;
                    end
                end
            end
        end
    end
    
    %计算枢纽到节点的所有成本
    for i = 1:chromosome_size %i代表节点
        Di = 0;
        if (population(m,i)~=i)  %找出是节点的点
            for j= 1:chromosome_size
                Di  =  Di + Flow(j,i);
            end
            %k代表枢纽点
            for k = 1:chromosome_size
                if (population(m,k)==k) %找出是枢纽的点 
                    if(population(m,i)== k) %如果节点i到枢纽k有连接
                        HubToNode = HubToNode + distance_con*Distance(i,k)*Di;
                    end
                end
            end
        end
    end
          
    %计算枢纽到枢纽之间的所有成本 全连接
    %找出所有枢纽点
    num = 0;
     for k = 1:chromosome_size
         if (population(m,k)==k) %找出是枢纽的点 
             num = num + 1;
             hub(num) = k;
         end
     end
     for i = 1:num
         for j = 1:num
             for k = 1:chromosome_size
                 HubToHub = HubToHub + HubToHub_con*distance_con*Distance(hub(i),hub(j))*Fijk(m, hub(i),hub(j),k,chromosome_size);
             end
         end
     end

    
    %计算固定成本
    for k = 1:chromosome_size 
        if (population(m,k)==k)  %找出枢纽点
            FixedCost = FixedCost + FixedHubCost(k);
        end
    end
    
    %计算时间评估成本
     TimeQ = maxTravalTime(m,chromosome_size);
    
    %计算总的适应度
    fitness_value(m) = -(NodeToHub + HubToHub + HubToNode + FixedCost + Time_con*TimeQ) ;
 %   HubToHub
end

clear i;
clear j;
clear k;
clear m;
clear Oi;
clear Di;
