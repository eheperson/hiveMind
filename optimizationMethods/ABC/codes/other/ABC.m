clc;
clear;
close all;
%% Problem Definition

costfunction=@(x) sphere(x)

nVar=5;

VarMin=-10;
VarMax=10;
Varsize=[1 nVar];
%% ABC settings
Maxit=200;
nPop=50;
L=round(0.5*nPop*nVar);           %Abandonment limit parameter
nlookerpop=nPop;
a=1;
%% initilaization

% Empty bee structure
emty_bee.position=[];
emty_bee.cost=[];

pop=repmat(emty_bee,nPop,1);
Bestsol.cost=inf;
for i=1:nPop
    
pop(i).position=unifrnd(VarMin,VarMax,Varsize);    
pop(i).cost=costfunction(pop(i).position);   
if pop(i).cost<=Bestsol.cost
    Bestsol=pop(i);
end
    
end

BestCost=zeros(Maxit,1);
C=zeros(nPop,1);
%% ABC main loop
for it=1:Maxit
    
    % employed bees
    for i=1:nPop
    k=[1:i-1 i+1:nPop];
    k=k(randi([1  numel(k)]));
    phi=unifrnd(-a,a,Varsize);
    
    newbee.position=pop(i).position+phi.*(pop(i).position-pop(k).position);
    newbee.cost=costfunction(newbee.position);
    if newbee.cost<=pop(i).cost
    pop(i)=newbee;
    else
        C(i)=C(i)+1;
    end
    end
    
    % calculate Fitness Values and selection probabilities
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
              phi=unifrnd(-a,a,Varsize);
    
             newbee.position=pop(i).position+phi.*(pop(i).position-pop(k).position);
                 newbee.cost=costfunction(newbee.position);
       if newbee.cost<=pop(i).cost
          pop(i)=newbee;
       else
        C(i)=C(i)+1;
       end
      
    end
    
  % Scout bees
  for i=1:nPop
      if C(i)>=L
           pop(i).position=unifrnd(VarMin,VarMax,Varsize);    
           pop(i).cost=costfunction(pop(i).position); 
          C(i)=0;
      end
  end
  for i=1:nPop
      if pop(i).cost<=Bestsol.cost
          Bestsol=pop(i);
      end
      
  end
  BestCost(it)=Bestsol.cost;
  disp(['Iteration ' num2str(it)   ':BestCost='  num2str(BestCost(it))]);
  
end

%% plot
figure;
semilogy(BestCost);
xlabel('Iteration');
ylabel('Best cost');

















