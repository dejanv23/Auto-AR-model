function res=fnk(x,N,borders,t,a,y)
niz=[];
for i=1:N
    if a(i)==1 %ako je radnik aktivan
        %for
            j=borders(i):borders(i+1)-1;
            niz=[niz;Fls(x,t(j,:),y(j))];%RADIMO UPDATE MATRICE SA GRADIJENTIMA, NEAKTIVNI IMAJU NULU
        %end
    end
end
res=0.5*sum(niz.^2);
