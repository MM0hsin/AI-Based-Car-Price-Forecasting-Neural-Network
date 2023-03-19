x = readtable("40kCars.xlsx");
x = rmmissing(x);
modelType = table2array(x(:,"model"));
transmissionType = table2array(x(:,"transmission"));
fuelType = table2array(x(:,"fuelType"));

[transmission,~,transmissionNarray] = unique(transmissionType);
transmissionN = 1:size(transmission);
typeTransmission = dictionary(transmission,transmissionN.');

[fuel,~,fuelNarray] = unique(fuelType);
fuelN = 1:size(fuel);
typeFuel = dictionary(fuel,fuelN.');

carDataFinal = x(:,:);

carDataFinal.transmission = transmissionNarray;
manual = [];
automatic = [];
for i=1:height(transmissionNarray)
    if transmissionNarray(i,1) == 2
        manual(i) = 1;
        automatic(i) = 0;
    elseif transmissionNarray(i,1) == 1 || transmissionNarray(i,1) == 4
        automatic(i) = 1;
        manual(i) = 0;
    else
        automatic(i) = 9;
        manual(i) = 9;

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
    elseif fuelNarray(i) == 4
         petrol(i) = 1;
         diesel(i) = 0;
         hybrid(i) = 0;
    else
        petrol(i) = 9;
        diesel(i) = 9;
        hybrid(i) = 9;
    end
end
carDataFinal.petrol = petrol.';
carDataFinal.diesel = diesel.';
carDataFinal.hybrid = hybrid.';

%Remove 'other' fueltype
FT9 = carDataFinal.petrol ==9;
carDataFinal(FT9,:) = [];

%Remove 'other' transmission
T9 = carDataFinal.automatic == 9;
carDataFinal(T9,:) = [];




