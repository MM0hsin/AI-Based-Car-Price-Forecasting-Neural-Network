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

n = 4000;
Xtrain = [X1(1:n,1), X1(1:n,2), X1(1:n,3), ...
    X1(1:n,4), X1(1:n,5), X1(1:n,6), X1(1:n,7), X1(1:n,8)];
Ytrain = table2array([carDataFinalRand(1:n,"price")]);

n=n+1;
n2 = 8000;
Xtrain1 = [X1(n:n2,1), X1(n:n2,2), X1(n:n2,3), ...
    X1(n:n2,4), X1(n:n2,5), X1(n:n2,6), X1(n:n2,7), X1(n:n2,8)];
Ytrain1 = table2array([carDataFinalRand(n:n2,"price")]);

n2 = n2+1;
n3 = 12000;
Xtest = [X1(n2:n3,1), X1(n2:n3,2), X1(n2:n3,3), ...
    X1(n2:n3,4), X1(n2:n3,5), X1(n2:n3,6), X1(n2:n3,7),X1(n2:n3,8)];
Ytest = table2array([carDataFinalRand(n2:n3,"price")]);


n4 = 16000;
Xtest1 = [X1(n3:n4,1), X1(n3:n4,2), X1(n3:n4,3), ...
    X1(n3:n4,4), X1(n3:n4,5), X1(n3:n4,6), X1(n3:n4,7),X1(n3:n4,8)];
Ytest1 = table2array([carDataFinalRand(n3:n4,"price")]);

Xtrain = Xtrain.';
Ytrain = Ytrain.';
Xtest = Xtest.';
Ytest =Ytest.';

net = newff(Xtrain,Ytrain,[20,20,20],{'logsig','purelin'},'trainlm');
net.trainParam.show = 50;
net.trainParam.lr = 0.05;
net.trainParam.epochs = 100;
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

NNaccuracy = correct/4000
fix(mean(abs(Z(:,3))))