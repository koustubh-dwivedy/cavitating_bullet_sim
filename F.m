% y(1)-> U
% y(2)-> W
% y(3)-> Q
% y(4)-> x
% y(5)-> z
% y(6)-> angle
function vec = F(t,y)

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

	sigma = (pressure - vap_pressure)/(0.5*rho*y(1)*y(1));
	D_k = d*sqrt(k*(1 + sigma)/sigma); %might be wrong
	l = (d/sigma)*sqrt(log(1/sigma));

	l_cav = l*D_k*D_k/(cos(y(6))*(D_k*D_k + tan(y(6))*tan(y(6))*l*l));
	if L <= l_cav
		l_k = 0
	else
		l_k = L - l_cav;
	end

	x_intersec_coord = l*D_k*D_k/((D_k*D_k + tan(y(6))*tan(y(6))*l*l));
	y_intersec_coord = l*D_k*D_k*tan(y(6))/((D_k*D_k + tan(y(6))*tan(y(6))*l*l));
	theta = abs(y(6)) - abs(atan(-(x_intersec_coord - l/2)*(D_k*D_k/4)/((l*l/4)*y_intersec_coord)));

	F1 = 16*y(3)*y(3)*(l_k^(7/2))/105 + (2/3)*y(2)*y(2)*(l_k^(3/2)) + (4/3)*y(2)*y(3)*L*(l_k^(3/2)) + (2/3)*y(3)*y(3)*L*L*(l_k^(3/2)) - (8/15)*y(3)*(l_k^(5/2))*(y(2) - y(3)*L);
	F_nose = -0.5*rho*pi*r*r*k*(y(1)*y(1) + y(2)*y(2))*sqrt((k*k + 2*c*k)*(y(1)*y(1)/(y(1)*y(1) + y(2)*y(2))) + c*c);
	F_x = (-0.5*rho*k*y(1)*y(1)*(r*r*acos((r - l_k*tan(theta))/r) - (r - l_k*tan(theta))*sqrt(d*l_k*tan(theta)))) + F_nose; %might be wrong coz of abs
	F_z = -rho*k*F1*sqrt(d*tan(theta)); %might be wrong coz of abs

	E1 = y(2)*y(2)*(l_k*l_k/2 - l_k*x_cm) + 2*y(2)*y(3)*(l_k*l_k*(L + x_cm) - l_k*l_k*l_k/3 - L*x_cm*l_k) + y(3)*y(3)*(L*L*l_k*l_k/2 - L*L*x_cm*l_k - 2*L*l_k*l_k*l_k/3 + L*x_cm*l_k*l_k + l_k*l_k*l_k*l_k/4 - l_k*l_k*l_k*x_cm/3); %might be wrong
	E2 = (l_k*l_k*l_k/6 - l_k*l_k*x_cm/2)/tan(theta);
	E3 = (l_k*l_k*l_k*(L + x_cm)/6 - l_k*l_k*l_k*l_k/12 - L*x_cm*l_k*l_k/2)/tan(theta);


	vec(1) = (F_x/m) - y(2)*y(3) - (L - x_cm)*y(3)*y(3);
	vec(2) = ((F_z/m) + y(3)*y(1) - ((L - x_cm)*K*rho*d*E1/(I*(1 - K*rho*d*E3))))/(1 + (L - x_cm)*K*rho*d*E2/(I*(1 - K*rho*d*E3)));
	vec(3) = K*rho*d*(E1 + E2*vec(2))/(1 - K*rho*d*E3);
	vec(4) = y(1);
	vec(5) = y(2);
	vec(6) = y(3);
    vec = vec';
end