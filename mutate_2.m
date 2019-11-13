function [mutated,mutatedbinno]=mutate_2(chromosome,chromindex,binsize,items,fitnesses,BinNo,k,mutratio,itemno)
mutated=cell(1);
mutatedbinno=0;
mutno=floor(BinNo*mutratio);
filled=zeros(BinNo,1);
for i=1:BinNo
    filled(i)=sum(items(chromosome{chromindex,i}));
end

indices=zeros(mutno,1);
for i=1:mutno
    [m,iii]=min(filled);
    indices(i)=iii;
    filled(iii)=binsize;
end

index=1;
for i=1:BinNo
    if(~sum(ismember(indices,i)))
        mutated{index}=chromosome{chromindex,i};
        index=index+1;
    end
end
index=index-1;
% start=randi(BinNo+1-mutno);
% index=1;
% for i=1:start-1
%     mutated{index}=chromosome{chromindex,i};
%     index=index+1;
% end
% for i=start+mutno:BinNo
%     mutated{index}=chromosome{chromindex,i};
%     index=index+1;
% end
% index=index-1;

%% Calculating Leftouts
elements=[];
    for i=1:index
        elements=[elements,mutated{i}];
    end
    all=1:itemno;
    leftouts=~ismember(all,elements);
    leftouts=all(leftouts);
    ls=size(leftouts,2);
    %% Assigning Leftouts
    for i=1:ls
        notassigned=true;
        j=1;
        while(notassigned && j<=index)
            if(sum(items(mutated{j}))+items(leftouts(i))<=binsize)
                mutated{j}=[mutated{j},leftouts(i)];
                notassigned=false;
            else
                j=j+1;
            end
        end
        if(notassigned)
            mutated{index+1}=leftouts(i);
            index=index+1;
        end
    end

mutatedbinno=index;

end