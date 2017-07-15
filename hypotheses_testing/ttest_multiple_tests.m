function [Hs, Ps, Cis, Stats] = ttest_multiple_tests(Xs, Ms, method, varargin)
% Returns corrected p values for ttest. Xs and Ms are cell arrays of
% the same length. This function depends on 'pval_adjust' [1] for the
% correction.
%
% [1] https://de.mathworks.com/matlabcentral/fileexchange/55142-fakenmc-pval-adjust

if ~exist('method', 'var'), method = 'BH'; end

assert(iscell(Xs) && iscell(Ms) && numel(Xs) == numel(Ms))

Hs = nan(numel(Xs, 1));
Ps = nan(numel(Xs, 1));
Cis = nan(2, numel(Xs));
Stats = cell(numel(Xs), 1);

for i = 1:numel(Xs)
    [Hs(i), Ps(i), Cis(i, :), Stats{i}] = ttest(Xs{i}, Ms{i}, varargin{:});
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
