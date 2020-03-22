function res=predictions(rniz,k)
original=rniz;
calibration=rniz(1:(floor(0.8*size(rniz,1)/1000))*1000);
validation=rniz((floor(0.8*size(rniz,1)/1000))*1000+1:size(rniz,1));
%---------------------------- adf test i diferenciranje nestacione serije ------------------------------------------------------
s=0; % brojac diferenciranja
slas=calibration;
for p=1:2 
    if adftest(slas)==0 %H0 nestacionarna serija, test vraca 0 ako ne moze da se odbaci H0, tj 1 ako se odbacuje
    slas=deltas(slas,1);
    s=s+1;
    end
end
if s<2
    disp(['Kalibraciona serija je reda stacionarnosti i(', num2str(s),').'])
end
if s==2
    disp('Kalibraciona serija ima vise od jednog jedinicnog korena, program je predvidjen za stacionarne serije ili serija sa jednim jedininim korenom')
    return
end

l=0;% brojac diferenciranja
slasorigin=original;
for o=1:2 
    if adftest(slasorigin)==0 %H0 nestacionarna serija, test vraca 0 ako ne moze da se odbaci H0, tj 1 ako se odbacuje
    slasorigin=deltas(slasorigin,1);
    l=l+1;
    end
end
if l<2
    disp(['Cela serija je reda stacionarnosti i(', num2str(l),').'])
end
if l==2
    disp('Cela serija ima vise od jednog jedinicnog korena, program je predvidjen za stacionarne serije ili serija sa jednim jedininim korenom')
    return
end
%---------------------------- ispitivanje autokorelacije ------------------------------------------------------------------------
m=ceil(log(size(slas,1))); %dokle najdalje proveravamo autokorelaciju
alfa=0.05;
autocorel=tratio(slas,m,alfa);
pmax=0;%p max poslednji stat znacajan koji treba ispitati.
for i=1:m
    if autocorel(5,i)==1
        pmax=i;
    end
end
disp(['Max red modela koji ispitujemo je ', num2str(pmax)])
%---------------------------- odredjivanje reda modela --------------------------------------------------------------------------
%-------------------------in sample and out off sample metodom ------------------------------------------------------------------
valsize=size(validation,1); % duzina validacionog uzorka,da znamo koliko nam treba predikcija
predikcije=[];
adekvatni=[];
for p=1:pmax
    xzfinal=ARocenakoef1(slas,p); %ocenjujemo koef za sve p od 1 do pmax
    disp(['Koef modela reda ',num2str(p),' su:'])
    disp(xzfinal')
    [boxtest at]=adekvatnostAR1(slas,xzfinal); % za svaki ocenjeni model proveravamo adekvatnost
    %ad=basicstat(at,0.05);
    if boxtest(3)<=boxtest(4) % reziduali su nekorelisani
        adekvatni=[adekvatni,p];
        predikcije=[predikcije,kpredikcijeAR(slas,xzfinal,p,valsize)];
        disp('Reziduali su nezavisni')
    else
        disp('Postoji autokorelacija u rezidualima')
    end
end
predikcijes=[]; 
if s>0
    for u=1:size(predikcije,2)
        predikcijes=[predikcijes ,delta1(predikcije(:,u),calibration)]; %ako smo radili diferencirnje odmotavamo predikcije
    end
else 
    predikcijes=predikcije; %ako je serija inicijalno stacionarna predikcije smo vec izracunali
end
if size(predikcijes)==[0,0]
    poruka = ['Ni jedan model reda <=',num2str(pmax),' nije adekvatan.'];
    disp(poruka)
    return
end
p=poredjenje(predikcijes,validation); %biramo red modela koji daje najmanju relativnu gresku na validacionom uzorku
p=adekvatni(p);
disp(['Odabrani red modela koji ispitujemo je ', num2str(p)])
%---------------------------------------------------------------------------------------------------------------------------------
xzfinal=ARocenakoef1(slas,p); %ponovo ocenjujemo koeficijente ali sada samo za izabrani red modela p
disp(['Koeficijenti ocenjenog modela su :'])
disp(xzfinal')
knovihpredikcija=kpredikcijeAR(slasorigin,xzfinal,p,k);% pravimo predikcije ovaj put pocevsi od poslednjeg poznatog podatka koji se nalazi u validacionom uzorku
kkonacnepredikcije=[]; 
if l>0
    for u=1:size(knovihpredikcija,2)
        kkonacnepredikcije=[predikcijes ,delta1(knovihpredikcija(:,u),original)]; %ako smo radili diferencirnje odmotavamo predikcije
    end
else 
    kkonacnepredikcije=knovihpredikcija; %ako je serija inicijalno stacionarna predikcije smo vec izracunali
end
res=kkonacnepredikcije;