function res=Algo3(rniz,p0min,x0,beta,psi) %Algo3(rniz,p0min,x0,beta,v1,psi)
%--------------------------------------------------s1)--------------------------------------------------------------------------
p0=p0min; %p0min=0.1 
x=x0; %pocetna vrednost resenja
n=size(x0,1); 
p=n-1; %gledamo koji je red modela zadat-p
N=1000; %broj radnika zakucan
L=size(rniz,1);
y=rniz(n:L);
t=[];
for i=n:L %pravim tm matricu
    ti=[];
    for j=0:(p-1)
        ti=[ti rniz(i-p+j)];
    end
    t=[t;[ti 1]];
end
step= floor(size(t,1)/1000);
borders=1:step:step*1000+1;%size(t,1); %delimo seriju najmanjih kvadrata na 1000 delova
if borders(length(borders))~=size(t,1)+1
    borders(length(borders))=size(t,1)+1; %ovo sam promenio, ako nije deljiva duzina sa N, granicu 1000 cvora staviti na kraj
end
%-------------------------------------------s2)----------------------------------------------------------------------------------
a=actinact(N,p0);
FEV=sum(a)+sum(n*a);
braktivnihrad=[sum(a)];
%disp(['Br aktivnih radnika je', num2str(sum(a))])
pvalues=[p0];
pminvalues=[p0];
xmat=[];
for i=1:N %punim matricu dostavljenim podacima od aktivnih radnika, svaki radnik ima svoju vrstu
    if a(i)==1 %ako je radnik aktivan upisujemo njegove gradijente i vrednosti funkcija
       % for 
           j=borders(i):borders(i+1)-1;
           xmat=[xmat;[Fls(x,t(j,:),y(j)),t(j,:)]];%RADIMO UPDATE MATRICE SA GRADIJENTIMA, NEAKTIVNI IMAJU NULU
        %end
    end
end
%--------------------------------------------------------------------------------------------------------------------------------
B=eye(p+1); %pocetna aproksimacija hesijana
Fk=inf(1,1000);
k=0;
Nk=sum(a);
%---------------------------------- vrtimo iteracije dok ne zadovoljimo uslove --------------------------------------------------
while 1 %Nk<N && norm(xmat(:,2:size(xmat,2))'*xmat(:,1))>=0.01  %norm(Jls(x,t,y)'*Fls(x,t,y))>=0.01
 %------------------------------------------s3)---------------------------------------------------------------------------------- 
    %negativnigradijent
    %dk=-xmat(:,2:size(xmat,2))'*xmat(:,1); %negativnigradijent
    %-------------------------BFGS-----------------------------------------------------------------------------------------------
    dk=-B*(xmat(:,2:size(xmat,2))'*xmat(:,1));
    %----------------------------s4)Step size with Armijo-type rule -------------------------------------------------------------
    %Step size with Armijo-type rule str9
    m=0;
    alfak=beta^m;
    ek=0.1;
    while fnk(x+alfak*dk,N,borders,t,a,y)>(fnk(x,N,borders,t,a,y)+psi*alfak*(dk'*(xmat(:,2:size(xmat,2))'*xmat(:,1)))+ek)
        m=m+1;
        alfak=beta^m;
        ek=ek*m^(-1.1);
    end
    sk=m;
    alfak=beta^sk;
    %----------------------------------------------------------------s5)----------------------------------------------------------
    xold=x; %cuvam staro x za update B za BFGS
    x=x+alfak*dk;
    %dmk=-alfak*dk'*-dk; %kad je negativni gradijent dk
    dmk=-alfak*dk'*(xmat(:,2:size(xmat,2))'*xmat(:,1));
    
    %---------------------------------------------------------s6)Algoritam2 ------------------------------------------------------
    %----------------------------------------------------------------ek(pk)------------------------------------------------------
    mi=3.2; %3.2;videti koja je vrednost konstante
    vark=(1/sum(a))*sum((xmat(:,1).^2-(1/sum(a))*sum(xmat(:,1).^2)).^2);
    pk=pvalues(length(pvalues));%poslednje koriceno p
    ekpk=mi*(sqrt(vark))/sqrt(pk*N);
    v1=1/sqrt(N); %ovo cemo proslediti
    pkmin=pminvalues(length(pminvalues));%poslednje koriceno pkmin
    pknew=ALGO2(dmk,pkmin,pk,ekpk,v1,mi,vark,N); %mi,vark,N zbog racunanja epsilon od pi-ova
    pvalues=[pvalues,pknew];%dodajemo novo p
    %-----------------------------------------------------------------s7)---------------------------------------------------------
    if pk~=pknew;
        a=actinact(N,pknew);
        Nk=sum(a);
        braktivnihrad=[braktivnihrad,Nk];
    end
    FEV=FEV+sum(a)+sum(n*a);
    braktivnihrad;
    %disp(['Br aktivnih radnika je ', num2str(sum(a))])
    %-----------------------------------------------------------------s8)---------------------------------------------------------
    xmatnew=[];
    for i=1:N
        if a(i)==1 %ako je radnik aktivan
            %for 
            j=borders(i):borders(i+1)-1;
            xmatnew=[xmatnew;[Fls(x,t(j,:),y(j)),t(j,:)]];%RADIMO UPDATE MATRICE SA GRADIJENTIMA
            %end
        end
    end
    if ismember(pknew,pvalues(1:end-1)) %proveravamo da li se pk+1 koristi prvi put
    %-----------------------------------------------------------------s9)--------------------------------------------------------
    pkmin=pminvalues(length(pminvalues));
    tetak=(k+1)*pk;
    gamak=(N*exp(1/k))^(-1);
    fNk1=fnk(x,N,borders,t,a,y);
    [pkmin,Fknew]=ALGO1(pk,pknew,fNk1,pkmin,tetak,gamak,Fk(ceil(pknew*1000)));
    pminvalues=[pminvalues,pkmin];
    Fk(ceil(pknew*1000))=Fknew;
    end
    %---------------------------------update B za L-BFGS---------------------------------------------------------------------------
    q=x-xold; %|
    g=xmatnew(:,2:size(xmatnew,2))'*xmatnew(:,1)-xmat(:,2:size(xmat,2))'*xmat(:,1); %|
    if g*q'> 10^-8
    B=B+(q'*g+g'*B*g)*(q*q')/((q'*g)^2)-(B*g*q'+q*g'*B)/(q'*g); %sklonio sam ' sa q*g jer vec stoje tako
    end
    %----------------------------------------------------------------------------------------------------------------------------
    xmat=xmatnew;
    k=k+1;
    norm(xmat(:,2:size(xmat,2))'*xmat(:,1));
   if Nk==N && norm(xmat(:,2:size(xmat,2))'*xmat(:,1))<0.5
       disp(['Vrednost FEV je ', num2str(sum(FEV))])
        break
    end
end
res=x;


