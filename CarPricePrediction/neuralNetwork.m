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
    carDataFinalRand(:,"fuelType"), ...
    carDataFinalRand(:,"model"),]);
Y = table2array([carDataFinalRand(:,"price")]);

n = 8000;
Xtrain = [X1(1:n,1), X1(1:n,2), X1(1:n,3), ...
    X1(1:n,4), X1(1:n,5), X1(1:n,6), X1(1:n,7), X1(1:n,8)];
Ytrain = table2array([carDataFinalRand(1:n,"price")]);

n1 = 16000
Xtest = [X1(n:n1,1), X1(n:n1,2), X1(n:n1,3), ...
    X1(n:n1,4), X1(n:n1,5), X1(n:n1,6), X1(n:n1,7),X1(n:n1,8)];
Ytest = table2array([carDataFinalRand(n:n1,"price")]);

Xtrain = Xtrain.';
Ytrain = Ytrain.';
Xtest = Xtest.';
Ytest =Ytest.';

net = newff(Xtrain,Ytrain,[20,20,20],{'tansig','purelin'},'trainlm');
net.trainParam.show = 50;
net.trainParam.lr = 0.05;
net.trainParam.epochs = 300;
net.trainParam.goal = 1e-5;


[net, tr] = train(net,Xtrain,Ytrain);
a = fix(sim(net,Xtest));

Z = [a.',Ytest.',Ytest.'-a.'];

correct = 0;
for i = 1:size(Z)
    if abs(Z(i,3)) < 5000
        correct = correct +1;
    end
end
accuracy = correct/8001