binsize=120;
minsize=20;
maxsize=100;
itemno=120;
k=2;
fitness1=zeros(5,1);
Ekhtelafe1=zeros(5,1);
fitness3=zeros(5,1);
Ekhtelafe3=zeros(5,1);
fitness4=zeros(5,1);
Ekhtelafe4=zeros(5,1);
fitness5=zeros(5,1);
Ekhtelafe5=zeros(5,1);
% fitness1=zeros(5,1);
% Ekhtelafe1=zeros(5,1);
for i=1:5
items=randi(maxsize-minsize,1,itemno)+minsize;
[fitness1(i),Ekhtelafe1(i)]=GGA(items);
[fitness3(i),Ekhtelafe3(i)]=GGA3(items);
[fitness4(i),Ekhtelafe4(i)]=GGA4(items);
[fitness5(i),Ekhtelafe5(i)]=GGA5(items);
end
% a=GGA2(items);
disp('GGA1:');
disp(mean(fitness1))
disp(mean(Ekhtelafe1));
disp('GGA3:');
disp(mean(fitness3));
disp(mean(Ekhtelafe3));
disp('GGA4:');
disp(mean(fitness4));
disp(mean(Ekhtelafe4));
disp('GGA5:');
disp(mean(fitness5));
disp(mean(Ekhtelafe5));