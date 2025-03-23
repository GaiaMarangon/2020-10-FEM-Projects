function []=testBuildRhs(f1Rhs,f2Rhs,gRhs,f1RhsBis,f2RhsBis,gRhsBis)

    fprintf('\nTest build Rhs:\n');
    fprintf('norm of difference in f1: %f\n', norm(f1Rhs - f1RhsBis) );
    fprintf('norm of difference in f2: %f\n', norm(f2Rhs - f2RhsBis) );
    fprintf('norm of difference in g: %f\n\n', norm(gRhs - gRhsBis) );
    
end