function [funcVect]=func2vect(nnodes,coord,func)

funcVect=zeros(nnodes,1);
for i=1:nnodes
    xdir=coord(i,1);
    ydir=coord(i,2);
    funcVect(i)=func(xdir,ydir);    
end

end