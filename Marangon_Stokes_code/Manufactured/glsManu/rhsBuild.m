function [globRhs]=rhsBuild(nnodes,nelem,triang,coord,nodalArea,elemArea,bary,f1,f2,g)

vecf1 = zeros(nnodes,1);
vecf2 = zeros(nnodes,1);
vecg = zeros(nnodes,1);


%--------MIDPOINT RULE------------------------------------
for iel = 1:nelem
    elemA = elemArea(iel);
    xg=bary(iel,1);
    yg=bary(iel,2);
    for iloc=1:3
        iglob=triang(iel,iloc);
        vecf1(iglob) =  vecf1(iglob) + f1(xg,yg)*elemA/3;  
        vecf2(iglob) =  vecf2(iglob) + f2(xg,yg)*elemA/3;  
        vecg(iglob) = vecg(iglob) + g(xg,yg)*elemA/3;
    end
end
%--------MIDPOINT RULE------------------------------------

%{
%--------TRAPEZOIDAL RULE--------------
for inod=1:nnodes
    vecf1(inod) = f1( coord(inod,1),coord(inod,2) ) * nodalArea(inod);
    vecf2(inod) = f2( coord(inod,1),coord(inod,2) ) * nodalArea(inod);
    vecg(inod) = g( coord(inod,1),coord(inod,2) ) * nodalArea(inod);
end
%--------TRAPEZOIDAL RULE--------------
%}

globRhs = [vecf1; vecf2; -vecg];
end