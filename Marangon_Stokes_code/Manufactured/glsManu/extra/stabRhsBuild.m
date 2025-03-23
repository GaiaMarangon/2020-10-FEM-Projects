function [G]=stabRhsBuild(nnodes,nelem,delta,triang,coord,Bloc,Cloc,Area,f1,f2)

% WARNING: minus sign to be added when assembling globRhs

[funcVect1]=func2vect(nnodes,coord,f1);
[funcVect2]=func2vect(nnodes,coord,f2);

[diverMatStab1]=diverBuildStab(delta,nnodes,nelem,triang,coord,Bloc,Area);
[diverMatStab2]=diverBuildStab(delta,nnodes,nelem,triang,coord,Cloc,Area);

G = diverMatStab1*funcVect1 + diverMatStab2*funcVect2;


end