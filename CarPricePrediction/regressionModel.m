% carData;
% summary(carDataFinal);
% r =corrplot(carDataFinal);
y = carDataFinal(:,"price");
x1 = table2array(carDataFinal(:,"mileage"));
x2 = table2array(carDataFinal(:,"engineSize"));

b1 = x1\y;
yCalc1 = b1*x1;
scatter(x1,y)
hold on
plot(x1,yCalc1)
xlabel('Milage')
ylabel('Price')
title('Linear Regression Relation Between Milage & Price')
grid on

X = [ones(size(x1)) x1 x2 x1.*x2];
b = regress(y,X);

scatter3(x1,x2,y,'filled')
hold on
x1fit = min(x1):100:max(x1);
x2fit = min(x2):10:max(x2);
[X1FIT,X2FIT] = meshgrid(x1fit,x2fit);
YFIT = b(1) + b(2)*X1FIT + b(3)*X2FIT + b(4)*X1FIT.*X2FIT;
mesh(X1FIT,X2FIT,YFIT)
xlabel('Milage')
ylabel('Engine Size')
zlabel('price')
view(50,10)
hold off