if exist('carDataFinalRand','var') == 0
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
n = round(size(carDataFinalRand(:,1))*0.7);
Xtrain = [X1(1:n,1), X1(1:n,2), X1(1:n,3), ...
    X1(1:n,4), X1(1:n,5), X1(1:n,6), X1(1:n,7)];
Ytrain = table2array([carDataFinalRand(1:n,"price")]);

n = n+1;
n2 = size(carDataFinalRand(:,1));
Xtest = [X1(n:n2,1), X1(n:n2,2), X1(n:n2,3), ...
    X1(n:n2,4), X1(n:n2,5), X1(n:n2,6), X1(n:n2,7)];
Ytest = table2array([carDataFinalRand(n:n2,"price")]);


newXtrain = Xtrain';
newYtrain = Ytrain';
newXtest = Xtest';
newYtest =Ytest';


for j= 3:11
    rsqTab = [];
    rmseTab = [];
    for i =1:13
        net = newff(newXtrain,newYtrain,[10,10,5],...
            {'logsig','logsig','logsig','purelin'},'trainbr');
        net.trainParam.show = 10;
        net.trainParam.lr = 0.01;
        net.trainParam.epochs = 200;
        net.trainParam.goal = 1e5;
        
        [net, tr] = train(net,newXtrain,newYtrain);
        
        valA = fix(sim(net,newXtrain));
        valZ = [valA',newYtrain',newYtrain'-valA'];
        
        a = fix(sim(net,newXtest));
        Z = [a',newYtest',newYtest'-a'];
        
        trainNNrmse = fix(rmse(valZ(:,1),valZ(:,2)));
        trainNNmse = fix(mse(valZ(:,1),valZ(:,2)));
        trainNMSE = trainNNmse/mean(var(a,1));
        trainRsquare = 1 - trainNMSE;
        
        testNNrmse = fix(rmse(Z(:,1),Z(:,2)))
        testNNmse = fix(mse(Z(:,1),Z(:,2)));
        testNMSE = testNNmse/mean(var(a,1));
        Rsquare = 1 - testNMSE;
    
        rsqTab(1) = Rsquare;
        rmseTab(1) = testNNrmse;
        i
    end
    accuracy(j)= {[rmseTab',rsqTab']};
    j
end

