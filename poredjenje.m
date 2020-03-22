function res=poredjenje(P,stvarne)
% %Prosecna relativna greska
% m=size(P,2);
% c=mean(abs((P(:,1)-stvarne)./stvarne));
% kriterijum=[c];
% res=1;
% for i=2:m
%     cn=mean(abs((P(:,i)-stvarne)./stvarne));
%     kriterijum=[kriterijum;cn];
%     if cn<c
%         res=i;
%         c=cn;
%     end
%     
% end

% %Maksimalna relativna greska
% m=size(P,2);
% c=max(abs((P(:,1)-stvarne)./stvarne));
% kriterijum=[c];
% res=1;
% for i=2:m
%     cn=max(abs((P(:,i)-stvarne)./stvarne));
%     kriterijum=[kriterijum;cn];
%     if cn<c
%         res=i;
%         c=cn;
%     end
%     
% end

%Procenat relativne greske manje od t, npr. t=3%
t=0.03;

m=size(P,2);
rel=abs((P(:,1)-stvarne)./stvarne);
c=mean(rel<t);
kriterijum=[c];
res=1;
for i=2:m
    rel=abs((P(:,i)-stvarne)./stvarne);
    cn=mean(rel<t);
    kriterijum=[kriterijum;cn];
    %Ovde trazimo sto vecu vrednost
    if cn>c
        res=i;
        c=cn;
    end
    
end
