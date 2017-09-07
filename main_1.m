init_U = 1000; %will actually come from param.dat file
init_W = 0;
init_Q = 1;

[t y]=ode45(@F_1,[0 0.25], [init_U; init_W; init_Q; 0; 0; 0;]);
% y(1)-> U
% y(2)-> W
% y(3)-> Q
% y(4)-> x
% y(5)-> z
% y(6)-> angle