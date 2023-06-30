clear all,clc,close all;
data = xlsread('liver.xlsx');
data = data(:,2:end);
basic_info = data(:,1:2);
before = data(:,3:11);
before = [before,data(:,33)]; %+术前治疗

% during = data(:,12:31);
diameter = data(:,17:19); % 肿瘤直径n*3
treat = data(:,34:37); % 术后治疗n*4

during = [data(12:16), data(20:31)];
fushui = data(:,12);
ganyinghua = data(:,13);
ganyinghuajiejie = data(:,14);
datiaishuan = data(:,15);
zhongliushumu = data(:,16)
zuidajingzhihe = data(:,20);
zhongliubaomo = data(:,21);
zhongliuqieyuan = data(:,22);
shuzhongchuxie = data(:,23);
shifoushuxie = data(:,24);
ganmenzuduan = data(:,25);
xibaoleixing = data(:,26);
feihuachengdu = data(:,27);
jingxiaganyinghua = data(:,28);
Gpingfen = data(:,29);
Spingfen = data(:,30);
jingxiaaishuan = data(:,31);

after =  data(:,38:41);