function [Coefs, Pvals] = corr_multiple_tests(Xs, Ys, method, varargin)
% Returns corrected p values for corr. Xs and Ys are cell arrays of
% the same length. This function depends on 'pval_adjust' [1] for the
% correction.
%
% [1] https://de.mathworks.com/matlabcentral/fileexchange/55142-fakenmc-pval-adjust

if ~exist('method', 'var'), method = 'BH'; end

assert(iscell(Xs) && iscell(Ys) && numel(Xs) == numel(Ys))

Coefs = nan(numel(Xs, 1));
Pvals = nan(numel(Xs, 1));

for i = 1:numel(Xs)
    [Coefs(i), Pvals(i)] = corr(Xs{i}, Ys{i}, varargin{:});
end

%% correction
Pvals = pval_adjust(Pvals, method);

end