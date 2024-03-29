if exist('carDataFinal','var') == 0
    carData;
    carDataFinalRand = carDataFinal(randperm(size(carDataFinal,1)), :);
    r = corrplot(carDataFinalRand(:,2:13));
end

X1 = table2array([carDataFinalRand(:,"year"), ...
    carDataFinalRand(:,"mileage"), ...
    carDataFinalRand(:,"tax"), ...
    carDataFinalRand(:,"mpg"),...
    carDataFinalRand(:,"engineSize"), ...
    carDataFinalRand(:,"automatic"),...
    carDataFinalRand(:,"fuelType"),]);
Y = table2array([carDataFinalRand(:,"price")]);

%use 70% of data for training rest for testing
n = round(size(carDataFinal(:,1))*0.7);
Xtrain = [X1(1:n,1), X1(1:n,2), X1(1:n,3), ...
    X1(1:n,4), X1(1:n,5), X1(1:n,6), X1(1:n,7)];
Ytrain = table2array([carDataFinalRand(1:n,"price")]);

n = n+1;
n2 = size(carDataFinal(:,1));
Xtest = [X1(n:n2,1), X1(n:n2,2), X1(n:n2,3), ...
    X1(n:n2,4), X1(n:n2,5), X1(n:n2,6), X1(n:n2,7)];
Ytest = table2array([carDataFinalRand(n:n2,"price")]);

model = fitlm(Xtrain,Ytrain)
pred = fix(predict(model,Xtest));

Z = fix([pred,Ytest,pred-Ytest]);
