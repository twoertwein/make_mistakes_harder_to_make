function [Hs, Ps, Cis, Stats] = ttest2_multiple_tests(Xs, Ys, method, varargin)
% Returns corrected p values for ttest2. Xs and Ys are cell arrays of
% the same length. This function depends on 'pval_adjust' [1] for the
% correction.
%
% [1] https://de.mathworks.com/matlabcentral/fileexchange/55142-fakenmc-pval-adjust

if ~exist('method', 'var'), method = 'BH'; end

assert(iscell(Xs) && iscell(Ys) && numel(Xs) == numel(Ys))

Hs = nan(numel(Xs, 1));
Ps = nan(numel(Xs, 1));
Cis = nan(numel(Xs, 2));
Stats = cell(numel(Xs), 1);

for i = 1:numel(Xs)
    [Hs(i), Ps(i), Cis(i, :), Stats{i}] = ttest2(Xs{i}, Ys{i}, varargin{:});
end

%% correction
Ps = pval_adjust(Ps, method);

alpha_index = find(cellfun(@(x) ischar(x) && strcmpi(x, 'alpha'), varargin), 1);
if isempty(alpha_index) 
    alpha = 0.05;
else
    alpha = varargin{alpha_index+1};
end
Hs = Ps < alpha;

end
