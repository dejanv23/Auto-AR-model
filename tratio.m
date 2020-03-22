function res=tratio(rniz,m,alfa)
T=size(rniz,1);
y=acfgraf(rniz,m);
s=1;
se=sqrt((1+2*s)/T);
ster=[se];
tr=y(1)/se;
tniz=[tr];
for i=2:m
    s=s+y(i-1)^2;
    se=sqrt((1+2*s)/T);
    ster=[ster;se];
    tr=y(i)/se;
    tniz=[tniz;tr];
end
z=-norminv(alfa/2,0,1);
hip=zeros(m,1);
for j=1:m
    if abs(tniz(j,1))>z
        %hold on
        %plot(j,y(j,1),'ro');
        hip(j)=1;
    end
end
res=[[1:m];y';ster';tniz';hip'];
