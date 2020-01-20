%% General experimenter launcher
%  =============================
% By :      Martin SZINTE
% Projet :  pMFexp
% With :    Vanessa Morita, Anna MONTAGNINI & Guillaume MASSON
% Version:  1.0

% Version description
% ===================
% Experiment in which we try to adapt pRF methods to eye movement task.
% To do so, participants are invited to prepare sequences of smooth pursuit
% and saccadic eye movements across the screen

% pRF adaptation to do
% --------------------
% kick out mention of 2 acquisitions, keep 1.2 mm
% const.run_txt in sbjConfig.m instead of dirSaveFile
% 16 vertical and horizontal steps instead of 18
% 16 TR for blank

% design idea
% -----------
% 0.800 ms of smooth pursuit
% 400 ms of fixation
% 400 ms to do return saccade
% 16 directions clockwise spread by 22.5 deg or pi/8
% 4 amplitudes 4, 6, 8, 10 dva giving 5, 7.5, 10, 12.5 dva/s smooth pursuit
% 9 sequences, sequence no 1, 3, 5, 7 and 9 are breaks
%              sequence no 2, 4, 6 and 8 are eye movement sequences
% randomize order of amplitude per subjects

% To do
% -----
% 0. clear all functions not used
% 1. change instructions
% 2. check correct results with and without eyelink 
% 1. eye movement analysis

% First settings
% --------------
Screen('CloseAll');clear all;clear mex;clear functions;close all;home;AssertOpenGL;

% General settings
% ----------------
const.expName           =   'pMFexp';       % experiment name.
const.expStart          =   0;              % Start of a recording exp                          0 = NO  , 1 = YES
const.checkTrial        =   0;              % Print trial conditions (for debugging)            0 = NO  , 1 = YES
const.writeLogTxt       =   1;              % write a log file in addition to eyelink file      0 = NO  , 1 = YES
const.mkVideo           =   0;              % Make a video of a run                             0 = NO  , 1 = YES

% External controls
% -----------------
const.tracker           =   0;              % run with eye tracker                              0 = NO  , 1 = YES
const.scanner           =   0;              % run in MRI scanner                                0 = NO  , 1 = YES
const.scannerTest       =   1;              % run with T returned at TR time                    0 = NO  , 1 = YES
const.room              =   2;              % run in MRI or eye-tracking room                   1 = MRI , 2 = eye-tracking

% Run order
% ---------
const.cond_run_order = [1;1;...             % run 01 - EyeMov_run01      run 02 - EyeMov_run02
                        1;1;...             % run 03 - EyeMov_run03      run 04 - EyeMov_run04
                        1;1;...             % run 05 - EyeMov_run05      run 06 - EyeMov_run06
                        1;1;...             % run 07 - EyeMov_run07      run 08 - EyeMov_run08
                        1;1];               % run 09 - EyeMov_run09      run 10 - EyeMov_run10

% Run number per condition
% ------------------------
const.cond_run_num =  [01;02;...
                       03;04;...
                       05;06;...
                       07;08;...
                       09;10];

% Desired screen setting
% ----------------------
const.desiredFD         =   120;            % Desired refresh rate
%fprintf(1,'\n\n\tDon''t forget to change before testing\n');
const.desiredRes        =   [1920,1080];    % Desired resolution

% Path
% ----
dir                     =   (which('expLauncher'));
cd(dir(1:end-18));

% Add Matlab path
% ---------------
addpath('config','main','conversion','eyeTracking','instructions','trials','stim','stats');

% Subject configuration
% ---------------------
[const]                 =   sbjConfig(const);
                        
% Main run
% --------
main(const);

% Analyse data
% ------------
% if const.runNum > 2;        res = input(sprintf('\n\tPlot results? YES (1) NO (0) : '));
% elseif const.runNum == 10;  res = 1;
% else                        res = 1;
% end
% if res; behav_results(const.sjct,const.runNum,const.tracker); end