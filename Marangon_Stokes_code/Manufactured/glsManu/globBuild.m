function [globMat]=globBuild(nnodes,const,mu,...
                   stiffMat,massMat,diverMat1,diverMat2)

globMat = [ const*massMat+mu*stiffMat, zeros(nnodes,nnodes), diverMat1';
            zeros(nnodes,nnodes), const*massMat+mu*stiffMat, diverMat2';
            diverMat1,            diverMat2,        zeros(nnodes,nnodes)];    

end