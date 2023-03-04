%% Task 2 - Double auction market
    

Traders = [1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0];
items_owned = zeros(1,20);

buyers = find(Traders == 0);
sellers = find(Traders == 1);


items_owned = Seller_Create(length(sellers), items_owned, sellers);

% Starts bids and asks from Buyers and sellers

function items_owned = Seller_Create(seller_len, items_owned, sellers)
    for i = 1:seller_len
        items_owned(sellers(i)) = randi([1,10],1); % randon number of items for each seller
    end
end