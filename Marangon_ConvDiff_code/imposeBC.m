function [globMat,globRhs]=imposeBC(nnodes,ndir,dirNod,dirVal,globMat,globRhs)

%{
%-----------PENALTY METHOD--------------
penalty=1e10;       %1e40;

for iloc=1:ndir
    iglob=dirNod(iloc);
    globMat(iglob,iglob)=penalty;
    globRhs(iglob)=penalty * dirVal(iloc);  
end
%-----------PENALTY METHOD--------------
%}


%-----------STANDARD METHOD--------------
for iloc=1:ndir
    iglob=dirNod(iloc);
    globRhs = globRhs - globMat(:,iglob)*dirVal(iloc);
    globMat(:,iglob)=zeros(nnodes,1);
    globMat(iglob,:)=zeros(nnodes,1)';
    globMat(iglob,iglob)=1;
end

for iloc=1:ndir
    iglob= dirNod(iloc);
    globRhs(iglob)= dirVal(iloc);
end
%-----------STANDARD METHOD--------------


end