function [expDes]=designConfig(const)
% ----------------------------------------------------------------------
% [expDes]=designConfig(const)
% ----------------------------------------------------------------------
% Goal of the function :
% Define experimental design
% ----------------------------------------------------------------------
% Input(s) :
% const : struct containing constant configurations
% ----------------------------------------------------------------------
% Output(s):
% expDes : struct containg experimental design
% ----------------------------------------------------------------------
% Function created by Martin SZINTE (martin.szinte@gmail.com)
% Last update : 20 / 01 / 2020
% Project :     pMFexp
% Version :     1.0
% ----------------------------------------------------------------------

%% Experimental random variables

% Cond 1 : task (1 modality)
% =======
expDes.oneC             =   1;
expDes.txt_cond1        =   {'eyemov'};
% 01 = task on bar


% Var 1 : trial types (3 modalities)
% ======
expDes.oneV             =   [1;2;3];
expDes.txt_var1         =   {'pursuit','saccade','fixation'};
% 01 = smooth pursuit
% 02 = return saccade
% 03 = fixation

% Var 2 : eye movement amplitude (5 modalities)
% ======
expDes.twoV             =   [1;2;3;4;5];
expDes.txt_var2         =   {'2.5 dva','5 dva','7.5 dva','10 dva','none'};
% 01 = 4 dva
% 02 = 6 dva
% 03 = 8 dva
% 04 = 10 dva
% 05 = none

% Var 3 : eye movement direction (33 modalities)
% ======
expDes.threeV           =   [01;17;02;18;03;19;04;20;...
                             05;21;06;22;07;23;08;24;...
                             09;25;10;26;11;27;12;28;...
                             13;29;14;30;15;31;16;32;33];
expDes.txt_var3=   {'0 deg',  '22.5 deg',  '45 deg', '67.5 deg', '90 deg','112.5 deg', '135 deg','157.5 deg',...
                    '180 deg','202.5 deg','225 deg','247.5 deg','270 deg','292.5 deg', '315 deg','337.5 deg',...
                    '180 deg','202.5 deg','225 deg','247.5 deg','270 deg','292.5 deg', '315 deg','337.5 deg',...
                    '0 deg',  '22.5 deg',  '45 deg', '67.5 deg', '90 deg','112.5 deg', '135 deg','157.5 deg',...
                    'none'};
% 01 =   0.0 deg    02 = 180.0 deg
% 03 =  22.5 deg    04 = 202.5 deg
% 05 =  45.0 deg    06 = 225.0 deg
% 07 =  67.5 deg    08 = 247.5 deg
% 09 =  90.0 deg    10 = 270.0 deg
% 11 = 112.5 deg    12 = 292.5 deg
% 13 = 135.0 deg    14 = 315.0 deg
% 15 = 157.5 deg    16 = 337.5 deg
% 17 = 180.0 deg    18 =   0.0 deg
% 19 = 202.5 deg    20 =  22.5 deg
% 21 = 225.0 deg    22 =  45.0 deg
% 23 = 247.5 deg    24 =  67.5 deg
% 25 = 270.0 deg    26 =  90.0 deg
% 27 = 292.5 deg    28 = 112.5 deg
% 29 = 315.0 deg    30 = 135.0 deg
% 31 = 337.5 deg    32 = 157.5 deg
% 33 = none

% seq order
% ---------
if const.runNum == 1
    % create sequence order
    amp_sequence.eyemov_val = expDes.twoV(randperm(numel(expDes.twoV)-1));
    amp_sequence.val = [5;amp_sequence.eyemov_val(1);...
                        5;amp_sequence.eyemov_val(2);...
                        5;amp_sequence.eyemov_val(3);...
                        5;amp_sequence.eyemov_val(4);5];
    
    expDes.amp_sequence = amp_sequence.val;
    save(const.amp_sequence_file,'amp_sequence');
else
    % load staircase of previous blocks
    load(const.amp_sequence_file);
    expDes.amp_sequence   =   amp_sequence.val;
end
%% Experimental configuration :
expDes.nb_cond          =   2;
expDes.nb_var           =   3;
expDes.nb_rand          =   0;
expDes.nb_list          =   0;

%% Experimental loop
rng('default');rng('shuffle');
runT                    =   const.runNum;

t_trial = 0;
for t_seq = 1:size(const.eyemov_seq,2)
    
    cond1 = const.cond1;
    rand_var2 =   expDes.amp_sequence(t_seq);
    
    if rand_var2 == 5
        seq_steps = const.blk_step;
    else
        seq_steps = const.eyemov_step;
    end
    
    for seq_step = 1:seq_steps
        if rand_var2 == 5
            rand_var1 = expDes.oneV(end);
            rand_var3 = expDes.threeV(end);
        else
            if mod(seq_step,2)
                rand_var1 = 1;
            else
                rand_var1 = 2;
            end
            rand_var3 = expDes.threeV(seq_step);
        end
    
        t_trial     =   t_trial + 1;
        
        expDes.expMat(t_trial,:)=   [   runT,           t_trial,        cond1,          rand_var1,      rand_var2,  ...
                                        rand_var3,      t_seq,          seq_step,       NaN,            NaN];
        % col 01:   Run number
        % col 02:   Trial number
        % col 03:   Task
        % col 04:   Eye mov type
        % col 05:   Eye mov amplide
        % col 06:   Eye mov direction
        % col 07:   Sequence number
        % col 08:   Sequence trial
        % col 09:   Trial onset time
        % col 10:   Trial offset time
    end
end
expDes.nb_trials = size(expDes.expMat,1);

end