function  u = repeat(v,n)
    [r,c] = size(v);
    if r > 1
        u = zeros(r*n,1);
        m = r;
    else
        u = zeros(1,c*n);
        m = c;
    end
    for j = 1:n
       u((j-1)*m+1:j*m) = v;
    end
end