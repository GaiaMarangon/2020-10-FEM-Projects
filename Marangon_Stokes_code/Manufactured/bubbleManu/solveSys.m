function [u1_num,u2_num,p_num]=solveSys(nnodes,nelem,dirnod,dirval,globMat,globRhs)
    

%------BACKSLASH OPERATOR---------
u_num=globMat\globRhs;
%------BACKSLASH OPERATOR---------

%{
%------GMRES----------------------
restart=10;
tol=1e-9;
maxit=80;
setup.type='nofill';
setup.milu='off';
[L,U] = ilu(globMat,setup);
u_num=gmres(globMat,globRhs,restart,tol,maxit,L,U);
%------GMRES----------------------


%------GMRES+LIFT-----------------
ndir=size(dirnod,1);
srhs=size(globRhs,1);
xg=zeros(srhs,1);
for block=1:3
    for iloc=1:ndir
        iglob=(block-1)*(nnodes+nelem) + dirnod(iloc);
        xg(iglob)=dirval(iloc,block);
    end
end
newrhs=globRhs-globMat*xg;

restart=10;
tol=1e-9;
maxit=80;
setup.type='nofill';
setup.milu='off';
[L,U] = ilu(globMat,setup);

newuh=gmres(globMat,newrhs,restart,tol,maxit,L,U);
u_num= newuh + xg;
%------GMRES+LIFT-----------------
%}



%numerical solutions
u1_num = u_num(1:nnodes);
u2_num = u_num(nnodes+nelem+1:2*nnodes+nelem);
p_num = u_num(2*nnodes+2*nelem+1:3*nnodes+2*nelem);

%check final residual
resid=norm(globRhs - globMat*u_num);
fprintf('norm of residue in solving system: %g \n',resid);

end