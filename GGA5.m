%clear;
function [f,e]=GGA5(items)
binsize=120;
minsize=20;
maxsize=100;
itemno=120;
k=2;

meanfitness=zeros(100,1);
maxfitness=zeros(100,1);
minfitness=zeros(100,1);
mutratio=0.1;

popsize=100;
parentssize=floor(popsize/2);
mutpopsize=floor(popsize/3);
invpopsize=floor(popsize/4);

%items=randi(maxsize-minsize,1,itemno)+minsize;

Theo=ceil(sum(items)/binsize);

itemindex=1:itemno;
%% creating Initial Population

chromosome=cell(popsize,1);
BinNo=zeros(popsize,1);

for ch_index=1:popsize
iindex=2;
bindex=1;
permu=randperm(itemno);
itemscc=items(permu);
summ=itemscc(1);
chromosome{ch_index,bindex}=[permu(1)];
% creating a new chromosome...going through all items
while(iindex<=itemno)
    % assigning item iindex
    if(summ+itemscc(iindex)<=binsize) % Current Bin can accomodate
        if(summ==0)
            chromosome{ch_index,bindex}=permu(iindex);
        else
            chromosome{ch_index,bindex}=[chromosome{ch_index,bindex},permu(iindex)];
        end
    summ=summ+itemscc(iindex);
    
    % going to next item
    iindex=iindex+1;
    else % Picking a new bin
        bindex=bindex+1;
        summ=0;
    end
end
BinNo(ch_index)=bindex;
end

fitnesses=zeros(popsize,1);
for i=1:popsize
    fitnesses(i)=fitness(chromosome,i,binsize,k,BinNo(i),items);
end
for Q=1:100
%% Parents' Selection
parents=cell(parentssize,1);
parentfitness=zeros(parentssize,1);
parentsBinNo=zeros(parentssize,1);
for i=1:parentssize
    j=randi(popsize,1,2);
    if (fitnesses(j(1))>=fitnesses(j(2)))
        for kk=1:BinNo(j(1))
            parents{i,kk}=chromosome{j(1),kk};
        end
        parentfitness(i)=fitnesses(j(1));
        parentsBinNo(i)=BinNo(j(1));
    else
        for kk=1:BinNo(j(2))
            parents{i,kk}=chromosome{j(2),kk};
        end
        parentfitness(i)=fitnesses(j(2));
        parentsBinNo(i)=BinNo(j(2));
    end
end

%% Crossover
[offspring,OffBinNo]=crossover(parents,parentfitness,parentssize,parentsBinNo,itemno,binsize,items);


offspringfitness=zeros(parentssize,1);
for i=1:parentssize
    offspringfitness(i)=fitness(offspring,i,binsize,k,OffBinNo(i),items);
end
%% Replacing Randomly
indices=randperm(popsize);
for i=1:parentssize
    for j=1:OffBinNo(i)
        chromosome{indices(i),j}=offspring{i,j};
    end
    for j=OffBinNo(i)+1:BinNo(indices(i))
        chromosome{indices(i),j}=[];
    end
    BinNo(indices(i))=OffBinNo(i);
    fitnesses(indices(i))=offspringfitness(i);
end

%% Mutation
indices=randperm(popsize);
for i=1:mutpopsize
    [mutated,mutatedbinno]=mutate(chromosome,indices(i),binsize,items,fitnesses,BinNo(indices(i)),k,mutratio,itemno);
    for j=1:mutatedbinno
        chromosome{indices(i),j}=mutated{j};
    end
    for j=mutatedbinno+1:BinNo(indices(i))
        chromosome{indices(i)}=[];
    end
    BinNo(indices(i))=mutatedbinno;
    mutfitness=fitness(mutated,1,binsize,k,mutatedbinno,items);
    fitnesses(indices(i))=mutfitness;
end

%% Inversion
indices=randperm(popsize);
for i=1:invpopsize
    chromosome=invert_2(chromosome,indices(i),BinNo(indices(i)),items,binsize);
end
meanfitness(Q)=mean(fitnesses);
maxfitness(Q)=max(fitnesses);
minfitness(Q)=min(fitnesses);
end
plot(meanfitness);
title('GGA5');
hold
plot(maxfitness);
plot(minfitness);
hold
legend('mean','max','min');
disp(mean(OffBinNo));
disp(mean(parentsBinNo));
disp(mean(BinNo));
disp('*******************');
disp(mean(offspringfitness));
disp(mean(parentfitness));
disp(mean(fitnesses));
disp('*******************');
disp('GGA5:');
disp(max(maxfitness));
disp(min(BinNo));
disp(Theo);
disp('End');
f=max(maxfitness);
e=min(BinNo)-Theo;
end