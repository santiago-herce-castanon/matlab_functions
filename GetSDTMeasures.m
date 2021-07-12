function [dprime, criterion] = GetSDTMeasures(stim,choice)
% This function computes Signal Detection Theory measures: dprime and
% criterion. It requires two vectors with binary (1 and 0) values, one
% vectoris for the stimuli, and one vector is for the choices.
% a correction of +1 and +.5 is used for avoiding division by zero.
% I made this code following Stanislaw and Todorov, 1999.

% sum the trials with signal present (or type 1 stimulus, as this need not
% be a detection task), and with signal absent (or type 0 stimulus).
signalpresent  = nansum(stim == 1) + 1  ;
signalabsent   = nansum(stim == 0) + 1  ;

% compute the number of hits (chose present when stimulus was present) and
% the number of false alarms (chose absent when the stimulus was absent).
numhits        = nansum((stim==1)&(choice==1)) + 0.5;
numfa          = nansum((stim==0)&(choice==1)) + 0.5;

% get the (normal, i.e. mean zero std 1) inverse cumulative of the hitrate
% and of the false alarm-rate
norminvhitr    = norminv( numhits./ signalpresent);
norminvfar     = norminv( numfa  ./ signalabsent);

% compute the criterion and dprime
criterion      = -0.5.*(norminvhitr+norminvfar);
dprime         = norminvhitr-norminvfar;
end