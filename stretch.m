function  u = stretch(v,n)
    [r,c] = size(v);
    if r > 1
        u = zeros(r*n,1);
        o = ones(n,1);
        m = r;
    else
        u = zeros(1,c*n);
        o = ones(1,n);
        m = c;
    end
    for j = 1:m
       u((j-1)*n+1:j*n) = v(j) * o;
    end
end