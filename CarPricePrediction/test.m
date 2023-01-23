x = readtable("AllCars.xlsx");
x = rmmissing(x);
modelType = table2array(x(:,"model"));
transmissionType = table2array(x(:,"transmission"));
fuelType = table2array(x(:,"fuelType"));

[name,~,nameNarray] = unique(modelType);
nameN = 1:167;
typeModel = dictionary(name,nameN.');


[transmission,~,transmissionNarray] = unique(transmissionType);
transmissionN = 1:3;
typeTransmission = dictionary(transmission,transmissionN.');


[fuel,~,fuelNarray] = unique(fuelType);
fuelN = 1:4;
typeFuel = dictionary(fuel,fuelN.');

carDataFinal = x(:,:);
carDataFinal.model = nameNarray;
carDataFinal.fuelType = fuelNarray;


carDataFinal.transmission = transmissionNarray;
manual = [];
for i=1:height(transmissionNarray)
    if transmissionNarray(i,1) == 1
        manual(i) = 1;
    else
        manual(i) = 0;
    end
end
automatic = [];
for i=1:height(transmissionNarray)
if transmissionNarray(i,1) == 2 || transmissionNarray(i,1) == 3
        automatic(i) = 1;
    else
        automatic(i) = 0;
    end
end
carDataFinal(:,"transmission") = [];
carDataFinal.manual = manual.';
carDataFinal.automatic = automatic.';
