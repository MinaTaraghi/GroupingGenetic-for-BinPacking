function chromosome=invert_2(chromosome,chromindex,BinNo,items,binsize)

filled=zeros(BinNo,1);
for i=1:BinNo
    filled(i)=sum(items(chromosome{chromindex,i}));
end

indices=zeros(2,1);
for i=1:2
    [m,iii]=max(filled);
    indices(i)=iii;
    filled(iii)=0;
end

one=indices(1);
two=indices(2);
% one=randi(BinNo);
% two=randi(BinNo);
% while(one==two)
%     two=randi(BinNo);
% end
if(abs(one-two)~=1)
imin=min(one,two);
imax=max(one,two);
temp=chromosome{chromindex,imin+1};
chromosome{chromindex,imin+1}=chromosome{chromindex,imax};
chromosome{chromindex,imax}=temp;
end
end