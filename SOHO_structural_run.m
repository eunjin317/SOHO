function [data] = SOHO_structural_run(screen_param, expt_param, data)  
%% Assign variables
global theWindow edfFile
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

%% Keyboard input setting
% if expt_param.dofmri
    device(1).product = 'Apple Keyboard';
    device(1).vendorID= 1452;
    apple = IDkeyboards(device(1));
% end 

%% Ready for start run
while true
    msgtxt = '잠시 후 구조촬영이 시작될 예정입니다.\n곧 나타날 화면 중앙의 + 표시를 응시하면서 편안히 계시기 바랍니다.\n준비가 완료되면 실험자는 SPACE 키를 눌러주시기 바랍니다.';
    DrawFormattedText(theWindow, double(msgtxt), 'center', 'center', white, [], [], [], 2);
    Screen('Flip', theWindow);
    
%     if expt_param.dofmri
        [~,~,keyCode] = KbCheck(apple);
%     else
%         [~,~,keyCode] = KbCheck;
%     end
    
    if keyCode(KbName('space')) == 1
        break
    elseif keyCode(KbName('q')) == 1
        abort_experiment('manual');
        break
    end
end

%% Making shuffled Heat intensity list 
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

data.dat.heat_param_structural = heat_param;

%% Adjusting time from structural scan started.
data.dat.structural_fmri_start_time = GetSecs;

Screen(theWindow, 'FillRect', bgcolor, window_rect);
Screen('TextSize', theWindow, 60);
DrawFormattedText(theWindow, double('+'), 'center', 'center', white, [], [], [], 1.2);
Screen('Flip', theWindow);
Screen('TextSize', theWindow, fontsize);

[~,~,keyCode] = KbCheck;
if keyCode(KbName('q')) == 1
    abort_experiment('manual');
end


%% Wating 15 seconds from structural scan started
waitsec_fromstarttime(data.dat.structural_fmri_start_time, 15);    % '+' screen for 15 seconds (blank screen)


%% Saving Run start time
data.dat.structural_starttime = GetSecs;
data.dat.between_fmri_structural_start_time = data.dat.structural_starttime - data.dat.structural_fmri_start_time;  % 15s
% blank screen for 15s

%% Run start
if strcmp(expt_param.run_type, 'structural') % Structural Run (Day1)
    for Trial_num = 1:expt_param.Trial_nums
        data = SOHO_structural(screen_param, expt_param, Trial_num, data, heat_param(Trial_num));
    end
end

%% Saving Data
data.dat.structural_end_time = GetSecs;
data.dat.structural_duration_time = data.dat.structural_end_time - data.dat.structural_fmri_start_time;

%% Blank screen for the rest of the time (15s)
data.dat.structural_blank_start_time = GetSecs;

Screen(theWindow, 'FillRect', bgcolor, window_rect);
Screen('TextSize', theWindow, 60);
DrawFormattedText(theWindow, double('+'), 'center', 'center', white, [], [], [], 1.2);
Screen('Flip', theWindow);
Screen('TextSize', theWindow, fontsize);

[~,~,keyCode] = KbCheck;
if keyCode(KbName('q')) == 1
    abort_experiment('manual');
end

waitsec_fromstarttime(data.dat.structural_blank_start_time, 15);    % '+' screen for 19 seconds (blank screen)

data.dat.structural_blank_end_time = GetSecs;
data.dat.structural_blank_duration_time = data.dat.structural_blank_end_time - data.dat.structural_blank_start_time;

save(data.datafile, 'data', '-append');

end    