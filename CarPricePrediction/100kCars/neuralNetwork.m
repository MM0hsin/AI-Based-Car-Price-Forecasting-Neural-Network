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
X1 = zscore(X1);

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


newXtrain = Xtrain';
newYtrain = Ytrain';
newXtest = Xtest';
newYtest =Ytest';

net = newff(newXtrain,newYtrain,[1],{'tansig','tansig'},'trainlm');
net.trainParam.show = 10;
net.trainParam.lr = 5;
net.trainParam.epochs = 200;
net.trainParam.goal = 1e-10;

[net, tr] = train(net,newXtrain,newYtrain);

valA = fix(sim(net,newXtrain));
valZ = [valA',newYtrain',newYtrain'-valA'];

a = fix(sim(net,newXtest));
Z = [a',newYtest',newYtest'-a'];


NNrmse = fix(rmse(Z(:,1),Z(:,2))) + " at Epochs: " + net.trainParam.epochs
NNrmse = fix(rmse(valZ(:,1),valZ(:,2))) + " of val at Epochs: " + net.trainParam.epochs
NNmae = fix(mae(Z(:,1),Z(:,2)));

%validation
