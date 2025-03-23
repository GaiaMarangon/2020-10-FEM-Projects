function [globMat,rhs]=imposeBC(nnodes,dirnod,dirval,nodalArea,globMat,rhs)


%-----------STANDARD METHOD--------------------------------
ndir=size(dirnod,1);
for iblock=1:3
for iloc=1:ndir
    iglob=(iblock-1)*nnodes + dirnod(iloc);
    rhs = rhs - globMat(:,iglob)*dirval(iloc,iblock);
    globMat(:,iglob)=zeros(3*nnodes,1);
    globMat(iglob,:)=zeros(3*nnodes,1)';
    globMat(iglob,iglob)=1;
end
end

for iblock=1:3
for iloc=1:ndir
    iglob=(iblock-1)*nnodes + dirnod(iloc);
    rhs(iglob)= dirval(iloc,iblock);
end
end
%-----------STANDARD METHOD--------------------------------

%{
%-----------PENALTY----------------------------------------
penalty=1e10;       
ndir=size(dirnod,1);
for block=1:3
    for i=1:ndir
        iblock = dirnod(i);
        iglob = (block-1)*nnodes + iblock;
        globMat(iglob,iglob)=penalty;
        rhs(iglob)=penalty * dirval(i,block);
    end    
end
%-----------PENALTY----------------------------------------
%}


%----PRESSURE, MEAN ZERO---------
rhs=[rhs; 0];
newblock=[ zeros(1,2*nnodes), nodalArea' ];
globMat=[globMat,   newblock';
         newblock,  0        ];
%----PRESSURE, MEAN ZERO---------


end