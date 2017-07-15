function [h, p, ci, stats] = ttest2(x, y, varargin)
% This is a wrapper for MATLAB's ttest2. I wrote it to prevent some future
% statistical crimes which I comitted in the past.

%% try to catch multiple hypotheses testing
detect_multiple_tests()

%% test for normal distribution
if check_normal_distribution(x) || check_normal_distribution(y)
    error('ttest2:normal', 'You should consider using ''ranksum''.')
end

%% call builtin ttest
current_directory = pwd;
ttest_directory = [matlabroot filesep 'toolbox' filesep 'stats' filesep 'stats' filesep];
cd(ttest_directory);

try
    [h, p, ci, stats] = ttest2(x, y, varargin{:});
catch err
    cd(current_directory);
    rethrow(err);
end

cd(current_directory);
end