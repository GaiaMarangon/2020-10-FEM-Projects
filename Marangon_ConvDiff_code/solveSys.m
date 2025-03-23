function [u_num]=solveSys(nnodes,ndir,dirNod,dirVal,globMat,globRhs)


%set lift function
xg=zeros(nnodes,1);
for iloc=1:ndir
    iglob=dirNod(iloc);
    xg(iglob)=dirVal(iloc);
end
newrhs=globRhs-globMat*xg;

%apply gmres
restart=10;
tol=1e-9;
maxit=20;
setup.type='nofill';
setup.milu='off';
[L,U] = ilu(globMat,setup);
newu_num=gmres(globMat,newrhs,restart,tol,maxit,L,U);

%build back wanted solution
u_num= newu_num + xg;

%{
%--------ALTERNATIVE VERSION: ONLY GMRES---------------
restart=10;
tol=1e-9;
maxit=20;
setup.type='nofill';
setup.milu='off';
[L,U] = ilu(globMat,setup);
u_num=gmres(globMat,globRhs,restart,tol,maxit,L,U);
%--------ALTERNATIVE VERSION: ONLY GMRES---------------
%}

end