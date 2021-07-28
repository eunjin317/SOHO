function [data] = SOHO_structural(screen_param, expt_param, Trial_num, data, heat_param)
global ip port;

%% Assign variables
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

%% Wait secs parameters
baseline = 10;
rest = 30;
iti = 1;

wait_after_iti = iti;
wait_baseline = baseline;

wait_after_stimulus = wait_baseline + 12;
wait_after_rest = wait_after_stimulus + rest;

%% Adjusting between trial time
if Trial_num > 1
    waitsec_fromstarttime(data.dat.structural_rating_end(Trial_num-1), wait_after_iti)
else
    waitsec_fromstarttime(data.dat.structural_starttime(Trial_num), wait_after_iti)
end

%% Checking trial start time
data.dat.structural_trial_starttime(Trial_num) = GetSecs;
data.dat.between_structural_run_trial_starttime(Trial_num) = data.dat.structural_trial_starttime(Trial_num) - data.dat.structural_starttime(1);

%% Data recording
Screen(theWindow, 'FillRect', bgcolor, window_rect);
data.dat.structural_heat_rest_value(Trial_num) = rest;

%% keyboard input setting
% device(1).product = 'Magic Keyboard';
% device(1).vendorID= 76;
% apple = IDkeyboards(device(1));
        
%% Heat pain stimulus
if ~expt_param.Pathway
    Screen(theWindow, 'FillRect', bgcolor, window_rect);
    DrawFormattedText(theWindow, double(num2str(heat_param.intensity)), 'center', 'center', white, [], [], [], 1.2);
    Screen('Flip', theWindow);
end

%% Setting for rating
rating_types_soho = call_ratingtypes_soho('resting');

scale = ('overall_int');
[lb, rb, start_center] = draw_scale_soho(scale, screen_param.window_info, screen_param.line_parameters, screen_param.color_values);
Screen(theWindow, 'FillRect', bgcolor, window_rect);

%% Initial mouse position
if Trial_num == 1
    if start_center
        SetMouse(W/2,H/2); % set mouse at the center
    else
        SetMouse(lb,H/2); % set mouse at the left
    end
end

rec_i = 0;

%% Continuous rating start and start time
structural_rating_start(Trial_num) = GetSecs;
data.dat.structural_rating_start(Trial_num) = structural_rating_start(Trial_num);

setting_point = true;
pre_heat_point = true;
heat_start_point = true;

while true
    [x,~,button] = GetMouse(theWindow);
    [lb, rb, start_center] = draw_scale_soho(scale, screen_param.window_info, screen_param.line_parameters, screen_param.color_values);
    if x < lb; x = lb; elseif x > rb; x = rb; end
    
        % ------------- baseline(first 5s) ------------------
    if GetSecs - structural_rating_start(Trial_num) < wait_baseline-5
        rating_types_soho = call_ratingtypes_soho('resting');
        DrawFormattedText(theWindow, double(rating_types_soho.prompts{1}), 'center', H*(1/4), orange, [], [], [], 2);
%         DrawFormattedText(theWindow, double('baseline'), 'center', H*(4/10), orange, [], [], [], 2);
        Screen('TextSize', theWindow, fontsize);
        Screen('DrawLine', theWindow, orange, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6); %rating bar
        Screen('Flip', theWindow);
        
            % -------------Setting Pathway ------------------
        if setting_point == true
            if expt_param.Pathway
                tic;
                main(ip,port,1, heat_param.program);     % select the program
                data.dat.structural_heat_stim_setting_toc(Trial_num) = toc;
            end
            setting_point = false;
        end
        
        data.dat.structural_heat_stim_former_baseline_end(Trial_num) = GetSecs;
        
        % ------------- baseline(latter 5s) ------------------
    elseif GetSecs - structural_rating_start(Trial_num) < wait_baseline
        rating_types_soho = call_ratingtypes_soho('resting');
        DrawFormattedText(theWindow, double(rating_types_soho.prompts{1}), 'center', H*(1/4), orange, [], [], [], 2);
