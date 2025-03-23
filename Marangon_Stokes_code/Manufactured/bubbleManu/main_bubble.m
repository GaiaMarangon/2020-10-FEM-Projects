clear all, close all, clc

% MESH
meshdir='mesh2';

% LOAD INPUT DATA
[nnodes,nelem,coord,triang,dirnod,dirval,u1_ex,u2_ex,p_ex,funct1,funct2,functg,ci,mu]=inputData(meshdir);

% COMPUTE LOCAL VALUES (basis funct coefficients and others)
[aLoc,bLoc,cLoc,elemArea,nodalArea,bary]=localBasis(nnodes,nelem,coord,triang);

% BUILD GLOBAL MATRIX
[globMat]=globBuild(nnodes,nelem,triang,bLoc,cLoc,elemArea,ci,mu);

% BUILD GLOBAL RHS
[globRhs]=rhsBuild(nnodes,nelem,triang,bary,elemArea,funct1,funct2,functg);


% IMPOSE BCs
[globMat,globRhs]=imposeBC(nnodes,nelem,nodalArea,dirnod,dirval,globMat,globRhs);

% SOLVE SYSTEM
[u1_num,u2_num,p_num]=solveSys(nnodes,nelem,dirnod,dirval,globMat,globRhs);



% PLOT SOLUTIONS
plotSol(nnodes,coord,triang,u1_ex,u2_ex,p_ex,u1_num,u2_num,p_num);

% TEST ERROR 
fprintf('\nBubble:\n');
testError(nnodes,coord,u1_ex,u2_ex,p_ex,u1_num,u2_num,p_num);
