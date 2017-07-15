# Hypotheses Testing

The following wrapper for common statistic functions in MATLAB make it harder to make the following mistakes:
- not checking whether the samples are not from a normal distribution (for `ttest`, `ttest2`, and `corr` (Pearson)); and
- conducting multiple hypotheses tests without adjusting p values (for `ttest`, `ttest2`, `corr`, `signrank`, and `ranksum`).

## Normal distributed data
If the one-sample Kolmogorov-Smirnov test (`kstest`) rejects the hypothesis that the provided data is from a normal distribution (p<0.05), an error will be thrown.

## Multiple hypotheses testing
If the wrapper functions are called too often (more than three times in ten seconds), an error will be thrown. To conduct multiple hypotheses testing, use the `*_multiple_tests` function with a specified correction method. These functions rely on [pval_adjust.m](https://de.mathworks.com/matlabcentral/fileexchange/55142-fakenmc-pval-adjust) for the correction.