function [globMat]=globBuildStab(nnodes,const,mu,...
                   stiffMat,massMat,diverMat1,diverMat2,stabMat)

globMat = [ const*massMat+mu*stiffMat, zeros(nnodes,nnodes), diverMat1';
            zeros(nnodes,nnodes), const*massMat+mu*stiffMat, diverMat2';
            diverMat1,            diverMat2,        -stabMat];    

end