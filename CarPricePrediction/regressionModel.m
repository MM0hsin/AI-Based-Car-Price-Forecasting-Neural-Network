carData;
carDataFinalRand = carDataFinal(randperm(size(carDataFinal,1)), :);
% r = corrplot(carDataFinalRand);

n = 10000;
carTrainX1 = (carDataFinalRand.year(1:n,:)).';
carTrainX2 = (carDataFinalRand.mileage(1:n,:)).';
carTrainT = (carDataFinalRand.price(1:n,:)).';
carTrainMatrix = [carTrainX1(:),carTrainX2(:)].';

net = newff(minmax(carTrainMatrix),[3,1],{'tansig','purelin'},'traingd');
net.trainParam.show = 50;
net.trainParam.lr = 0.05;
net.trainParam.epochs = 300;
net.trainParam.goal = 1e-5;

size(carTrainMatrix)
size(carTrainT)


[net, tr] = train(net,carTrainMatrix,carTrainT);
a = sim(net,carTrainMatrix)