%% SOHO MAIN CODE
clear;

%%%% CHECK!! %%%%
expt_param.day= 2;
expt_param.participant_name = 'test';
expt_param.Pathway = false;
expt_param.USE_BIOPAC = false;
expt_param.dofmri = false;

% SETTING
addpath(genpath(pwd));
PATH = getenv('PATH');
%setenv('PATH', [PATH ':/Users/sungwoo320/anaconda3/bin:/Users/sungwoo320/anaconda3/condabin']); %For biopack, you need to add your python3 path
setenv('PATH', [PATH ':/Library/Frameworks/Python.framework/Versions/3.7/bin']);
basedir = pwd; 
expt_param.basedir = basedir;
expt_param.Trial_nums = 8; 
expt_param.screen_mode = 'Full'; %{'Testmode','Full'}
expt_param.USE_EYELINK = false;
expt_param.eyelink_filename = 'F_NAME'; % Eyelink file name should be equal or less than 8

expt_param.Run_Num = input('\nRun number? '); 
expt_param.run_type = input('\nRun type? ','s'); 

% day1 = 001(structural) / 002~007(heat) 
% day2 = 001(rest),002(caps),003(rest),004(rest),005(movie),006(rest)
% {'structural', 'heat'}- Day1 {'caps', 'resting', 'movie'}- Day2

if expt_param.day == 1
expt_param.Run_list = [{strcat(expt_param.participant_name,'_','structural')},...
    repmat({strcat(expt_param.participant_name,'_','heat')},1,6)]; 
else    
expt_param.Run_list = [{strcat(expt_param.participant_name,'_','resting')},...
    {strcat(expt_param.participant_name,'_','caps')},{strcat(expt_param.participant_name,'_','resting')},...
    {strcat(expt_param.participant_name,'_','resting')},{strcat(expt_param.participant_name,'_','movie')}...
    {strcat(expt_param.participant_name,'_','resting')}];  
end

expt_param.Run_name = expt_param.Run_list{expt_param.Run_Num};  
expt_param.heat_intensity_table = [45, 46, 47, 48]; % stimulus intensity
expt_param.jitter_time_table = [1, 3, 6, 11]; % jitter time
expt_param.structural_duration = 52; % 10+12+30
expt_param.heat_duration = 76; % 76 = 4+12+60 (real)

expt_param.caps_duration = 840; 
expt_param.resting_duration = 840; 
expt_param.movie_duration = 579; % 9min 39s
expt_param.movie_run_duration = 840; % 840 = 14min (real)
expt_param.moviefile = fullfile(basedir, 'video.mp4');

global ip port
ip = '192.168.0.2'; 
port = 20121;

% randomize skin site
if contains(expt_param.run_type,'structural')    
    rng('shuffle')
    arr = 1:6;
    sample_index = datasample(arr, length(arr), 'Replace',false);
    shuffled_skinsite_list = arr(sample_index)   
    expt_param.skinsite = shuffled_skinsite_list;
end

%% Start experiment
data = SOHO_data_save(expt_param, basedir);
data.expt_param = expt_param;
data.dat.experiment_start_time = GetSecs; 

screen_param = SOHO_setscreen(expt_param);

if expt_param.Run_Num == 001
    SOHO_explain(screen_param);    
    SOHO_practice(screen_param);
end

if contains(expt_param.run_type,'structural')
    data = SOHO_structural_run(screen_param, expt_param, data);   % structural scan(Day1)
else
    data = SOHO_run(screen_param, expt_param, data);    % heat(Day1)/caps(Day2)/resting(Day2)
end

if expt_param.day == 2
    data = SOHO_postrun_survey(screen_param, expt_param, data);
end

data = SOHO_close(screen_param, expt_param, data);