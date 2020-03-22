function res=ARocenakoef1(rniz,pz)
%Red modela
T=size(rniz,1);
m=ceil(log(T)); %zakucali
%pz=PACF1(rniz,alfa,lambda,eps,m);
%Odredjivanje koeficijenata
resm=ARocena1(rniz,pz);
res=resm(4,:)';