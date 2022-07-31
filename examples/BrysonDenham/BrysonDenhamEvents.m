function output = BrysonDenhamEvents(input)

x3f = input.phase.finalstate(3);

%--Cost--
output.objective = x3f;