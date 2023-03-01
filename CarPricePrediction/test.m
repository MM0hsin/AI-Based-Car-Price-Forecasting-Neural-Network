% Load and preprocess the data
load AllCars.xlsx
X = zscore(carData(:,1:5)); % normalize the numerical features
T = carData(:,6); % target values (i.e., car prices)
[Xtrain,Xval,Xtest,Ttrain,Tval,Ttest] = divideblock(size(X,1),0.6,0.2,0.2);

% Choose a neural network architecture
hiddenLayerSize = 10;
net = neuralnet(hiddenLayerSize);

% Train the neural network
trainFcn = 'trainlm'; % Levenberg-Marquardt backpropagation
net = train(net,Xtrain',Ttrain',[],[],Xval',Tval');

% Validate the neural network
Yval = sim(net,Xval');
mse_val = mse(Yval',Tval);
disp(['MSE on validation set: ', num2str(mse_val)]);

% Test the neural network
Ytest = sim(net,Xtest');
mse_test = mse(Ytest',Ttest);
disp(['MSE on test set: ', num2str(mse_test)]);