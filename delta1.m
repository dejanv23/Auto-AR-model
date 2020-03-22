function res=delta1(predfinal,yniz)
k=size(predfinal,1);
T=size(yniz,1);
y=yniz(T);
res=[];
for i=1:k
    y=predfinal(i)+y; %iterativno u svakom koraku uzima poslednju vrednost i lepi predikciju
    res=[res;y];
end