global c;
global m;
global d;
global L;

run('C_D.m');
run('param.m');

init_W = 0;
init_Q = 0;

range = 20;
init_time = 0.25;
[t y]=ode45(@F_1,[0 init_time], [init_U; init_W; init_Q; 0; 0; 0;]);

counter = 0;

while max(y(:, 4)) < range
    counter = counter + 1;
    if counter > 10
        break;
        could_not_reach_range = 123456789
    end
    init_time = init_time*2;
    [t y]=ode45(@F_1,[0 init_time], [init_U; init_W; init_Q; 0; 0; 0;]);
end
% y(1)-> U
% y(2)-> W
% y(3)-> Q
% y(4)-> x
% y(5)-> z
% y(6)-> angle

temp = 0;

for i = 1:length(t)
    if y(i, 4) > range
        temp = y(i, 4);
    end
end

dlmwrite('obj_fn.dat', temp);