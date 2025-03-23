function [blockRhs]=blockRhsBuild(nnodes,coord,massMat,func)

[funcVect]=func2vect(nnodes,coord,func);
blockRhs = massMat*funcVect;

end