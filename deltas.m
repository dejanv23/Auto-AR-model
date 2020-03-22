function res=deltas(rniz,s)
T=size(rniz,1);
res=[];
for i=s+1:T
    r=rniz(i)-rniz(i-s);
    res=[res;r];
end