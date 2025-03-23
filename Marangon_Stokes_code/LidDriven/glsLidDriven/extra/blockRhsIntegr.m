function [blockRhs]=blockRhsIntegr(nnodes,nelem,coord,triang,bary,elemArea,nodalArea,func)

blockRhs=zeros(nnodes,1);

%{
%--------TRAPEZOIDAL RULE--------------
for inod=1:nnodes
    blockRhs(inod) = func( coord(inod,1),coord(inod,2) ) * nodalArea(inod);
end
%--------TRAPEZOIDAL RULE--------------
%}


%--------MIDPOINT RULE-----------------
for iel=1:nelem
    x = bary(iel,1);
    y = bary(iel,2);
    areaelem = elemArea(iel);
 
    for iloc=1:3
        iglob = triang(iel,iloc);
        blockRhs(iglob) = blockRhs(iglob) + func(x,y)*areaelem/3;
    end
end
%--------MIDPOINT RULE-----------------





end