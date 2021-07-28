function [data] = SOHO_run(screen_param, expt_param, data)  
%% Assign variables
global theWindow edfFile
global ip port;
font = screen_param.window_info.font ;
fontsize = screen_param.window_info.fontsize;
theWindow = screen_param.window_info.theWindow;
window_num = screen_param.window_info.window_num ;
window_rect = screen_param.window_info.window_rect;
H = screen_param.window_info.H ;
W = screen_param.window_info.W;

lb1 = screen_param.line_parameters.lb1 ;
lb2 = screen_param.line_parameters.lb2 ;
rb1 = screen_param.line_parameters.rb1;
rb2 = screen_param.line_parameters.rb2;
scale_H = screen_param.line_parameters.scale_H ;
scale_W = screen_param.line_parameters.scale_W;
anchor_lms = screen_param.line_parameters.anchor_lms;

bgcolor = screen_param.color_values.bgcolor;
orange = screen_param.color_values.orange;
red = screen_param.color_values.red;
white = screen_param.color_values.white;  
blue = screen_param.color_values.blue;  

%% SETUP: Eyelink
% need to be revised when the eyelink is here.
% It located after open screen
if expt_param.USE_EYELINK
    %eyelink_filename = 'F_NAME'; % name should be equal or less than 8
    %edf_filename = ['M_' new_SID '_' num2str(runNbr)];
    edfFile = sprintf('%s.EDF', expt_param.eyelink_filename);
    eyelink_main(edfFile, 'Init');
    
    status = Eyelink('Initialize');
    if status
        error('Eyelink is not communicating with PC. Its okay baby.');
    end
    Eyelink('Command', 'set_idle_mode');
    waitsec_fromstarttime(GetSecs, 0.5);
end

%% Keyboard input setting
% if expt_param.dofmri
    device(1).product = 'Apple Keyboard';
    device(1).vendorID= 1452;
    apple = IDkeyboards(device(1));
% end 

%% Ready for start run
while true
    msgtxt = '\n모두 준비되었으면, a를 눌러주세요.\n\n (Check Eyelink, Biopack, etc...)\n\n';
    DrawFormattedText(theWindow, double(msgtxt), 'center', 'center', white, [], [], [], 2);
    Screen('Flip', theWindow);
    
%     if expt_param.dofmri
        [~,~,keyCode] = KbCheck(apple);
%     else
%         [~,~,keyCode] = KbCheck;
%     end
    
    if keyCode(KbName('a')) == 1
        break
    elseif keyCode(KbName('q')) == 1
        abort_experiment('manual');
        break
    end
end

% ===== Scanner trigger setting
if expt_param.dofmri
    device(2).product = 'KeyWarrior8 Flex';
    device(2).vendorID= 1984;
    scanner = IDkeyboards(device(2));
end

