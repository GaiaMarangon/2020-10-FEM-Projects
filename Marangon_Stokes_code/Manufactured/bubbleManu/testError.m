function []=testError(nnodes,coord,u1_ex,u2_ex,p_ex,u1_num,u2_num,p_num)
% compute separately the residual for u1, u2, p;
% compute total residual for (u1,u2,p);

    u1Vec=func2vect(nnodes,coord,u1_ex);
    u2Vec=func2vect(nnodes,coord,u2_ex);
    pVec=func2vect(nnodes,coord,p_ex);
    
    residualU1 = norm( u1_num-u1Vec );
    residualU2 = norm( u2_num-u2Vec );
    residualP = norm( p_num-pVec );
    
    residualTot = norm( [u1_num-u1Vec; u2_num-u2Vec; p_num-pVec] );
    
    fprintf('residual on u1: %f\n',residualU1);
    fprintf('residual on u2: %f\n',residualU2);
    fprintf('residual on p: %f\n',residualP);
    fprintf('total residual: %f\n\n',residualTot);

end