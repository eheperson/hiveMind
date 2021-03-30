clc;
clear all;
close all;
%% Problem definition
%
costF = @(x) sphere(x);
%
nVar = 5;
%
varMax = 10;
varMin = -varMax;
varSize = [1 nVar];
%
%% ABC Settings 
%
iterMax = 1000;
nPop = 10;
nlookerpop=nPop;
a = 1;
%
% iyilesme olmuyor ise optimizasyona ne kadar devam edilsin
% Abandonment limit parameter
% Normalde >> L = nPop*nVar; 
L = round(0.5*nPop*nVar); 
%

%% Initialization
%
% Swarm structure
beeSwarm.position = [];
beeSwarm.cost = [];
%
pop = repmat(beeSwarm, nPop,1);
bestSolution.cost = inf;
%
%% SCOUT BEE PHASE
for i=1:nPop
    pop(i).position = unifrnd(varMin, varMax, varSize);
    pop(i).cost = costF(pop(i).position);
    if pop(i).cost<=bestSolution.cost
        bestSolution.cost = pop(i).cost
    end
end

bestCosts = zeros(iterMax, 1);
C = zeros(nPop,1);
%% ABC MAIN LOOP
for j=1:iterMax
    
    %employed bees
    for i = 1 : nPop
        k = [1 : i-1 i+a : nPop];
        k = k(randi([1 numel(k)]));
        phi = unifrnd(-a,a,varSize);

        newBee.position = pop(i).position + phi.*(pop(i).position - pop(k).position);
        newBee.cost = costF(newBee.position);
        
        if newBee.cost <= pop(i).cost
           pop(i).cost = newBee.cost;
        else
            C(i) = C(i) + 1;
        end
    end
    
    % Calculate fitness values and selection probabilities
    F=zeros(nPop,1);
    for i=1:nPop
        if pop(i).cost>=0
              F(i)=1/(1+pop(i).cost);
        else
             F(i)=1+abs(pop(i).cost);
            
        end
    end
    P=F/sum(F);
    
    % Onlooker bees
    for m=1:nlookerpop
        
        % Select Source site
        i=RouletteWheelselection(P);
         k=[1:i-1 i+1:nPop];
              k=k(randi([1  numel(k)]));
              phi=unifrnd(-a,a,varSize);
    
             newbee.position=pop(i).position+phi.*(pop(i).position-pop(k).position);
                 newbee.cost=costF(newbee.position);
       if newbee.cost<=pop(i).cost
          pop(i)=newbee;
       else
        C(i)=C(i)+1;
       end
      
    end
    
    % Scout bees
    for i=1:nPop
        if C(i)>=L
        	pop(i).position=unifrnd(varMin,varMax,varSize);    
        	pop(i).cost=costF(pop(i).position); 
            C(i)=0;
        end
    end
    for i=1:nPop
        if pop(i).cost<=bestSolution.cost
            bestSolution=pop(i);
        end
      
    end
    BestCost(j)=bestSolution.cost;
    disp(['Iteration ' num2str(j)   ':BestCost='  num2str(BestCost(j))]);
end

%% plot
figure;
semilogy(BestCost);
xlabel('Iteration');
ylabel('Best cost');
