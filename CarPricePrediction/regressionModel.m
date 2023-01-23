carData;
summary(carDataFinal);
r =corrplot(carDataFinal);
x = carDataFinal(:,"price");
y = carDataFinal(:,"mileage");
