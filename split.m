function  u = split(v,n)
    m = length(v) / n;
    u = cell(1,n);
    for j = 1:n
       u{j} = v((j-1)*m + 1: j*m);
    end
end