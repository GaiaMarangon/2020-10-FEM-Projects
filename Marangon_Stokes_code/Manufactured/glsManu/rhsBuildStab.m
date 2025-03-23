function [gstab]=rhsBuildStab(nelem,nnodes,delta,triang,coord,bLoc,cLoc,bary,f1,f2)

gstab = zeros(nnodes,1);
for iel=1:nelem
    belem=bLoc(iel,:);
    celem=cLoc(iel,:);
    xg=bary(iel,1);
    yg=bary(iel,2);
    maxedge=findEdgeMax(iel,triang,coord);
    for iloc=1:3
        iglob=triang(iel,iloc);
        gstab(iglob) = gstab(iglob) - delta*(maxedge^2)/2*...
                       ( belem(iloc)*f1(xg,yg) + celem(iloc)*f2(xg,yg) );
    end
end


end