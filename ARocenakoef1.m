function res=ARocenakoef1(rniz,pz)
%Red modela je pz
T=size(rniz,1);
%m=ceil(log(T)); %zakucali
%pz=PACF1(rniz,alfa,lambda,eps,m);
resm=ARocena1(rniz,pz);%Odredjivanje koeficijenata
res=resm(4,:)';