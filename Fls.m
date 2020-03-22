function res=Fls(x,t,y)
m=size(t,1);
r=[];
for i=1:m
    r=[r;fi(x,t(i,:))-y(i)];
end
res=r;