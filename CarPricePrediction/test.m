p = [-1 -1 2 2;0 5 0 5];
t = [-1 -1 1 1];
% 
% net=newff(minmax(Xtrain),[3,1],{'tansig','purelin'},'traingd');
% net.trainParam.show = 50;
% net.trainParam.lr = 0.05;
% net.trainParam.epochs = 300;
% net.trainParam.goal = 1e-5;

evalin('base', 'exist(''carDataFinal'',''var'')')