clear all, close all, clc

% INPUT DATA
[nelem,nnodes,ndir,coord,triang,dirNod,dirVal,diff,vel,tau]=inputData();

% COMPUTE LOCAL BASIS
[aLoc,bLoc,cLoc,elemArea]=localBasis(nelem,coord,triang);

% COMPUTE MATRIX (STIFF+TRANSP+STAB)
[globMat,stiffStabMat]=globBuild(nnodes,nelem,coord,triang,bLoc,cLoc,elemArea,diff,vel,tau);

% COMPUTE RHS
globRhs=zeros(nnodes,1);

% IMPOSE BCs
[globMat,globRhs]=imposeBC(nnodes,ndir,dirNod,dirVal,globMat,globRhs);

% SOLVE SYSTEM
[u_num]=solveSys(nnodes,ndir,dirNod,dirVal,globMat,globRhs);




%plot numerical solution
figure(1)
trisurf(triang,coord(:,1),coord(:,2),u_num);
title('Convection-Diffusion');
xlabel('x');
ylabel('y');

%check final residual
fprintf('residual (euclidean) norm: %e \n\n',norm(globRhs - globMat*u_num));

%check mass balance
massBal(nnodes,ndir,coord,triang,dirNod,stiffStabMat,u_num,vel);