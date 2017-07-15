function [coef, pval] = corr(x, varargin)
% This is a wrapper for MATLAB's corr. I wrote it to prevent some future
% statistical crimes which I comitted in the past.

%% try to catch multiple hypotheses testing
if (nargin < 2) || ischar(varargin{1})
    for i = 1:(size(x, 2)^2-size(x, 2))/2
        detect_multiple_tests()
    end
else
    y = varargin{1};
    detect_multiple_tests()
end

%% Pearson's correlation?
type_index = find(cellfun(@(x) ischar(x) && strcmpi(x, 'type'), varargin), 1);
pearson = {'p', 'pearson'};

if isempty(type_index) ... % Pearson's correlation
        || (numel(varargin) >= type_index+1 ...
        && ischar(varargin{type_index+1}) ...
        && any(strcmpi(pearson, varargin{type_index+1})))
    
    %% test for normal distribution
    if exist('y', 'var')
        if check_normal_distribution(x) || check_normal_distribution(y)
            error('corr:normal', 'You should consider using Spearman''s or Kendall''s correlation.')
        end
    else
        for i = 1:size(x, 2)
            if check_normal_distribution(x(:, i))
                error('corr:normal', 'You should consider using Spearman''s or Kendall''s correlation.')
            end
        end
    end
end

%% call builtin ttest
current_directory = pwd;
ttest_directory = [matlabroot filesep 'toolbox' filesep 'stats' filesep 'stats' filesep];
cd(ttest_directory);

try
    [coef, pval] = corr(x, varargin{:});
catch err
    cd(current_directory);
    rethrow(err);
end

cd(current_directory);
end