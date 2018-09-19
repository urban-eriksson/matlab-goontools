function minima = findMinima(x, y, threshold)
%FINDMINIMA Finds x corresponding to local minima of y less or equal to threshold 

    if nargin < 3
        threshold = inf;
    end

    minima = [];

    for j = 2 : length(x)-1
        if y(j) < y(j-1) && y(j) < y(j+1) && y(j) <= threshold
            minima = [minima x(j)];
        end
    end
end