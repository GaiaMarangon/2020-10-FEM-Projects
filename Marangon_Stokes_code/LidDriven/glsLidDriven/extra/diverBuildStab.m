function [diverMatStab]=diverBuildStab(delta,Nodes,Nelem,triang,coord,coeff,Area)

% build diverMatStab= Btilde ={btilde_ki}
% with  btilde_ki^(T)= - delta*h^2*  \int_T  phi_k \deriv phi_i
% where \deriv is: wrt x for B1tilde
%                  wrt y for B2tilde
% correspondigly, coeff= Bloc for B1tilde
%                        Cloc for B2tilde

% WARNING: this function is not necessary if h^2 not present
%          in that case, can use diverBuild and premultiply
%          the whole matrix diverMat by delta

diverMatStab=sparse(Nodes,Nodes);
for iel=1:Nelem
    maxEdge=findEdgeMax(iel,triang,coord);
    for iloc=1:3
        iglob=triang(iel,iloc);
        for jloc=1:3
            jglob=triang(iel,jloc);
            diverMatStab(iglob,jglob)=diverMatStab(iglob,jglob)-...
                delta* coeff(iel,jloc)/6 *maxEdge^2;    
        end
    end

end