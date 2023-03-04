function [numberOpt] = simulation(State)

%Initial Parameters

t0 = 0;
dt = 1;
T = 50;

%Random State being received from Agent based Modelling (abm) file
%State = [1 1 1 1 1 1 0 0 0 0];
n = length(State);

for j = t0:dt:T
  
    randval = rand();
    
    %Update Agents
    % If optimists are more than pessimists
    if (sum(State)>n-sum(State))                        % sum(State) = optimists || n-sum(State) = pessimist
        prob1 = (abs(sum(State)-(n-sum(State))))/(n^2);
        p = find(State == 0);                           % find index of all pessimists and 
        if(prob1>randval && ~isempty(p)) 
            State(p(1)) = 1;                            % update one agent to show optimist.
        end

    % If pessimists are more than optimists
    elseif (sum(State)<n-sum(State))
        prob2 = (abs(n-sum(State)-sum(State)))/(n^2);
        o = find(State == 1);                           % find index of all optimists and
        if(prob2>randval && ~isempty(o))
            State(o(1)) = 0;                            % update one agent to show pessimist.
        end

    % If pessimists are equal to optimists   
    elseif (sum(State) == n-sum(State))
        prob3 = 0.01;
        if(prob3>randval)
            r = randi([1,10]);                          % get a random number between 1 and 10
            if( State(r) == 0)                          % check if pessimist
                State(r) = 1;                           % if true, update to optimist 
            else
                State(r) = 0;                           % if false, update to pessimist
            end
        end

    end
    
end
numberOpt = sum(State);                                 % number of optimists 
end