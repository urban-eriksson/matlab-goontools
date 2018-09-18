function crossings = findCrossings(x, y, level, N)
%FINDCROSSINGS Finds at most N x-values where y crosses level

    if nargin < 4
        N = inf;
    end

    crossings = [];
    sgn = 0;

    for j = 1 : length(x)
        if y(j) < level && sgn == 1 || y(j) > level && sgn == -1
            if j - idx_before == 1
                k = (level - y(idx_before)) / (y(j) - y(idx_before));
                xcross = (1 - k) * x(idx_before) + k * x(j);
            else
                xcross = mean(x(idx_before + 1:j - 1));
            end
            crossings = [crossings xcross];
            N = N - 1;
            if N == 0
                break
            end
        end
        
        if y(j) < level
            sgn = -1;
            idx_before = j;
        elseif y(j) > level
            sgn = 1;
            idx_before = j;
        end
    end

end