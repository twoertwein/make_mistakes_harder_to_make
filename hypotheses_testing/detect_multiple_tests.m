function detect_multiple_tests(n, seconds)
% try to catch multiple hypotheses testing

if ~exist('n', 'var'), n = 3; end
if ~exist('seconds', 'var'), seconds = 10; end

%% ignore calls from corr/ttest/ttest2/ranksum/signrank_multiple_tests
multiple_test_parents = strcat({'corr', 'ttest', 'test2', 'ranksum', 'signrank'}, '_multiple_tests');
stack = dbstack;

if any(cellfun(@(x) any(strcmp(x, multiple_test_parents)), {stack.name}))
    return
end

%% keep history of last n hypotheses tests
persistent last_ttests
if isempty(last_ttests)
    last_ttests = cell(n, 1);
end

last_ttests(2:n) = last_ttests(1:n-1);
last_ttests{1} = datetime;

%% too many hypotheses tests
if ~isempty(last_ttests{n}) && (last_ttests{1} - last_ttests{n}) < duration(0, 0, seconds)
    error('Do you think your methodology is correct?')
end

end
