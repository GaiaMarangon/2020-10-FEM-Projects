function [dirVal]=editBCs(meshdir,ndir,dirNod,coord,u1_ex,u2_ex,p_ex)
% [dirVal]=editBCs(ndir,dirNod,coord,u1_ex,u2_ex,p_ex)
% evaluates exact solution on Dirichlet nodes
% prints the result on a file in the directory meshdir
% gives the result as output argument

dirVal=zeros(ndir,3);
for i=1:ndir
    iglob=dirNod(i);
    xdir=coord(iglob,1);
    ydir=coord(iglob,2);
    
    dirU1=u1_ex(xdir,ydir);
    dirU2= u2_ex(xdir,ydir);
    dirP=p_ex(xdir,ydir);
    
    if (abs(dirU1)<1e-15) dirU1=0; end
    if (abs(dirU2)<1e-15) dirU2=0; end
    if (abs(dirP)<1e-15) dirP=0; end
    
    dirVal(i,:)=[dirU1,dirU2,dirP];
end


% print to file (not needed)
fileIDval = fopen( strcat(meshdir,'/dirVal.dat'),'w');
fprintf(fileIDval,'%e %e %e\n', dirVal');
fclose(fileIDval);


end