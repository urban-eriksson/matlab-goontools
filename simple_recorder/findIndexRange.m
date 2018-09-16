function [idx_low,idx_high] = findIndexRange(x_low, x_high, x_sorted)
%FINDINDEXRANGE Gaussian process smoothing

N = length(x_sorted);

k_low = 1;
k_high = N;
exit_flag = false;
while ~exit_flag
    k = floor((k_low+k_high)/2);
    if x_low == x_sorted(k)
        idx_low = k;
        exit_flag = true;
    elseif k == 1
        idx_low = k;
        exit_flag = true;
    elseif k == N
        idx_low = NaN;
        exit_flag = true;
    elseif k_high - k_low == 1
        idx_low = k_high;
        exit_flag = true;
    elseif x_low < x_sorted(k)
        k_high = k;
    elseif x_low > x_sorted(k)
        k_low = k;
    end
    %if k_high - k_low == 1 
    %    idx_low = k_high;
    %    exit_flag = true;
    %end
end

while idx_low > 1 && x_low == x_sorted(idx_low-1)
    idx_low = idx_low - 1;
end
    
k_low = 1;
k_high = N;
exit_flag = false;
while ~exit_flag
    k = ceil((k_low+k_high)/2);
    if x_high == x_sorted(k)
        idx_high = k;
        exit_flag = true;
    elseif k == N
        idx_high = k;
        exit_flag = true;
    elseif k == 1
        idx_high = NaN;
        exit_flag = true;
    elseif k_high - k_low == 1
        idx_high = k_low;
        exit_flag = true;
    elseif x_high < x_sorted(k)
        k_high = k;
    elseif x_high > x_sorted(k)
        k_low = k;
    end
    %if k_high - k_low == 1 
    %    idx_high = k_low;
    %    exit_flag = true;
    %end
end

while idx_high < N && x_high == x_sorted(idx_high+1)
    idx_high = idx_high + 1;
end