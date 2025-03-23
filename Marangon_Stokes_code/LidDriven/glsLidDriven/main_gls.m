%same program used with manufactured solutions
%all modifications (inputData.m,imposeBC.m) are done by commenting the
%original version and substituting with the proper information

clear all, close all, clc

meshdir = 'mesh3';


% INPUT DATA OF THE PROBLEM
[delta,const,mu,u1_ex,u2_ex,p_ex,f1,f2,g,...    
          nnodes,ndir,nelem,coord,triang,dirNod,dirVal]=inputData(meshdir);
      
% PLOT EXACT SOLUTION
nfig=1;
%nfig=plotEx(1,nnodes,triang,coord,u1_ex,u2_ex,p_ex);           

% LOCAL BASIS FUNCTION P1/P1
[aLoc,bLoc,cLoc,elemArea,nodalArea,bary]=localBasis(nnodes,nelem,coord,triang);

% STIFFNESS MATRIX 
[stiffMat]=stiffBuild(nelem,nnodes,triang,bLoc,cLoc,elemArea);

% MASS MATRIX 
[massMat]=massBuild(nnodes,nelem,triang,elemArea);

% DIVERGENCE MATRICES 
[diverMat1]=diverBuild(nnodes,nelem,triang,bLoc,elemArea);
[diverMat2]=diverBuild(nnodes,nelem,triang,cLoc,elemArea);



% CASE 1: P1/P1 NO STABILIZATION

    % GLOBAL MATRIX - P1/P1 NO STABILIZATION
    [globMat]=globBuild(nnodes,const,mu,stiffMat,massMat,diverMat1,diverMat2);

    % GLOBAL RHS - P1/P1 NO STABILIZATION
    [globRhs]=rhsBuild(nnodes,nelem,triang,coord,nodalArea,elemArea,bary,f1,f2,g);
    
    % IMPOSE BCs (modifying system at dirnodes)
    %[globMatBC,globRhsBC]=imposeBC(nnodes,dirNod,dirVal,nodalArea,globMat,globRhs);

    % SOLVE THE SYSTEM - P1/P1 NO STABILIZATION
    %[u1_num,u2_num,p_num]=solveSys(nnodes,ndir,dirNod,dirVal,globMatBC,globRhsBC);

    % PLOT SOLUTIONS - P1/P1 NO STABILIZATION
    %nfig=plotNumSol(nfig,triang,coord,u1_num,u2_num,p_num);

    % TEST ERROR 
    %fprintf('\nNo stabilization:\n');
    %testError(nnodes,coord,u1_ex,u2_ex,p_ex,u1_num,u2_num,p_num);



    

% CASE 2: P1/P1 GLS STABILIZATION
fprintf('\n--------------------------------\n');

        % STABILIZATION MATRIX
        [stabMat]=stabBuild(nnodes,nelem,delta,triang,coord,bLoc,cLoc,elemArea);
        globMat = globMat + [zeros(2*nnodes,2*nnodes), zeros(2*nnodes,nnodes);
                             zeros(nnodes,2*nnodes),   -stabMat              ];
        % STABILIZATION RHS
        [gRhsStab]=rhsBuildStab(nelem,nnodes,delta,triang,coord,bLoc,cLoc,bary,f1,f2);
        globRhs = globRhs + [zeros(2*nnodes,1); gRhsStab];        
        
        % IMPOSE BCs (modifying system at dirnodes)
        [globMatBC,globRhsBC]=imposeBC(nnodes,dirNod,dirVal,nodalArea,globMat,globRhs);

        % SOLVE THE SYSTEM - P1/P1 WITH GLS STABILIZATION
        [u1Stab_num,u2Stab_num,pStab_num]=solveSys(nnodes,ndir,dirNod,dirVal,globMatBC,globRhsBC);

        % TEST ERROR 
        %fprintf('\nGLS stabilization :\n');
        %testError(nnodes,coord,u1_ex,u2_ex,p_ex,u1Stab_num,u2Stab_num,pStab_num);
        
        % PLOT SOLUTIONS - P1/P1 WITH GLS STABILIZATION
        nfig=plotNumSolStab(nfig,triang,coord,u1Stab_num,u2Stab_num,pStab_num);
        
    
        
        
        
        
 