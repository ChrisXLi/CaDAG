function [f df] = barrier_fct(lh,covfunc,x,target)
% wrapper used during GP training: penalizes unreasonable signal-to-noise
% ratios
%
% 2009-11-18

scale = 100;    % scaling factor
maxSNR = 1000;  % bound for SNR
order =  10;    % order of polynomial
lscale = 100;   % length-scales

[f df] = poly_barrier(lh, covfunc, x, target, maxSNR, order, lscale);
function [f df] = poly_barrier(lh, covfunc, x, target, maxSNR, order, lscale)
D = size(x,2);

% signal-to-noise ratio
snr =  exp(lh(end-1))/exp(lh(end));

% call gpr
[f df] = gpr(lh,covfunc,x,target);

% penalize length-scales
f = f + sum((lh(1:D)./log(lscale)).^order);      % length-scale
df(1:D) = df(1:D) + order*(lh(1:D)./log(lscale)).^(order-1)/log(lscale);

% penalize signal-to-noise ratios that are too high
f = f + (snr/maxSNR).^order;

% update corresponding gradients of the NLML
df(end-1) = df(end-1) + order*(snr/maxSNR).^(order-1)*snr/maxSNR;
df(end) = df(end) - order*(snr/maxSNR).^(order-1)*snr/maxSNR;
function [f df] = log_barrier(lh, covfunc, x, target, maxSNR, scale)
% for hard constraints

% call gpr
[f df] = gpr(lh,covfunc,x,target);

% new objective function
f = f - scale*log(maxSNR - exp(lh(end-1))/exp(lh(end)));

% derivatives
outer = -scale/(maxSNR - exp(lh(end-1))/exp(lh(end)));
inner1 = - exp(lh(end-1))/exp(lh(end));
inner2 =   exp(lh(end-1))/exp(lh(end));

df(end-1) = df(end-1) + outer*inner1;
df(end) =   df(end) + outer*inner2;