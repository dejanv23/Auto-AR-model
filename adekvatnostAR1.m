function [res at]=adekvatnostAR1(rniz,x)
T=size(rniz,1);
p=size(x,1)-1;
t=tmatrica(rniz,p);
pred=Fm(x,t);
y=rniz(p+1:T,1);
at=y-pred;
m=ceil(log(T));
g=sum(abs(sign(x)));
res=ljungbox(at,m,0.05,g);
end


