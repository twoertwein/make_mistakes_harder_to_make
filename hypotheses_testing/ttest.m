function [h, p, ci, stats] = ttest(x, m, varargin)
% This is a wrapper for MATLAB's ttest. I wrote it to prevent some future
% statistical crimes which I comitted in the past.

%% try to catch multiple hypotheses testing
detect_multiple_tests()

%% test for normal distribution
% start of code snippet from MATLAB (Copyright 1993-2014 The MathWorks, Inc.)
if nargin < 2 || isempty(m)
    m = 0;
elseif ~isscalar(m) % paired t-test
    if ~isequal(size(m),size(x))
        error(message('stats:ttest:InputSizeMismatch'));
    end
    x = x - m;
    m = 0;
end
% end of code snippet from MATLAB

if check_normal_distribution(x)
    error('ttest:normal', 'You should consider using ''signrank''.')
end

%% call builtin ttest
current_directory = pwd;
ttest_directory = [matlabroot filesep 'toolbox' filesep 'stats' filesep 'stats' filesep];
cd(ttest_directory);

try
    [h, p, ci, stats] = ttest(x, m, varargin{:});
catch err
    cd(current_directory);
    rethrow(err);
end

cd(current_directory);
end
