function [globMat]=globBuild(nnodes,nelem,triang,bLoc,cLoc,elemArea,ci,mu)
%compute all elemental contributions, listing them by blocks:


%define matrices nnodes*nnodes, with _{ij} elements
massIJ = zeros(nnodes,nnodes);
stiffIJ = zeros(nnodes,nnodes);
divIJ1 = zeros(nnodes,nnodes);
divIJ2 = zeros(nnodes,nnodes);
%define matrices nnodes*nelem, with _{in} elements
massIN = zeros(nnodes,nelem);
divIN1 = zeros(nnodes,nelem);
divIN2 = zeros(nnodes,nelem);
%define matrices nelm*nelem, with _{mm} elements
massMM = zeros(nelem,nelem);
stiffMM = zeros(nelem,nelem);
   



%run over iel=1...nelem
for iel=1:nelem
    belem = bLoc(iel,:);
    celem = cLoc(iel,:);
    areaelem = elemArea(iel);
    
    %BLOCK 1: use iel(=m)   -->   compute _{mm} elements
    %mass matrix
    massMM(iel,iel) = massMM(iel,iel) +areaelem*81/280;
    %stiff matrix
    stiffMM(iel,iel) = stiffMM(iel,iel) + 81/40/areaelem*...
        ( belem(1)^2 + celem(1)^2 + belem(2)^2 + celem(2)^2 + belem(1)*belem(2) + celem(1)*celem(2) );
    
    
    %run over i=1...nnodes
    for iloc=1:3
        iglob=triang(iel,iloc);
        
        %BLOCK 2: use iel(=n), iloc(=i)   -->   compute _{in} elements
        %mass matrix
        massIN(iglob,iel) = massIN(iglob,iel) + areaelem*3/20;
        %diver matrix
        divIN1(iglob,iel) = divIN1(iglob,iel) + belem(iloc)*9/40;
        divIN2(iglob,iel) = divIN2(iglob,iel) + celem(iloc)*9/40;
        
        
        %run over j=1...nnodes   
        for jloc=1:3
            jglob=triang(iel,jloc);
            
            %BLOCK 3: use iloc(=i), jloc(=j)   -->   compute _{ij} elements 
            %mass matrix
            if (iglob == jglob)
                massIJ(iglob,jglob) = massIJ(iglob,jglob) + areaelem/6;
            else
                massIJ(iglob,jglob) = massIJ(iglob,jglob) + areaelem/12;
            end
            %stiff matrix
            stiffIJ(iglob,jglob) = stiffIJ(iglob,jglob) + ...
                ( belem(iloc)*belem(jloc) + celem(iloc)*celem(jloc) ) / (4*areaelem);
            %diver matrix
            divIJ1(iglob,jglob) = divIJ1(iglob,jglob) - belem(jloc)/6;
            divIJ2(iglob,jglob) = divIJ2(iglob,jglob) - celem(jloc)/6;
        end         
    end     
end


%turn to sparse
massIJ=sparse(massIJ);
massIN=sparse(massIN);
stiffIJ=sparse(stiffIJ);
divIJ1=sparse(divIJ1);
divIJ2=sparse(divIJ2);
divIN1=sparse(divIN1);
divIN2=sparse(divIN2);


%progressively assemble all blocks to build global matrix:
 stiffmass = [ ci*massIJ + mu*stiffIJ,        ci*massIN;
               ci*massIN',       ci*massMM + mu*stiffMM] ;
           
 div1 = [divIJ1, divIN1];
 div2 = [divIJ2, divIN2];
 
 globMat = [ stiffmass,      zeros(nnodes+nelem,nnodes+nelem),       div1';
             zeros(nnodes+nelem,nnodes+nelem),      stiffmass,       div2';
             div1,           div2,                    zeros(nnodes,nnodes)] ;

end