%% Before starting each run (scan), give high temperature heat (3+12s) - in heat trial
if strcmp(expt_param.run_type, 'heat') % Heat Run (Day1)
    data.dat.pre_heat_starttime = GetSecs;
    wait_pre_state = 3;
    wait_after_stimulus = wait_pre_state + 12;
    
    % -------------Setting Pathway------------------
    if expt_param.Pathway
        main(ip,port,1, 70);     % select the program
    end
    waitsec_fromstarttime(data.dat.pre_heat_starttime, wait_pre_state-2)
    
    % -------------Ready for Pathway------------------
    if expt_param.Pathway
        main(ip,port,2); %ready to pre-start
    end
    waitsec_fromstarttime(data.dat.pre_heat_starttime, wait_pre_state) % Because of wait_pathway_setup-2, this will be 2 seconds
    
    % Heat pain stimulus
    if ~expt_param.Pathway
        Screen(theWindow, 'FillRect', bgcolor, window_rect);
        DrawFormattedText(theWindow, double(num2str(48)), 'center', 'center', white, [], [], [], 1.2);
        Screen('Flip', theWindow);
    end
    
    % Check stimulus start time
    data.dat.pre_heat_trigger_start = GetSecs;
    
    % ------------- start to trigger thermal stimulus------------------
    if expt_param.Pathway
        Screen(theWindow, 'FillRect', bgcolor, window_rect);
        Screen('TextSize', theWindow, 60);
        DrawFormattedText(theWindow, double('+'), 'center', 'center', white, [], [], [], 1.2);
        Screen('Flip', theWindow);
        Screen('TextSize', theWindow, fontsize);
        main(ip,port,2);
    end
    
    data.dat.pre_heat_trigger_end = GetSecs;
    waitsec_fromstarttime(data.dat.pre_heat_starttime, wait_after_stimulus)
    
    data.dat.pre_heat_end = GetSecs;
    
    while true
        msgtxt = '\nresume(r) \n\n continue(c)';
        DrawFormattedText(theWindow, double(msgtxt), 'center', 'center', white, [], [], [], 2);
        Screen('Flip', theWindow);
        
        if expt_param.dofmri
            [~,~,keyCode] = KbCheck(apple);
        else
            [~,~,keyCode] = KbCheck;
        end
        
        if keyCode(KbName('c')) == 1
            break
        elseif keyCode(KbName('r')) == 1           
            data.dat.pre_heat_starttime_2 = GetSecs;
            wait_pre_state = 3;
            wait_after_stimulus = wait_pre_state + 12;
            
            % -------------Setting Pathway------------------
            if expt_param.Pathway
                main(ip,port,1, 70);     % select the program
            end
            waitsec_fromstarttime(data.dat.pre_heat_starttime_2, wait_pre_state-2)
            
            % -------------Ready for Pathway------------------
            if expt_param.Pathway
                main(ip,port,2); %ready to pre-start
            end
            waitsec_fromstarttime(data.dat.pre_heat_starttime_2, wait_pre_state) % Because of wait_pathway_setup-2, this will be 2 seconds
            
            % Heat pain stimulus
            if ~expt_param.Pathway
                Screen(theWindow, 'FillRect', bgcolor, window_rect);
                DrawFormattedText(theWindow, double(num2str(48)), 'center', 'center', white, [], [], [], 1.2);
                Screen('Flip', theWindow);
            end
            
            % Check stimulus start time
            data.dat.pre_heat_trigger_start_2 = GetSecs;
            
            % ------------- start to trigger thermal stimulus------------------
            if expt_param.Pathway
                Screen(theWindow, 'FillRect', bgcolor, window_rect);
                Screen('TextSize', theWindow, 60);
                DrawFormattedText(theWindow, double('+'), 'center', 'center', white, [], [], [], 1.2);f
                Screen('Flip', theWindow);
                Screen('TextSize', theWindow, fontsize);
                main(ip,port,2);
            end
            
            data.dat.pre_heat_trigger_end_2 = GetSecs;
            waitsec_fromstarttime(data.dat.pre_heat_starttime_2, wait_after_stimulus)
            
            data.dat.pre_heat_end_2 = GetSecs;      
            break
        end    
    end
end

%% Waiting for 's' or 't' key
while true
    msgtxt = '\n스캔(s) \n\n 테스트(t)';
    DrawFormattedText(theWindow, double(msgtxt), 'center', 'center', white, [], [], [], 2);
    Screen('Flip', theWindow);
    
    if expt_param.dofmri
        [~,~,keyCode] = KbCheck(scanner);
        [~,~,keyCode2] = KbCheck(apple);
    else
        [~,~,keyCode] = KbCheck(apple);
    end
    % If it is for fMRI experiment, it will start with "s",
    % But if it is test time, it will start with "t" key.
    if expt_param.dofmri
        if keyCode(KbName('s'))==1
            break
        elseif keyCode2(KbName('q'))==1
            abort_experiment;
        end
    else
        if keyCode(KbName('t'))==1
            break
        elseif keyCode(KbName('q'))==1
            abort_experiment;
        end
    end
end

%% fMRI starts
data.dat.fmri_start_time = GetSecs;
if expt_param.dofmri
    Screen(theWindow, 'FillRect', bgcolor, window_rect);
    DrawFormattedText(theWindow, double('스캔이 시작됩니다.'), 'center', 'center', white, [], [], [], 1.2);
    Screen('Flip', theWindow);
    waitsec_fromstarttime(data.dat.fmri_start_time, 5);  % after getting 's', wait for 5 seconds
end


%% SETUP: BIOPAC and EYELINK
if expt_param.USE_BIOPAC
    bio_trigger_range = num2str(data.expt_param.Run_Num * 0.2 + 4);
    command = 'python3 labjack.py ';
    full_command = [command bio_trigger_range];
    data.dat.biopac_start_trigger_s = GetSecs;
    
    Screen(theWindow,'FillRect',bgcolor, window_rect);
    Screen('Flip', theWindow);
    unix(full_command)
%     unix('python3 labjack.py 3')
    data.dat.biopac_start_trigger_e = GetSecs;
    data.dat.biopac_start_trigger_dur = data.dat.biopac_start_trigger_e - data.dat.biopac_start_trigger_s;
end

if expt_param.USE_EYELINK
    Eyelink('StartRecording');
    data.dat.eyetracker_starttime = GetSecs; % eyelink timestamp
    Eyelink('Message','Run start');
end

