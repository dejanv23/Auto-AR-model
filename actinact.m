function res=actinact(N,p) 
r=[];
for i=1:N
    r=[r;binornd(1,p)]; %%simulacija odlucivanja radnika, da li ce biti aktivan ili ne
end
res=r;
end