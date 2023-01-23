% carData;
% summary(carDataFinal);
% r =corrplot(carDataFinal);
y = table2array(carDataFinal(:,"price"));
x = table2array(carDataFinal(:,"mileage"));

b1 = x\y
