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
fuelN = 1:3;
typeFuel = dictionary(fuel,fuelN.');

carDataFinal = x(:,:);
carDataFinal.model = nameNarray;

carDataFinal.transmission = transmissionNarray;
manual = [];
automatic = [];
for i=1:height(transmissionNarray)
    if transmissionNarray(i,1) == 1
        manual(i) = 1;
        automatic(i) = 0;
    else
        automatic(i) = 1;
        manual(i) = 0;
    end
end

carDataFinal(:,"transmission") = [];
carDataFinal.manual = manual.';
carDataFinal.automatic = automatic.';

carDataFinal(:,"fuelType")=[];
carDataFinal.fuelType = fuelNarray;
petrol = [];
diesel = [];
hybrid = [];
for i=1:height(fuelNarray)
    if fuelNarray(i) == 1
        diesel(i) = 1;
        petrol(i) = 0;
        hybrid(i) = 0;
    elseif fuelNarray(i) == 2
        hybrid(i) = 1;
        diesel(i) = 0;
        petrol(i) = 0;
    else 
         petrol(i) = 1;
         diesel(i) = 0;
         hybrid(i) = 0;
    end
end
carDataFinal.petrol = petrol.';
carDataFinal.diesel = diesel.';
carDataFinal.hybrid = hybrid.';


