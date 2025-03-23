function [aLoc,bLoc,cLoc,elemArea]=localBasis(nelem,coord,triang)

aLoc = zeros(nelem,3);
bLoc = zeros(nelem,3);
cLoc = zeros(nelem,3);

elemArea = zeros(nelem,1);

for iel=1:nelem
    %global index of vertices
    globvert = triang(iel,:);
    %coordinates of vertices
    c=[ coord(globvert(1),:);
        coord(globvert(2),:);
        coord(globvert(3),:)] ;
    %Van Der Monde Matrix
    vdm = [ ones(3,1), c];
    %its determinant and area of element
    deter = det(vdm);
    elemArea(iel) = abs(deter)/2;
    
    for i1=1:3
        i2=mod_n(i1+1,3);
        i3=mod_n(i1+2,3);
        %basis coefficients
        aLoc(iel,i1) = c(i2,1)*c(i3,2) - c(i3,1)*c(i2,1) ;
        bLoc(iel,i1) = c(i2,2) - c(i3,2);
        cLoc(iel,i1) = c(i3,1) - c(i2,1);
    end
    
end


end