if exist('carDataFinal','var') == 0
    carData;
    carDataFinalRand = carDataFinal(randperm(size(carDataFinal,1)), :);
    r = corrplot(carDataFinalRand);
end

X1 = table2array([carDataFinalRand(:,"year"), ...
    carDataFinalRand(:,"mileage"), ...
    carDataFinalRand(:,"tax"), ...
    carDataFinalRand(:,"mpg"),...
    carDataFinalRand(:,"engineSize"), ...
    carDataFinalRand(:,"automatic"),...
    carDataFinalRand(:,"fuelType")]);
Y = table2array([carDataFinalRand(:,"price")]);

n = 10000;
Xtrain = [X1(1:n,1), X1(1:n,2), X1(1:n,3), ...
    X1(1:n,4), X1(1:n,5), X1(1:n,6), X1(1:n,7)];
Ytrain = table2array([carDataFinalRand(1:n,"price")]);

Xtrain = Xtrain.';
Ytrain = Ytrain.';

net = newff(Xtrain,Ytrain,[20,20,20],{'tansig','purelin'},'trainlm');
net.trainParam.show = 50;
net.trainParam.lr = 0.05;
net.trainParam.epochs = 300;
net.trainParam.goal = 1e-5;

size(Xtrain)
size(Ytrain)

[net, tr] = train(net,Xtrain,Ytrain);
a = fix(sim(net,Xtrain));

Z = [a.',Ytrain.',Ytrain.'-a.'];