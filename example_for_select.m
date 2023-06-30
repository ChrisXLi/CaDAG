% example: nonstationary data
% clear all,clc,close all
% addpath(genpath(pwd))
clear all,clc,close all;

addpath '/KCI-test'
addpath '/KCI-test/algorithms'
rng(10)
k = 7; % num of domain splitting
a_v = 4; % voting threshold

data = xlsread();

xingbie = data(:,2);
yigan1 = data(:,9);
yigan2 = data(:,10);
yigan3 = data(:,11);

ganyinghua = data(:,14);
jiejie = data(:,15);
datiaishuan = data(:,16);
shumu = data(:,17);
zhijinghe = data(:,21);
xibaoleixing = data(:,27);
fenhuachengdu = data(:,28);
jingxiaganyinghua = data(:,29);
Gpingfen = data(:,30);
Spingfen = data(:,31);
jingxiaaishuan = data(:,32);

Data=[xingbie,yigan1,yigan2,yigan3,ganyinghua,jiejie,datiaishuan,shumu,zhijinghe,xibaoleixing,fenhuachengdu,jingxiaganyinghua,Gpingfen,Spingfen,jingxiaaishuan];
data = Data;

g0 = zeros(16);
for i = 1:k
    % x1->x2->x3, and the causal module of x1, x2, and x3 are nonstationary,
    % and the causal modules change independently
    load smooth_module
% R0 saves generated nonstatioanry driving force which are independent of each other
%% SPLITTING
    T = 101;
    Data = data((i-1)*31+1:(i-1)*31+T,:);

%% set the parameters
    alpha = 0.05; % signifcance level of independence test
    maxFanIn = 2; % maximum number of conditional variables
    if (T<=1000) % for small sample size, use GP to learn the kernel width in conditional independence tests
        cond_ind_test='indtest_new_t';
        IF_GP = 1; 
    else
        if (T>1000 & T<2000) % for relatively large sample size, fix the kernel width
        cond_ind_test='indtest_new_t';
        IF_GP = 0;
        else % for very large sample size, fix the kernel width and use random fourier feature to approximate the kernel
            cond_ind_test='indtest_new_t_RFF';
            IF_GP = 0;
        end
    end
    pars.pairwise = false;
    pars.bonferroni = false;
    pars.if_GP1 = IF_GP; % for conditional independence test
    pars.if_GP2 = 1;  % for direction determination with independent change principle & nonstationary driving force visualization
    pars.width = 0; % kernel width on observational variables (except the time index). If it is 0, then use the default kernel width when IF_GP = 0
    pars.widthT = 0.1; % the kernel width on the time index
    c_indx = [1:T]'; % surrogate variable to capture the distribution shift; 
                 % here it is the time index, because the data is nonstationary
    Type = 1; 

%   phase 1: learning causal skeleton, 
%   phase 2: identifying causal directions with generalization of invariance, 
%   phase 3: identifying directions with independent change principle, and 
% If Type = 1, perform phase 1 + phase 2 + phase 3 
% If Type = 2, perform phase 1 + phase 2
% If Type = 3, only perform phase 1

% If Type=0, run all phases of CD-NOD (including 
% recovering the nonstationarity driving force

    [g_skeleton, g_inv, gns, SP] = nonsta_cd_new(Data, cond_ind_test, c_indx, maxFanIn, alpha, Type, pars);
    g0 = g0 + gns;
end

%% phase 4: voting
g0(g0 < a_v)=0;
g0(g0 >= a_v)=1;
g0