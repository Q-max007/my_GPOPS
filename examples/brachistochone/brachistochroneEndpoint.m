%-------------------------------------------%
% BEGIN: function brachistochroneEndpoint.m %
%-------------------------------------------%
function output = brachistochroneEndpoint(input);

tf = input.phase(1).finaltime;
output.objective = tf;

%-------------------------------------------%
% END: function brachistochroneEndpoint.m   %
%-------------------------------------------%

