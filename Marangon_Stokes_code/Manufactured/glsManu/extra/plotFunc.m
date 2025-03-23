function []=plotFunc(nnodes,coord,func)

xax=[];
yax=[];
for i=1:nnodes
    nod=coord(i,:);
    if (nod(2) == 0)
        xax= [xax; nod(1)];
    end
    if (nod(1) == 0)
        yax= [yax; nod(2)];
    end
end
[xaxx, yaxx]=meshgrid(xax,yax);
funcDisc=func(xaxx,yaxx);

surf( xaxx,yaxx , funcDisc);


end