%         DrawFormattedText(theWindow, double('baseline'), 'center', H*(4/10), orange, [], [], [], 2);
        Screen('TextSize', theWindow, fontsize);
        Screen('DrawLine', theWindow, orange, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6); %rating bar
        Screen('Flip', theWindow);        
        
            % -------------Ready for Pathway ------------------
        if pre_heat_point == true
            if expt_param.Pathway
                tic;
                main(ip,port,2); %ready to pre-start
                data.dat.structural_heat_stim_preheat_toc(Trial_num) = toc;
            end
            pre_heat_point = false;
        end
        
        data.dat.structural_heat_stim_latter_baseline_end(Trial_num) = GetSecs;
        
        % ------------- start to trigger thermal stimulus(12s) ------------------
    elseif GetSecs - structural_rating_start(Trial_num) < wait_after_stimulus
        rating_types_soho = call_ratingtypes_soho('resting');
        DrawFormattedText(theWindow, double(rating_types_soho.prompts{1}), 'center', H*(1/4), white, [], [], [], 2);
%         DrawFormattedText(theWindow, double('heat pain'), 'center', H*(4/10), orange, [], [], [], 2);
        Screen('TextSize', theWindow, fontsize);
        Screen('DrawLine', theWindow, orange, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6); %rating bar
        Screen('Flip', theWindow);
        
        if heat_start_point == true
            if expt_param.Pathway
                tic;
                main(ip,port,2);
                data.dat.structural_heat_stim_trigger_toc(Trial_num) = toc;
                data.dat.structural_heat_stim_trigger_start(Trial_num) = GetSecs;
            end
            heat_start_point = false;
        end
        
        data.dat.structural_heat_stim_trigger_end(Trial_num) = GetSecs;
        
        % ------------- rest(30s) ------------------
    elseif GetSecs - structural_rating_start(Trial_num) < wait_after_rest
        rating_types_soho = call_ratingtypes_soho('resting');
        DrawFormattedText(theWindow, double(rating_types_soho.prompts{1}), 'center', H*(1/4), white, [], [], [], 2);
%         DrawFormattedText(theWindow, double('rest'), 'center', H*(4/10), orange, [], [], [], 2);
        Screen('TextSize', theWindow, fontsize);
        Screen('DrawLine', theWindow, orange, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6); %rating bar
        Screen('Flip', theWindow);
        
        data.dat.structural_heat_stim_rest_end(Trial_num) = GetSecs;
        
    elseif GetSecs - structural_rating_start(Trial_num) == wait_after_rest
        data.dat.structural_heat_stim_jitter_end(Trial_num) = GetSecs;
        
        % %     else
        % %         rating_types_soho = call_ratingtypes_soho('resting');
        % %         DrawFormattedText(theWindow, double(rating_types_soho.prompts{1}), 'center', H*(1/4), white, [], [], [], 2);
        % %         Screen('TextSize', theWindow, fontsize);
        % %         Screen('DrawLine', theWindow, orange, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6); %rating bar
        % %         Screen('Flip', theWindow);
    end
    
    rec_i = rec_i + 1;
    
    % %         if button(1)
    % %             while button(1)
    % %                 [~,~,button] = GetMouse(theWindow);
    % %             end
    % %             break
    % %         end
    
%     [~,~,keyCode] = KbCheck(apple);
%     if keyCode(KbName('q')) == 1
%         abort_experiment('manual');
%         break
%     end
    
    data.dat.structural_heat_rating{Trial_num}(rec_i,1) = GetSecs;
    data.dat.structural_heat_rating{Trial_num}(rec_i,2) = (x-lb)/(rb-lb);
    if GetSecs - data.dat.structural_trial_starttime(Trial_num) > expt_param.structural_duration
        break
    end
end

%% Saving rating and time
structural_rating_end(Trial_num) = GetSecs;
structural_rating_duration(Trial_num) = structural_rating_end(Trial_num) - structural_rating_start(Trial_num);

data.dat.structural_heat_stim_baseline_dur(Trial_num) = data.dat.structural_heat_stim_latter_baseline_end(Trial_num) - data.dat.structural_rating_start(Trial_num);
data.dat.structural_heat_stim_deliver_dur(Trial_num) = data.dat.structural_heat_stim_trigger_end(Trial_num) - data.dat.structural_heat_stim_latter_baseline_end(Trial_num);
data.dat.structural_heat_stim_rest_dur(Trial_num) = data.dat.structural_heat_stim_rest_end(Trial_num) - data.dat.structural_heat_stim_trigger_end(Trial_num);

data.dat.structural_rating_end(Trial_num) = structural_rating_end(Trial_num);
data.dat.structural_rating_duration(Trial_num) = structural_rating_duration(Trial_num);
end