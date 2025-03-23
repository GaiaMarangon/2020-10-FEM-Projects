function [delta,const,mu,u1_ex,u2_ex,p_ex,f1,f2,g,...    
          nnodes,ndir,nelem,coord,triang,dirNod,dirVal]=inputData(meshdir)

      
% DATA OF THE PROBLEM 
      
% exact solution
u1_ex = @(x,y) 0;       %-cos(2*pi*x)*sin(2*pi*y) + sin(2*pi*y);
u2_ex = @(x,y) 0;       % sin(2*pi*x)*cos(2*pi*y) - sin(2*pi*x);
p_ex  = @(x,y) 0;       % 2*pi*( cos(2*pi*y) - cos(2*pi*x) );

% constants
const = 0;          %1;          %mass coeff
mu = 1;             %stiff coeff
delta = 0.02;       %stab coeff

% forcing and divergence functions
f1 = @(x,y) 0;      %const*u1_ex(x,y) -4*mu*(pi^2)*sin(2*pi*y)*...
                    %( 2*cos(2*pi*x) -1 ) +4*(pi^2)*sin(2*pi*x);
f2 = @(x,y) 0;      %const*u2_ex(x,y) +4*mu*(pi^2)*sin(2*pi*x)*...
                    %( 2*cos(2*pi*y) -1 ) -4*(pi^2)*sin(2*pi*y);
g = @(x,y)    0;
        
% load mesh (coord, triang, dirNod, dirVal) 
load( strcat(meshdir,'/coord.dat') );
load( strcat(meshdir,'/triang.dat') );
load( strcat(meshdir,'/dirNod.dat') );
load( strcat(meshdir,'/dirVal.dat') );

% define vectors dimension
nnodes=size(coord,1);
ndir=size(dirNod,1);
nelem=size(triang,1);


end