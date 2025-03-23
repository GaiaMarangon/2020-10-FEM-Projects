clear all, close all, clc

% select mesh
meshdir='mesh4';

% load old data
load(strcat(meshdir,'\mesh.dat'));
load(strcat(meshdir,'\xy.dat'));
load(strcat(meshdir,'\dirtot.dat'));

% adapt intervals from [-1,1] to [0,1]
coord=zeros( size(xy,1), 2);
coord(:,1)=xy(:,1)/2 + 0.5;
coord(:,2)=xy(:,2)/2 + 0.5;

% cancel extra columns
mesh(:,4)=[];


%reprint to new, renamed files
fIDtriang = fopen( strcat(meshdir,'/triang.dat'),'w');
fIDcoord = fopen( strcat(meshdir,'/coord.dat'),'w');
fIDdirNod = fopen( strcat(meshdir,'/dirNod.dat'),'w');

fprintf(fIDtriang,'%d %d %d\n', mesh');
fprintf(fIDcoord,'%e %e\n', coord');
fprintf(fIDdirNod,'%d\n', dirtot');

fclose(fIDtriang);
fclose(fIDcoord);
fclose(fIDdirNod);


