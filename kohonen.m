clear; clc;
%%
Uold = rand(2,64);
[r c] = size(Uold);
u = Uold;
T = 10000;
alpha = 0.5;
radius = [0.05 0.1 0.2 0.3 0.4];
%radius = 0.3;
d = 4;
Unew = Uold;
for t=1:T            %number of iterations
    e1 = rand;
    e2 = rand;
    E = [e1;e2];
   for i=1:c        %loop for comparing the nearest vector to E
          m(i) = norm(E-Uold(:,i));      %making a vector contain the distance of E and U
   end
   [k v] = min(m,[],2);       %finding the min value and related index of norm vector and 
   for i=1:c            %loop for update the winner neuron and neighbors by radius 
       l = norm(Uold(:,v)-Uold(:,i));
       if (l <= radius(d+1))
       %if (l <= radius)
            Unew(:,i) = Uold(:,i) + alpha * (E - Uold(:,i));
       end
   end
   Uold = Unew;
   alpha = alpha *(1-t/T);        %update the learning rate
   d = fix(d*(1-t/T));            %update the radius
end
%Unew
%%
for i=1:c
   hold on
   grid on
   plot(u(1,i),u(2,i),'*k')
end
hold on
for i=1:c
   hold on
   plot(Unew(1,i),Unew(2,i),'or')
   hold on
   if i == 64
       break
   end
   %line([Unew(1,i);Unew(1,i+1)],[Unew(2,i);Unew(2,i+1)])
end
figure
plotsom(Unew)