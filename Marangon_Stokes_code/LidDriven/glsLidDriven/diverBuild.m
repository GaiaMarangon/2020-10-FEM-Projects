function [diverMat]=diverBuild(Nodes,Nelem,triang,coeff,Area)

% build diverMat= B ={b_ki}
% with  b_ki^(T)= - \int_T  phi_k \deriv phi_i
% where \deriv is: wrt x for B1
%                  wrt y for B2
% correspondigly, coeff= Bloc for B1
%                        Cloc for B2

diverMat=sparse(Nodes,Nodes);
for iel=1:Nelem
    for iloc=1:3
        iglob=triang(iel,iloc);
        for jloc=1:3
            jglob=triang(iel,jloc);
            diverMat(iglob,jglob)=diverMat(iglob,jglob) -...        
                coeff(iel,jloc)/6 ; 
        end
    end

end