x = readtable("40kCars.xlsx");
x = rmmissing(x);

carDataFinal = x(:,:);

%remove 'other' transmission
T9 = carDataFinal.transmission == "Other";
carDataFinal(T9,:) = [];

%Remove 'other' fueltype
FT9 = carDataFinal.fuelType == "Other";
carDataFinal(FT9,:) = [];

%finds all the unique transission attributes and sets it to transmision
% transmissionNarray creates an array of transmission for the cars
%create a dictionary so i know what number correspnds to the transmission
[transmission,~,transmissionNarray] = unique(carDataFinal.transmission);
transmissionN = 1:size(transmission);
typeTransmission = dictionary(transmission,transmissionN.');

%same as transmission
[fuel,~,fuelNarray] = unique(carDataFinal.fuelType);
fuelN = 1:size(fuel);
typeFuel = dictionary(fuel,fuelN.');

%this using the numbers corresponding to transmission splits the data into
%... automatic or manual
manual = [];
automatic = [];
for i=1:height(carDataFinal.model)
    if transmissionNarray(i,1) == 2
        manual(i) = 1;
        automatic(i) = 0;
    elseif transmissionNarray(i,1) == 1 || transmissionNarray(i,1) == 4
        automatic(i) = 1;
        manual(i) = 0;
    end
end
%drop transmission and append manual and automatic
carDataFinal(:,"transmission") = [];
carDataFinal.manual = manual.';
carDataFinal.automatic = automatic.';

%same as transmission
carDataFinal(:,"fuelType")=[];
carDataFinal.fuelType = fuelNarray;
petrol = [];
diesel = [];
hybrid = [];
for i=1:height(carDataFinal.model)
    if fuelNarray(i) == 1
        diesel(i) = 1;
        petrol(i) = 0;
        hybrid(i) = 0;
    elseif fuelNarray(i) == 2
        hybrid(i) = 1;
        diesel(i) = 0;
        petrol(i) = 0;
    elseif fuelNarray(i) == 3
         petrol(i) = 1;
         diesel(i) = 0;
         hybrid(i) = 0;
    end
end
carDataFinal.petrol = petrol.';
carDataFinal.diesel = diesel.';
carDataFinal.hybrid = hybrid.';





