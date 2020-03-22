function res=ARocena1(rniz,p)
x0=zeros(p+1,1);
p0min=0.1; %1
beta=0.5;
psi=0.0001;
xz=Algo3(rniz,p0min,x0,beta,psi);
res=[xz'];
se=standls(rniz,xz);
res=[res;se'];
test=abs(xz./se);
hip=[];
for i=1:p+1
    if test(i)<=1.96
        hip=[hip;0];
    else
        hip=[hip;1];
    end
end
res=[res;hip'];
xzfinal=xz.*hip;
res=[res;xzfinal'];