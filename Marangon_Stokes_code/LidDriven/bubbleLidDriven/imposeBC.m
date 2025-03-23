function [globMat,globRhs]=imposeBC(nnodes,nelem,nodalArea,dirnod,dirval,globMat,globRhs)


%-------STANDARD METHOD------------------------------------------
ndir = size(dirnod,1);
for iblock = 1:2        %3
    for iloc=1:ndir
        iglob = dirnod(iloc);
        imat = (iblock-1)*(nnodes+nelem)+iglob;
        globMat(imat,:) = zeros(1,3*nnodes+2*nelem);
        globRhs = globRhs - globMat(:,imat)*dirval(iloc,iblock);
        globMat(:,imat)=zeros(3*nnodes+2*nelem,1);
        globMat(imat,imat)=1;
    end
end


for iblock = 1:2        %3
    for iloc=1:ndir
        iglob = dirnod(iloc);
        imat = (iblock-1)*(nnodes+nelem)+iglob;
        globRhs(imat) = dirval(iloc,iblock);
    end
end
%-------STANDARD METHOD------------------------------------------



%{
%-----------PENALTY----------------------------------------
penalty=1e10;       
ndir=size(dirnod,1);
for block=1:2       %3
    for i=1:ndir
        iblock = dirnod(i);
        iglob = (block-1)*(nelem+nnodes) + iblock;
        globMat(iglob,iglob)=penalty;
        globRhs(iglob)=penalty * dirval(i,block);
    end    
end
%-----------PENALTY----------------------------------------
%}


%----PRESSURE, MEAN ZERO-----------------------------
globRhs=[globRhs; 0];
newblock=[ zeros(1,2*nnodes+2*nelem), nodalArea' ];
globMat=[globMat,   newblock';
         newblock,  0        ];
%----PRESSURE, MEAN ZERO-----------------------------

end