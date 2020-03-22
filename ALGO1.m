function [pm,Fknew]=ALGO1(pk,pk1,fNk1,pkmin,tetak,gamak,Fk)
%updateing pk-min
%-------------------------------s1------------------------------------------------
    if(pk<pk1 && Fk-fNk1<tetak);
        pm=min(1,pkmin+gamak);
    else
        pm=pkmin;
    end
    if pk<pk1;
        Fknew=min(fNk1,Fk);
    else
        Fknew=Fk;
    end
end