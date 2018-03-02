function [ TimeQ] =maxTravalTime(m,chromosome_size)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
time = zeros(chromosome_size,chromosome_size);

global population;
global TravelTime;

TimeQ = 0;

for i=1:chromosome_size
    for j = 1:chromosome_size
         first = 0; second = 0; third = 0;
        %计算第一项 节点到枢纽的时间
        for k = 1:chromosome_size
            if population(m,k) ~= k %如果是节点就跳过
                continue
            else
                if (population(m,i) == k)
                    first = first + TravelTime(i,k);
                end
            end
        end
        %计算第三项 枢纽到节点的时间 
         for k = 1:chromosome_size
            if population(m,k) ~= k %如果是节点就跳过
                continue
            else
                if (population(m,j) == k)
                    first = first + TravelTime(k,j);
                end
            end
        end
        %计算第二项 枢纽到枢纽的时间
        %找出所有枢纽点
        num = 0;
         for k = 1:chromosome_size
             if (population(m,k)==k) %找出是枢纽的点 
                 num = num + 1;
                 hub(num) = k;
             end
         end
         for k = 1:num
             for b = 1:num
                  c = hub(k);
                  d = hub(b);
                  if (Fijk(m,c,d,i,chromosome_size) > 0)
                    second = second + TravelTime(c,d);
                  end
             end
         end
        
        time(i,j) = first +second + third;
        if(i == j) time(i,j) = 0;
    end  
end

for i = 1:chromosome_size
    for j = 1:chromosome_size
        if (time(i,j) > TimeQ)
            TimeQ = time(i,j);
        end
    end
end

clear i;
clear j;
clear k;
clear b;

end

