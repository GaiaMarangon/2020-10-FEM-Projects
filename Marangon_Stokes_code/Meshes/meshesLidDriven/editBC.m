clear all, close all, clc

meshdir = 'mesh4';
load(strcat(meshdir,'/coord.dat'));
load(strcat(meshdir,'/triang.dat'));
load(strcat(meshdir,'/dirnod.dat'));

ndir=size(dirnod,1);
dirvalLD=zeros(ndir,2);
for inod=1:ndir
    iglob=dirnod(inod);
    ycoord=coord(iglob,2);
    if (ycoord == 1)
        dirvalLD(inod,1)=1;
    end
end

% print to file 
fileIDval = fopen( strcat(meshdir,'/dirVal.dat'),'w');
fprintf(fileIDval,'%e %e \n', dirvalLD');
fclose(fileIDval);

%test correct BCs:
nnodes=size(coord,1);
bcsU1=zeros(nnodes,1);
bcsU2=zeros(nnodes,1);
for inod=1:ndir
    iglob=dirnod(inod);
    bcsU1(iglob)=dirvalLD(inod,1);
    bcsU2(iglob)=dirvalLD(inod,2);
end

figure(1)
trisurf(triang,coord(:,1),coord(:,2),bcsU1);
title('BCs - u_1');
xlabel('x');
ylabel('y');

figure(2)
trisurf(triang,coord(:,1),coord(:,2),bcsU2);
title('BCs - u_2');
xlabel('x');
ylabel('y');
