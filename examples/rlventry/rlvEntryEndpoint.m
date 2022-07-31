function output = rlvEntryEndpoint(input)

% Inputs
% input.phase(phasenumber).initialstate -- row
% input.phase(phasenumber).finalstate -- row
% input.phase(phasenumber).initialtime -- scalar
% input.phase(phasenumber).finaltime -- scalar
% input.phase(phasenumber).integral -- row
%
% input.parameter -- row

% input.auxdata = auxiliary information

% Output
% output.objective -- scalar
% output.eventgroup(eventnumber).event -- row
mf = input.phase.finalstate(5);

% cost
output.objective = mf;