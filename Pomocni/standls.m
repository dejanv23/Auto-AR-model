function res=standls(rniz,x)
T=size(rniz,1);
p=size(x,1)-1;
t=tmatrica(rniz,p);
sa2=sigmaa(rniz,x);
m=inv(t'*t)*sa2;
varijanse=diag(m);
res=sqrt(varijanse);