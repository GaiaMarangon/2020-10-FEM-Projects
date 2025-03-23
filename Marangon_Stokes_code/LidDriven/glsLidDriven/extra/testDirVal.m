function []=testDirVal(nnodes,ndir,triang,coord,dirNod,dirVal)

%{
xdir=zeros(ndir,1);
ydir=zeros(ndir,1);
for i=1:ndir
    iglob=dirNod(i);
    xdir(i)=coord(iglob,1);
    ydir(i)=coord(iglob,2);
end
%}

dirValTest=zeros(nnodes,3);
for i=1:ndir
    iglob=dirNod(i);
    dirValTest(iglob,:)=dirVal(i,:);
end

figure(10)
trisurf(triang,coord(:,1),coord(:,2),dirValTest(:,1));
figure(11)
trisurf(triang,coord(:,1),coord(:,2),dirValTest(:,2));
figure(12)
trisurf(triang,coord(:,1),coord(:,2),dirValTest(:,3));

end