clc;
close all;
clear all;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Binary Classification Example For Healt of Plants
%   
%   Dataset Definition : 
%       X0 : Bias
%       X1 : pH
%       X2 : Temperature (Centigrade)
%       X3 : Moisture Percentage
%       Y  : 1 if healtly, 0 is not healty
%
%   For Healty Plants : 
%       - pH should be between 5,5 and 8,5
%       - Temperature should be between 24 and 34 centigrades
%       - Moisture percentage should be between %45 and %55
%
%   Assumptions :
%       - Plants cannot survive outside the 4 and 10 pH range
%       - Plants cannot survive outside the 15 and 40 centigrades range
%       - Plants cannot survive outside the 20% and 80% moisture range
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Create Dataset
%
M = 1000; %Mumber of Samples
%
% bias = 1;
% phMin = 0;
% phMax = 0;
% tempMin = 0;
% tempMax = 0;
% moisMin = 0;
% moisMax = 0;
%
X0healthy = ones(1,M/2);
X1healthy = randi([60,80],1,M/2)/10;
X2healthy = randi([200,340],1,M/2)/10;
X3healthy = randi([400, 600],1,M/2)/10;
Yhealthy = ones(1,M/2);
%
X0unhealthy = ones(1,M/2)*0.5;
X1unhealthy = randi([40,100],1,M/2)/10;
X2unhealthy = randi([180,400],1,M/2)/10;
X3unhealthy = randi([300,800],1,M/2)/10;
Yunhealthy = zeros(1,M/2);

X0 = [X0healthy X0unhealthy]';
X1 = [X1healthy X1unhealthy]';
X2 = [X2healthy X2unhealthy]';
X3 = [X3healthy X3unhealthy]';

%% Normalize Dataset
X = [X0 mat2gray(X1) mat2gray(X2) mat2gray(X3)];
Y =  [Yhealthy Yunhealthy]';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot Dataset


%% 2D plots from different perspectives
figure
subplot(3,1,1);
plot(X1healthy,X2healthy, 'rx');
hold on
plot(X1unhealthy,X2unhealthy, 'bo');
xlabel('pH');
ylabel('Temperature(C)');
title('pH-Temperature Perspective');

subplot(3,1,2);
plot(X2healthy,X3healthy, 'rx');
hold on
plot(X2unhealthy,X3unhealthy, 'bo');
xlabel('Temperature(C)');
ylabel('Moisture(%)');
title('Temperature-Moisture Perspective');

subplot(3,1,3);
plot(X1healthy,X3healthy, 'rx');
hold on
plot(X1unhealthy,X3unhealthy, 'bo');
xlabel('pH');
ylabel('Moisture(%)');
title('pH-Moisture Persective');

%% 3D Plot
figure
scatter3(X1healthy, X2healthy, X3healthy, 'rx' )
hold on
scatter3(X1unhealthy, X2unhealthy, X3unhealthy, 'bo' )


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Neural Network Model
% H(x) = 1/(1 + exp(-(theta(1)*X(1) + theta(2)*X(2) + theta(3)*X(3) + theta(4)*X(4))))

%theta matrix definition
theta = zeros(4,1);

% Error Function 
errorFunc = -1./(M).*(Y.*log(1./(1 + exp(-(theta(1,1).*X(:,1) + theta(2,1).*X(:,2) + theta(3,1).*X(:,3) + theta(4,1).*X(:,4)))))...
                                  + (1 - Y).*log(1 - 1./(1 + exp(-(theta(1,1).*X(:,1) + theta(2,1).*X(:,2) + theta(3,1).*X(:,3) + theta(4,1).*X(:,4) )))));        
% Hyper Parameters                             
alpha = 0.001;                      % Learning rate
epsilon = 1e-5*ones(length(X0),1);  % Min expected error
iter = 0;                              % iteratio n
iMax = 2000;                       % max iteration

%% Learning Algorithm
while (sum(abs(errorFunc(:,1)) > epsilon ) ~= 0) && iMax > iter
    iter = iter + 1;
    
    
    for i = 1:1:M
       h(i) = 1./(1 + exp(-(theta(1,1).*X(i,1) + theta(2,1).*X(i,2) + theta(3,1).*X(i,3) + theta(4,1).*X(i,4))));
       
       temp1 = theta(1,1) - alpha*( h(i) - Y(i,1))*X(i,1);
       
       temp2 = theta(2,1) - alpha*( h(i) - Y(i,1))*X(i,2);
       
       temp3 = theta(3,1) - alpha*( h(i) - Y(i,1))*X(i,3);
       
       temp4 = theta(4,1) - alpha*( h(i) - Y(i,1))*X(i,4);
        
       theta(1,1) = temp1;
       theta(2,1) = temp2;
       theta(3,1) = temp3;
       theta(4,1) = temp4;
       
       errorFunc(i, 1) = -1/(M)*(Y(i,1)*log(1/(1 + exp(-(theta(1,1)*X(i,1) + theta(2,1)*X(i,2) + theta(3,1)*X(i,3) + theta(4,1)*X(i,4)))))...
                                  + (1 - Y(i,1))*log(1 - 1/(1 + exp(-(theta(1,1)*X(i,1) + theta(2,1)*X(i,2) + theta(3,1)*X(i,3) + theta(4,1)*X(i,4))))));                         
    end
    
     
     fprintf(" Mean error : %g\n", mean(errorFunc));
%     fprintf(" Iteration  : %d\n", iter);
    
end


%% Plot Output

hX = 1./(1 + exp(-(theta(1,1).*X(:,1) + theta(2,1).*X(:,2) + theta(3,1).*X(:,3) + theta(4,1).*X(:,4))));

figure
subplot(2,1,1);
plot([1:1:M],Y, 'x');
title('Target Values');

subplot(2,1,2); 
plot([1:1:M],hX, 'x');
title('Output Values');

clc;
fprintf(" Mean error : %g\n", mean(errorFunc));
fprintf(" Max iteration reached : %d\n", iter);

