% carData;
% summary(carDataFinal);
% r =corrplot(carDataFinal);
y = table2array(carDataFinal(:,"price"));
x = table2array(carDataFinal(:,"mileage"));

b1 = x\y;
yCalc1 = b1*x;
scatter(x,y)
hold on
plot(x,yCalc1)
xlabel('Milage')
ylabel('Price')
title('Linear Regression Relation Between Milage & Price')
grid on