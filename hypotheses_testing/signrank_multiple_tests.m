function [Ps, Hs, Stats] = signrank_multiple_tests(Xs, Ys, method, varargin)
% Returns corrected p values for signrank. Xs and Ys are cell arrays of
% the same length. This function depends on 'pval_adjust' [1] for the
% correction.
%
% [1] https://de.mathworks.com/matlabcentral/fileexchange/55142-fakenmc-pval-adjust

if ~exist('method', 'var'), method = 'BH'; end

assert(iscell(Xs) && iscell(Ys) && numel(Xs) == numel(Ys))

Ps = nan(numel(Xs, 1));
Hs = nan(numel(Xs, 1));
Stats = cell(numel(Xs, 1));

for i = 1:numel(Xs)
    [Ps(i), Hs(i), Stats{i}] = signrank(Xs{i}, Ys{i}, varargin{:});
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
