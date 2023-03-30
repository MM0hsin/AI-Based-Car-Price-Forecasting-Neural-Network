% boxplot(carDataFinal.mileage)
% title('Mileage Boxplot')
% ylabel("Miles")

% dielselN = nnz (carDataFinal.fuelType == 1);
% petrolN = nnz (carDataFinal.fuelType == 3);
% hybridN = nnz (carDataFinal.fuelType == 2);
% x = categorical({'petrol', 'diesel', 'hybrid'});
% y = [petrolN,dielselN,hybridN];
% b = bar(x,y)
% xtips1 = b(1).XEndPoints;
% ytips1 = b(1).YEndPoints;
% labels1 = string(b(1).YData);
% text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
%     'VerticalAlignment','bottom')

% automaticN = nnz (carDataFinal.automatic == 1);
% manualN = nnz(carDataFinal.manual == 1);
% x = categorical({'Automatic', 'Manual'});
% y = [automaticN,manualN];
% b = bar(x,y)
% xtips1 = b(1).XEndPoints;
% ytips1 = b(1).YEndPoints;
% labels1 = string(b(1).YData);
% text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
%     'VerticalAlignment','bottom')

