% y(1)-> U
% y(2)-> x
function vec = F_2(t,y)

	c = 0;

	m = 0.15;
	I = 1.46*(10^(-4));
	x_cm = 0.0542;
	L = 0.108;
	d = 0.0150;
	r = d/2;
	rho = 1000;
	vap_pressure = 2.5*(10^3);
	pressure = rho*9.8*1; %at 1m depth

	k = 0.82;
	K = 2*pi;

	F_nose = -0.5*rho*pi*r*r*k*(y(1)*y(1))*sqrt((k*k + 2*c*k)*(y(1)*y(1)/(y(1)*y(1))) + c*c);
	F_x = F_nose;

	vec(1) = (F_x/m);
	vec(2) = y(1);
    vec = vec';
end