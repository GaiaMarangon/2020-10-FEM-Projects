function [stabMat]=stabBuild(Nodes,Nelem,delta,triang,coord,Bloc,Cloc,Area)

% build stabMat= C ={c_ij}
% with  c_ij^(T)= delta*h^2*   \int_T  \nabla phi_i \nabla phi_j 
% WARNING: minus sign to be introduced when assembling globMat

% WARNING: this function is not necessary if h^2 not present
%          in that case, can use stiffBuild and premultiply
%          the whole matrix stiffMat by delta

stabMat=sparse(Nodes,Nodes);
for iel=1:Nelem
    maxEdge=findEdgeMax(iel,triang,coord);
    for iloc=1:3
        iglob=triang(iel,iloc);
        for jloc=1:3
            jglob=triang(iel,jloc);
            stabMat(iglob,jglob)=stabMat(iglob,jglob)+...
                    delta/4/Area(iel)*maxEdge^2*...     
                    ( Bloc(iel,iloc)*Bloc(iel,jloc) +...
                      Cloc(iel,iloc)*Cloc(iel,jloc) );
        end
    end
end

end