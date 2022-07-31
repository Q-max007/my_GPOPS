function phaseout = rlvEntryContinuous(input)

% input
% input.phase(phasenumber).state
% input.phase(phasenumber).control
% input.phase(phasenumber).time
% input.phase(phasenumber).parameter
%
% input.auxdata = auxiliary information
%
% output
% phaseout(phasenumber).dynamics
% phaseout(phasenumber).path
% phaseout(phasenumber).integrand

h = input.phase.state(:,1);
L = input.phase.state(:,2);
Vr = input.phase.state(:,3);
Vn = input.phase.state(:,4);
m = input.phase.state(:,5);
T = input.phase.control(:,1);
theta = input.phase.control(:,2);

Rm  = input.auxdata.Rm;
gn  = input.auxdata.gn;
Lsp = input.auxdata.Lsp;

ctheta=cos(theta);
stheta=sin(theta);

hdot     = -Vr;
Ldot     = Vn;
Vrdot    = gn-Vn.*Vn./Rm-T.*ctheta./m;
Vndot    = 2*Vr.*Vn./Rm-T.*stheta./m;
mdot     = -T./Lsp./gn;

phaseout.dynamics  = [hdot, Ldot, Vrdot, Vndot, mdot];
end
