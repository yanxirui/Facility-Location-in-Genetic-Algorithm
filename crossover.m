% 交叉操作
% population_size: 种群大小
% chromosome_size: 染色体长度
% cross_rate: 交叉概率



function crossover(population_size, chromosome_size, cross_rate)
global population;
global Distance;

% 步长为2 遍历种群
for i=1:2:population_size
    % rand<交叉概率，对两个个体的染色体串进行交叉操作
    if(rand < cross_rate)
        c = population(i,1);
        flag = 1;
        flag1 = 1;
        for k = 2:chromosome_size
            if(population(i,k) ~= c) 
                flag=0;
            end
        end
        c = population(i+1,1);
        for k = 2:chromosome_size
            if(population(i+1,k) ~= c) 
                flag1=0;
            end
        end
        if(flag == 1 || flag1 == 1) 
            continue; %flag=1说明只有一个枢纽点，不交叉
        else%交叉
            %找出第一个的枢纽点
            num1 = 0; hub1 = zeros(1,1);  
            for k = 1:chromosome_size
                if (population(i,k)==k) %找出是枢纽的点 
                    num1 = num1 + 1;
                    hub1(num1) = k;
                end
            end
            %找出第二个的枢纽点
            num2 = 0; hub2 = zeros(1,1);  
            for k = 1:chromosome_size
                if (population(i+1,k)==k) %找出是枢纽的点 
                    num2 = num2 + 1;
                    hub2(num2) = k;
                end
            end
            %随机选择进行交叉
            %选择交叉点数
            a = rand();
            if(num1>num2)
                num = a*(num2-1) +1;
            else 
                num = a*(num1-1) + 1;
            end
           num = floor(num);
           cross1 = zeros(1,num); %1中被交换的枢纽
           cross2 = zeros(1,num); %2中被交换的枢纽
           for n = 1:num
               a = rand();
               cross1(n) = hub1(floor(a*num1+1));
           end
           for n = 1:num
               a = rand();
               cross2(n) = hub2(floor(a*num2+1));       
           end

          
           for m = 1:num
               %找出被交换枢纽的所有节点
               nodeNum1 = 0 ; nodeNum2 = 0;
               nodes1 = zeros(1,2);
               nodes2 = zeros(1,2);
               for n = 1:chromosome_size
                   if (population(i,n) == cross1(m))
                       population(i,n) = 0;
                       if n ~= cross1(m)
                           nodeNum1 = nodeNum1 + 1;
                           nodes1(nodeNum1) = n;
                       end
                   end
               end
               for n = 1:chromosome_size
                   if (population(i+1,n) == cross2(m))
                       population(i+1,n) = 0;
                       if n ~= cross2(m)
                           nodeNum2 = nodeNum2+ 1;
                           nodes2(nodeNum2) = n;
                       end
                   end
               end

               %将cross2插入1
               %枢纽点改变
               population(i,cross2(m)) = cross2(m);
               %将hub中调换过来
               for n = 1:num1
                   if(hub1(n)==cross1(m)) 
                       hub1(n) = cross2(m);   
                   end
               end
               %对cross2所接的节点插入1
               for n = 1:nodeNum2
                   if (population(i,nodes2(n)) == 0) %如果该节点在1中没有连枢纽，则将该节点连在cross2后
                       population(i,nodes2(n)) = cross2(m);
                   else
                       %如果该节点连了枢纽，则将该节点连接所有枢纽里最近的枢纽
                       f = Distance(hub1(1),nodes2(n));
                       g = hub1(1);
                       for e = 2:num1
                           if Distance(hub1(e),nodes2(n)) < f
                               f = Distance(hub1(e),nodes2(n));
                               g = hub1(e);
                           end
                       end
                       population(i,nodes2(n)) = g;
                   end
               end
               
               %将cross1插入2 
               population(i+1,cross1(m)) = cross1(m);
               %枢纽点改变
               for n = 1:num2
                   if(hub2(n)==cross2(m)) 
                       hub2(n) = cross1(m);
                   end
               end
               for n = 1:nodeNum1
                   if (population(i+1,nodes1(n)) == 0) %如果该节点没有连枢纽，则将该节点连在cross1后
                       population(i+1,nodes1(n)) = cross1(m);
                   else
                       %如果该节点连了枢纽，则将该节点连接所有枢纽里最近的枢纽
                       f = Distance(hub2(1),nodes1(n));
                       g = hub2(1);
                       for e = 2:num2
                           if Distance(hub2(e),nodes1(n)) < f
                               f = Distance(hub2(e),nodes1(n));
                               g = hub2(e);
                           end
                       end
                       population(i+1,nodes1(n)) = g;
                   end
               end
           end
           %对于还没连接的节点，找距离最近的连接
           for m = 1:chromosome_size
               %第一个
               if population(i,m) == 0
                    f = Distance(m,hub1(1));
                    g = hub1(1);
                    for e = 2:num1
                        if Distance(hub1(e),m) < f
                            g = hub1(e);
                            f = Distance(hub1(e),m);
                        end
                    end
                    population(i,m) = g;
               end
               %第二个
                if population(i+1,m) == 0
                    f = Distance(m,hub2(1));
                    g = hub2(1);
                       for e = 2:num2
                           if Distance(hub2(e),m) < f
                               f = Distance(hub2(e),m);
                               g = hub2(e);
                           end
                       end
                       population(i+1,m) = g;
               end
           end
        end
    end
end   
    
%clear i;
%clear j;
%clear k;
%clear m;



end




