function Edgemax=findEdgeMax(iel,coord,triang)

Ledge=zeros(3,1);
vert=triang(iel,:);
for iloc=1:3
    coordNod1=coord( vert(iloc) ,:);
    coordNod2=coord( vert(mod_n(iloc+1,3)) ,:);
    Ledge(iloc)=norm(coordNod1-coordNod2);
end
Edgemax=max(Ledge);

end