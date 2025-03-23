% recirculating pattern over indexes

function remainder = mod_n(i,j)

aux=mod(i,j);
if aux ==0 
    remainder=j;
else
    remainder=aux;
end

end