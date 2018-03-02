function [f] = Fijk(m, i,j,k,chromosome_size )
%计算第m个个体节点K在枢纽i到j之间的流量
global population;
global Flow;
f = 0;
if (population(m,k) ~= i) 
    f = 0;
else
    %找出枢纽j连得节点
    num = 0;
     for a = 1:chromosome_size
         if (population(m,a) == j && a~=j)
             num = num +1;
             hub(num) = a;
         end
     end

     %将节点k到j所接的所有节点得了流量相加；
     for a = 1:num
         f = f + Flow(k,hub(a));
     end
     f  = f + Flow(k,j);
end

end

