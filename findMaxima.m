function maxima = findMaxima(x, y, threshold)
%FINDMAXIMA Finds x corresponding to local maxima of y greater or equal to threshold 

    if nargin < 3
        threshold = -inf;
    end

    maxima = [];

    for j = 2 : length(x)-1
        if y(j) > y(j-1) && y(j) > y(j+1) && y(j) >= threshold
            maxima = [maxima x(j)];
        end
    end
end