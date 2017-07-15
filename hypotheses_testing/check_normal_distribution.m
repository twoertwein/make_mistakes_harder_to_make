function result = check_normal_distribution(x, test_fun)
% returns true if x is likely not to be from a normal distribution.

if ~exist('test_fun', 'var'), test_fun = @(x) kstest((x-nanmean(x))./nanstd(x)); end

result = test_fun(x);

end