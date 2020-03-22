function res=tmatrica(rniz,p)
res=[];
T=size(rniz,1);
for i=1:p
    res=[res rniz(i:i+T-p-1)];
end
res=[res ones(T-p,1)];
end