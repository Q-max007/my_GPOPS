function phaseout = BrysonDenhamContinuous(input)

%t = input.phase.time;
%x1 = input.phase.state(:,1);
x2 = input.phase.state(:,2);
%x3 = input.phase.state(:,3);
u = input.phase.control;

dx1 = x2;
dx2 = u;
dx3 = (u.^2)./2;

phaseout.dynamics = [dx1, dx2, dx3];
