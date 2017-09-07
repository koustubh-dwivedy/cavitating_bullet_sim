init_U = 1000; %will actually come from param.dat file

[t y]=ode45(@F_2,[0 0.25], [init_U; 0;]);
% y(1)-> U
% y(2)-> x