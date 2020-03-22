function res=sigmaa(rniz,x)
T=size(rniz,1);
p=size(x,1)-1;
res=flsAR1(rniz,x)*2/(T-2*p-1);