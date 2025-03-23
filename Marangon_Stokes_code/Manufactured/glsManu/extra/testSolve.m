function []=testSolve(nnodes,coord,u1_ex,u2_ex,p_ex,globMat,globRhs)

    % test if, with exact solution, it holds: Au-b=0
    u1Vec=func2vect(nnodes,coord,u1_ex);
    u2Vec=func2vect(nnodes,coord,u2_ex);
    pVec=func2vect(nnodes,coord,p_ex);
    
    usol=[u1Vec; u2Vec; pVec];
    hopeZero = globMat*usol - globRhs;
    residual = norm(hopeZero);
    fprintf('testSolve residual: %f\n\n',residual);
    
    %{
    %test the same, without pressure
    globMat(2*nnodes+1:3*nnodes,:)=[];
    globMat(:,2*nnodes+1:3*nnodes)=[];
    globRhs(2*nnodes+1:3*nnodes)=[];
    usol(2*nnodes+1:3*nnodes)=[];
    
    hopeZero = globMat*usol - globRhs;
    residual = norm(hopeZero);
    fprintf('testSolve residual no pressure: %f\n\n',residual);
    %}
end