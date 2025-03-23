function [stiffMat]=stiffBuild(Nelem,Nodes,triang,Bloc,Cloc,Area)

% build stiffMat= K1= K2 ={k_ij}
% with  k_ij^(T)= \int_T  \nabla phi_i \nabla phi_j 

stiffMat=sparse(Nodes,Nodes);
for iel=1:Nelem
    for iloc=1:3
        iglob=triang(iel,iloc);
        for jloc=1:3
            jglob=triang(iel,jloc);
            stiffMat(iglob,jglob)=stiffMat(iglob,jglob)+...
                ( Bloc(iel,iloc)*Bloc(iel,jloc) +...
                  Cloc(iel,iloc)*Cloc(iel,jloc) )/4 /Area(iel);    
        end
    end
end


end

