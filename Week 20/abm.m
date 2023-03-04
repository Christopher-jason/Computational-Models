iter = input("Enter the number of times you want to run the simulations: ");

Optnum = zeros(iter,1);       % create a list to capture the number of optimists in each iteration

for i = 1:iter
    State = randi([0 1],1,10);      % create a random State of 1's and 0's for the simulation
    Optnum(i) = simulation(State);  % captures the sum of optimists in each round
end
disp(" ")
disp("The number of optimists in each round is: ")
disp(Optnum)