clear();clc();
%% Task - 1: Cross-points between 2 MA
je6 = readtable('JustEat6M-close.xlsx');
dates = table2array(je6(:,1));  %convert dates to array
close = table2array(je6(:,2));  %convert prices to array
Ldays = 7 ;    %define the lower moving average
Udays = 14;    %define the upper moving average

LowMA = cat(1,zeros(Ldays-1,1) ,movmean(close,Ldays,'Endpoints','discard'));  % calculate the moving average for lower days
UpMA = cat(1,zeros(Udays-1,1) ,movmean(close,Udays,'Endpoints','discard'));   % calculate the moving average for upper days

budget = 1000000;
shares_owned = 0;
profit = 0;
loss = 0;

%find the crosspoints - 
%if low cross up from bottom (BUY); if low cross up from top (SELL)

action = strings(length(UpMA)-1,1);
action(1) = "HODL";
for i = 2:length(UpMA)
    if((LowMA(i-1)<UpMA(i-1)) && (LowMA(i)>UpMA(i)))  %if the 14MA crosses the 7MA from TOP - BUY
        action(i) = "BUY";
        shares_owned = floor(budget/close(i)); % check how many whole shares can be afforded
        loss = shares_owned * close(i); % money lost from budget
        budget = budget - (shares_owned * close(i)); % buy with the available budget
        disp("BUY");disp(dates(i)); disp("Shares Owned"); disp (shares_owned); disp ("Budget"); disp (budget); disp ("Amount Spent"); disp (loss);
        disp(" ");disp(" ")
    elseif((LowMA(i-1)>UpMA(i-1)) && (LowMA(i)<UpMA(i))) %if the 14MA crosses the 7MA from BOTTOM - SELL
        action(i) = "SELL";
        if (shares_owned>0) %if you already own shares, then sell
            profit = (shares_owned * close(i))-loss; %money gained from sale
            budget = budget + (shares_owned * close(i)); %budget after selling the portfolio
            shares_owned = 0; %Sell entire portfolio
            disp("SELL");disp(dates(i));disp("Shares Owned"); disp (shares_owned); disp ("Budget"); disp(budget); disp ("Profit gained"); disp (profit);
            disp(" ");disp(" ")
        end
    else
        action(i) = "HODL"; % all other periods - HODL
    end
end

total_profit = budget - 1000000;
disp("Total Profit"); disp(total_profit);