%% Making shuffled Heat intensity list 
if strcmp(expt_param.run_type, 'heat') % Heat Run (Day1)
    quotient = fix(expt_param.Trial_nums/length(expt_param.heat_intensity_table));
    remainder = mod(expt_param.Trial_nums, length(expt_param.heat_intensity_table));
    
    %Error handling
    if not(remainder==0)
        error('Value error! \nmod(Trial_nums, length(expt_param.heat_intensity_table)) have to be 0 which is now mod(%d, %d)=%d', ...
            expt_param.Trial_nums, length(expt_param.heat_intensity_table), remainder);
    end
    
    if not(mod(quotient, 2)==0)
        error('Value error! \nmod(fix(Trial_nums/length(expt_param.heat_intensity_table)),2) have to be 0 which is now mod(%d, 2) = %d', ...
            quotient, mod(quotient, 2));
    end
    
    heat_program_table = [];
    for i = 1:quotient
        heat_program_table = [heat_program_table expt_param.heat_intensity_table];
    end
    
    rng('shuffle')
    arr = 1:length(heat_program_table);
    sample_index = datasample(arr, length(arr), 'Replace',false);
    
    shuffled_heat_list = heat_program_table(sample_index);
    % shuffled_type_list = trial_type(sample_index);
    
    % Making pathway program list
    PathPrg = load_PathProgram('MPC');
    
    for mm = 1:length(shuffled_heat_list)
        index = find([PathPrg{:,1}] == shuffled_heat_list(mm));
        heat_param(mm).program = PathPrg{index, 4};
        heat_param(mm).intensity = shuffled_heat_list(mm);
    end
    
    data.dat.heat_param = heat_param;
end

%% Making shuffled jitter list 
if strcmp(expt_param.run_type, 'heat') % Heat Run (Day1)
    quotient = fix(expt_param.Trial_nums/length(expt_param.jitter_time_table));
    remainder = mod(expt_param.Trial_nums, length(expt_param.jitter_time_table));
    
    jitter = [];
    for i = 1:quotient
        jitter = [jitter expt_param.jitter_time_table];
    end
    
    rng('shuffle')
    arr = 1:length(jitter);
    sample_index = datasample(arr, length(arr), 'Replace',false);
    
    shuffled_jitter_list = jitter(sample_index)
    
    data.dat.jitter_list = shuffled_jitter_list;
end

%% Adjusting time from fmri started.
Screen(theWindow, 'FillRect', bgcolor, window_rect);
Screen('TextSize', theWindow, 60);
DrawFormattedText(theWindow, double('+'), 'center', 'center', white, [], [], [], 1.2);
Screen('Flip', theWindow);
Screen('TextSize', theWindow, fontsize);

[~,~,keyCode] = KbCheck;
if keyCode(KbName('q')) == 1
    abort_experiment('manual');
end


%% Wating 13 seconds from fmri started
waitsec_fromstarttime(data.dat.fmri_start_time, 13);    % '+' screen for 13 seconds (disdaq)


%% Saving Run start time
data.dat.run_starttime = GetSecs;
data.dat.between_fmri_run_start_time = data.dat.run_starttime - data.dat.fmri_start_time;  % 13s
% disdaq

%% Run start
if strcmp(expt_param.run_type, 'heat') % Heat Run (Day1)
    for Trial_num = 1:expt_param.Trial_nums
        data = SOHO_trial_heat(screen_param, expt_param, Trial_num, data, heat_param(Trial_num), shuffled_jitter_list(Trial_num));
    end

elseif strcmp(expt_param.run_type, 'caps') % CAPS Run (Day2)
    data = SOHO_trial_caps(screen_param, expt_param, data);
    
elseif strcmp(expt_param.run_type, 'movie') % Movie Run (Day2)
    data = SOHO_trial_movie(screen_param, expt_param, data);
    
else % Resting Run (Day2)
    data = SOHO_trial_resting(screen_param, expt_param, data);
end


%% Shutdown eyelink, Saving Biopack end time
if expt_param.USE_EYELINK
    Eyelink('Message','Run ends');
    eyelink_main(edfFile, 'Shutdown');
    data.dat.eyelink_endtime = GetSecs;
end

if expt_param.USE_BIOPAC %end BIOPAC
    bio_trigger_range = num2str(data.expt_param.Run_Num * 0.2 + 1);
    command = 'python3 labjack.py ';
    full_command = [command bio_trigger_range];
    
    data.dat.biopac_end_trigger_s = GetSecs;
    Screen(theWindow,'FillRect',bgcolor, window_rect);
    Screen('Flip', theWindow);
    unix(full_command)
%     unix('python3 labjack.py 1')

    data.dat.biopac_end_trigger_e = GetSecs;
    data.dat.biopac_end_trigger_dur = data.dat.biopac_end_trigger_e - data.dat.biopac_end_trigger_s;
end

data.dat.run_end_time = GetSecs;
data.dat.run_duration_time = data.dat.run_end_time - data.dat.run_starttime;

%% Saving Data
save(data.datafile, 'data', '-append');

end    