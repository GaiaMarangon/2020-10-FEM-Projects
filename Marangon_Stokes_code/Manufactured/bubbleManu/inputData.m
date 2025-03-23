function [nnodes,nelem,coord,triang,dirnod,dirval,u1_ex,u2_ex,p_ex,funct1,funct2,functg,ci,mu]=inputData(meshdir)


%load data for mesh folder
load( strcat(meshdir,'\coord.dat')  );
load( strcat(meshdir,'\triang.dat') );
load( strcat(meshdir,'\dirnod.dat') );
load( strcat(meshdir,'\dirval.dat') );

%sizes
nnodes = size(coord,1);
nelem = size(triang,1);

%constant coefficients
ci = 1;     %mass coeff
mu = 1;     %stiff coeff

%given functions (exact, forcing, divergence)
u1_ex = @(x,y) -cos(2*pi*x)*sin(2*pi*y) + sin(2*pi*y);
u2_ex = @(x,y)  sin(2*pi*x)*cos(2*pi*y) - sin(2*pi*x);
p_ex  = @(x,y) 2*pi*( cos(2*pi*y) - cos(2*pi*x) );

funct1 = @(x,y) ci*u1_ex(x,y) -4*mu*(pi^2)*sin(2*pi*y)*...
            ( 2*cos(2*pi*x) -1 ) +4*(pi^2)*sin(2*pi*x);
funct2 = @(x,y) ci*u2_ex(x,y) +4*mu*(pi^2)*sin(2*pi*x)*...
            ( 2*cos(2*pi*y) -1 ) -4*(pi^2)*sin(2*pi*y);
functg = @(x,y) 0;


end