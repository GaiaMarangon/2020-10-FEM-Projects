function [nelem,nnodes,ndir,coord,topol,dirNod,dirVal,diff,vel,tau]=inputData()

meshdir = 'trial_mesh';

% LOADING FROM FILES
load( strcat(meshdir,'\coord.dat') );
load( strcat(meshdir,'\topol.dat') );
load( strcat(meshdir,'\dirNod.dat') );
load( strcat(meshdir,'\dirVal.dat') );
%delete extra columns
coord(:,1)=[];
topol(:,5)=[];
topol(:,1)=[];

% DIMENSIONS
nelem=size(topol,1);
nnodes=size(coord,1);
ndir=size(dirNod,1);


% DIFFUSION
%constant (same in all elem) diffusion coefficient: D=diag(Dxx,Dyy)  
diff=ones(1,2)*0.001;

% VELOCITY
%constant (same in all elem) velocity: v=(vx,vy)
vel=[1, 3];

% STABILIZATION COEFFICIENT
%costant coefficient, scalar
tau=1;

% FORCING FUNCTION
%assume zero forcing function



end
