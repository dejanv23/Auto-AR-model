function res=kpredikcijeAR(rniz,xzfinal,p,k)
% xzred je dimenzije p+1 i moze imati 0 komponente
% eps=10^(-2);
% lambda=1;
% [xz xzse t y]=ARocena(rniz,eps,lambda,p);
T=size(rniz,1);
%tt=rniz(T-p:T,1);
c=xzfinal(p+1);
%plot(0,rniz(T,1),'bo');
%hold on

if p>0
tt=rniz(T-p+1:T,1);
koef=xzfinal(1:p);


nizpred=[];
for i=1:k
    %rtk=fi(xzfinal,tt');
     rtk=koef'*tt+c;
    nizpred=[nizpred;rtk];
    tt=[tt;rtk];
    tt(1)=[];
    plot(i,rtk,'g*');
    hold on
end

else
nizpred=c*ones(k,1);
%plot(nizpred,'g*');
end
res=nizpred;