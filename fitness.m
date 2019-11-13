function f=fitness(chrom,chromindex,binsize,k,binno,items)
f=0;
for i=1:binno
    f=f+(sum(items(chrom{chromindex,i}))/binsize)^k;
end
f=f/binno;
end