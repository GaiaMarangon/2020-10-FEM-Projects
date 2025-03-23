function [globMat,globRhs]=imposeBC(nnodes,ndir,dirNod,dirVal,nodalArea,globMat,globRhs)

penalty=1e10;       %1e40;


for block=1:3
    for i=1:ndir
        iblock = dirNod(i);
        iglob = (block-1)*nnodes + iblock;
        globMat(iglob,iglob)=penalty;
        globRhs(iglob)=penalty * dirVal(i,block);
    end    
end


%----MEAN ZERO CONSTRAINT---------
globRhs=[globRhs; 0];
newblock=[ zeros(1,2*nnodes), nodalArea' ];
globMat=[globMat,   newblock';
         newblock,  0        ];
%----MEAN ZERO CONSTRAINT---------




end