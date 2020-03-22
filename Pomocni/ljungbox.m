function res=ljungbox(rniz,m,alfa,g)
%disp('H0 (ro_1=...=ro_m=0)')
%disp('(Nezavisnost od prethodnih m vrednosti.)')
%chis99=[6.63 9.21 11.34 13.28 15.09 16.81 18.48 20.09 21.66 23.21];
if alfa==0.05
    z=chi2inv(0.95,m-g);
elseif alfa==0.01
    z=chi2inv(0.99,m-g);
else 
%    disp('Mozete izbrati nivo znacajnosti 0.05 ili 0.01.')
end
T=size(rniz,1);
s=0;
for i=1:m
    s=s+((acf(rniz,i))^2)/(T-i);
end
q=T*(T+2)*s;
%if q>z
%    disp('Odbaciti H0')
%   disp('Moguce je da postoji linearna zavisnost sa nekom od prethodnih m vrednosti')
%else
%    disp('Ne postoji linearna zavisnot')
%end
res=[m;alfa;q;z];

