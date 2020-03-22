function res=flsAR1(rniz,x)
T=size(rniz,1);
p=size(x,1)-1;
t=tmatrica(rniz,p);
pred=Fm(x,t);
y=rniz(p+1:T,1);
res=0.5*norm(pred-y)^2;