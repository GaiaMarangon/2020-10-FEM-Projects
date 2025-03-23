function [massMat]=massBuild(Nodes,Nelem,triang,Area)

% build massMat= M1= M2 ={m_ij}
% with  m_ij^(T)= \int_T  phi_i phi_j 

massMat=sparse(Nodes,Nodes);
for iel=1:Nelem
    for iloc=1:3
        iglob=triang(iel,iloc);
        for jloc=1:3
            jglob=triang(iel,jloc);
            if (iglob==jglob)
                massMat(iglob,jglob)=massMat(iglob,jglob)+Area(iel)/6;
            else 
                massMat(iglob,jglob)=massMat(iglob,jglob)+Area(iel)/12;
            end
        end
    end

end