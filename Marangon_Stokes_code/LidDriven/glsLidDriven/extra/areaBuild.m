function [nodalArea]=areaBuild(nnodes,nelem,triang,Area)

    nodalArea=zeros(nnodes,1);
    for iel=1:nelem
        for iloc=1:3
            iglob=triang(iel,iloc);
            nodalArea(iglob)= nodalArea(iglob) + Area(iel)/3;
        end
    end
end