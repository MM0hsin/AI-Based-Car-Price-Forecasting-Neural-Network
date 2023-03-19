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
    carDataFinalRand(:,"fuelType")]);
y = table2array([carDataFinalRand(:,"price")]);

X = (X1 - mean(X1)) ./ std(X1);


% Split the dataset into training and testing sets
train_ratio = 0.8; % Use 80% of data for training
idx = randperm(size(X, 1));
train_idx = idx(1:round(train_ratio * length(idx)));
test_idx = idx(round(train_ratio * length(idx))+1:end);
X_train = X(train_idx, :);
y_train = y(train_idx, :);
X_test = X(test_idx, :);
y_test = y(test_idx, :);

% Define the neural network architecture
hidden_layer_size = 10;
net = feedforwardnet(hidden_layer_size);

% Train the network
net.trainFcn = 'trainlm'; % Use Levenberg-Marquardt algorithm for training
net.trainParam.showWindow = false; % Do not show training window
net = train(net, X_train', y_train');

% Evaluate the network on the testing set
y_pred = net(X_test');
mse = mean((y_pred - y_test').^2);
mae = mean(abs(y_pred - y_test'));
rmse = rmse(y_pred', y_test);

% Print the evaluation metrics
fprintf('MSE: %f\n', mse);
fprintf('MAE: %f\n', mae);
fprintf('R2: %f\n', rmse);

% Make a prediction on a new car
new_car = [2018, 45000, 4, 2.0, 4, 2, 1];
new_car_norm = (new_car - mean(X)) ./ std(X);
price = net(new_car_norm');
fprintf('The predicted price for the new car is $%f\n', price);