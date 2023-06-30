function [loghypers] = train_gps(inputs,targets)

% Train gps given targets and inputs, using the RBF kernel
%
% Inputs     -    inputs  : [n X D] matrix, where n = # of training points,
%                           D = latent state dimension
%                 targets : [n X E] matrix, where n = # of training points,
%                           E = output state dimension
%
% Outputs    -    loghypers: [D+2 X E] matrix, where each column contains
%                            the (D+2) log hyperparameters in the following order:
%                            [ log(ell_1)
%                              log(ell_2)
%                              ...
%                              log(ell_D)
%                              log(sqrt(sf2))
%                              log(sqrt(sn2))], where ell_i is the
%                              characterestic length scale, sf2 is the
%                              signal variance, sn2 is the noise variance
%                              (Look at "Robust Filtering and Smoothing
%                              with Gaussian Processes" by Deisenroth et
%                              al, section II Gaussian Processes, for an
%                              explanation of these terms)
%
% Author: Karthik Lakshmanan (2013) karthikl@cs.cmu.edu

D = size(inputs,2)
E = size(targets,2)
loghypers = trainf(inputs,targets);
loghypers = reshape(loghypers,D+2,E);