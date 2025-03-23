function [globRhs]=rhsBuild(nnodes,nelem,triang,bary,elemArea,funct1,funct2,functg)
%integration by midpoint rule

%define rhs by blocks
f1 = zeros(nnodes,1);
f1B = zeros(nelem,1);
f2 = zeros(nnodes,1);
f2B = zeros(nelem,1);
g = zeros(nnodes,1);

%compute elemental contributions
for iel=1:nelem
    x = bary(iel,1);
    y = bary(iel,2);
    areaelem = elemArea(iel);
    
    %bubble contributions
    f1B(iel) = funct1(x,y) * areaelem*9/20;
    f2B(iel) = funct2(x,y) * areaelem*9/20;
    
    %non-bubble contributions
    for iloc=1:3
        iglob = triang(iel,iloc);
        f1(iglob) = f1(iglob) + funct1(x,y)*areaelem/3;
        f2(iglob) = f2(iglob) + funct2(x,y)*areaelem/3;
        g(iglob) = g(iglob) + functg(x,y)*areaelem/3; 
    end
end

globRhs = [ f1; f1B; f2; f2B; -g];




end