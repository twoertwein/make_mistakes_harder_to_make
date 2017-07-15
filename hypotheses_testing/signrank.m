function [p, h, stats] = signrank(x, y, varargin)
% This is a wrapper for MATLAB's signrank. I wrote it to prevent some future
% statistical crimes which I comitted in the past.

if ~exist('y', 'var'), y = 0; end

%% try to catch multiple hypotheses testing
detect_multiple_tests()

%% call builtin ttest
current_directory = pwd;
ttest_directory = [matlabroot filesep 'toolbox' filesep 'stats' filesep 'stats' filesep];
cd(ttest_directory);

try
    [p, h, stats] = signrank(x, y, varargin{:});
catch err
    cd(current_directory);
    rethrow(err);
end

cd(current_directory);
end