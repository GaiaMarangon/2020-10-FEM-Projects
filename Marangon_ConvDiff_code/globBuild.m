function [globMat,stiffStabMat]=globBuild(nnodes,nelem,coord,triang,bLoc,cLoc,elemArea,diff,vel,tau)

stiffMat = zeros(nnodes,nnodes);
transpMat = zeros(nnodes,nnodes);
stabMat = zeros(nnodes,nnodes);

for iel=1:nelem
    belem = bLoc(iel,:);
    celem = cLoc(iel,:);
    areaelem = elemArea(iel);
    hmax=findEdgeMax(iel,coord,triang);
    
    for iloc=1:3
        iglob = triang(iel,iloc);   
        
        for jloc=1:3
            jglob = triang(iel,jloc);
            
            %stiffness matrix
            stiffMat(iglob,jglob) = stiffMat(iglob,jglob)+...
                ( diff(1)*belem(iloc)*belem(jloc) + diff(2)*celem(iloc)*celem(jloc) ) /(4*areaelem);
            
            %transport matrix
            transpMat(iglob,jglob) = transpMat(iglob,jglob)+...
                ( vel(1)*belem(jloc) + vel(2)*celem(jloc) )/6;
            
            %stabilization matrix
            stabMat(iglob,jglob) = stabMat(iglob,jglob)+...
                tau*hmax/norm(vel) /(4*areaelem) *...
                ( vel(1)*belem(iloc) + vel(2)*celem(iloc) )*( vel(1)*belem(jloc) + vel(2)*celem(jloc) );
            
        end       
        
    end
    
end

globMat = sparse( stiffMat+transpMat+stabMat);
stiffStabMat = sparse( stiffMat+stabMat);

end