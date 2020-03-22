function res=ALGO2(dmk,pkmin,pk,ekpk,v1,mi,vark,N) 
%pk uzima vrednosti iz diskretnog skupa P=[pi1,....,pim] gde 0<pi1<...<pim
Pskup=1/1000:1/1000:1;
%m<=N uzeli smo da je m=1000
%uslov pk+1>=pkmin
%------------------------------------s1----------------------------------------------------
if(pk<pkmin)
    podskup=[];
    for j=1:1000
        if Pskup(j)>=pkmin
            podskup=[podskup,Pskup(j)];
        end
    end
    pknew=min(podskup); %min elemnt vektora mogucih verovatnoca
else 
%------------------------------------s2----------------------------------------------------
%1)
    if dmk==ekpk
    pknew=pk;
    else
%2)
    if  dmk>ekpk
        podskup1=[];
            for j=1:1000
                if Pskup(j)<=pk && Pskup(j)>=pkmin && dmk<=mi*(sqrt(vark))/sqrt(Pskup(j)*N)
                    podskup1=[podskup1,Pskup(j)];
                end
            end
            if length(podskup1)>0
                pknew=max(podskup1);
            else
                podskup2=[];
                    for j=1:1000
                        if Pskup(j)>=pkmin
                        podskup2=[podskup2,Pskup(j)];
                        end
                    end
                pknew=min(podskup2);
            end
    end
%3)
    if dmk<ekpk %i)
        if dmk>=v1*ekpk
            podskup3=[];
            for j=1:1000
                if Pskup(j)>=pk && dmk>=mi*(sqrt(vark))/sqrt(Pskup(j)*N)
                podskup3=[podskup3,Pskup(j)];
                end
            end
            if length(podskup3)>=0
                pknew=min(podskup3);
            else
                pknew=1;
            end
        else %ii)
            pknew=1;
        end
    end
    end
end
res=pknew;
