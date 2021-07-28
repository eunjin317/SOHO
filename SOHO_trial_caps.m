function [data] = SOHO_trial_caps(screen_param, expt_param, data)
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

%% Keyboard input setting
% device(1).product = 'Magic Keyboard';
% device(1).vendorID= 76;
% apple = IDkeyboards(device(1));

%% Setting for rating
scale = ('overall_movie_int');
[lb, rb, start_center] = draw_scale_soho(scale, screen_param.window_info, screen_param.line_parameters, screen_param.color_values);
Screen(theWindow, 'FillRect', bgcolor, window_rect);

%% Initial mouse position
nowtime = clock;
basedir = expt_param.basedir;
SubjDate = sprintf('%.2d%.2d%.2d', nowtime(1), nowtime(2), nowtime(3));
load(fullfile(basedir,'location', [SubjDate, '_', sprintf('%.3d', expt_param.Run_Num-1), '_', expt_param.Run_list{expt_param.Run_Num-1}, '_location', '.mat']));

SetMouse(location,H*(1/9));

% if start_center
%     SetMouse(W/2,H/2); % set mouse at the center
% else
%     SetMouse(lb,H*(1/9)); % set mouse at the left
% end

rec_i = 0;

%% Check caps run start time
caps_run_start = GetSecs;
data.dat.caps_run_start = caps_run_start;

%% Start rating
while true
    [x,~,button] = GetMouse(theWindow);
    [lb, rb, start_center] = draw_scale_soho(scale, screen_param.window_info, screen_param.line_parameters, screen_param.color_values);
    if x < lb; x = lb; elseif x > rb; x = rb; end
    
    rating_types_soho = call_ratingtypes_soho('resting');
    DrawFormattedText(theWindow, double(rating_types_soho.prompts{1}), 'center', H*(1/5), white, [], [], [], 2);
    Screen('TextSize', theWindow, fontsize);
    Screen('DrawLine', theWindow, orange, x, H*(1/9)-scale_H/3, x, H*(1/9)+scale_H/3, 6); %rating bar
    Screen('Flip', theWindow);
    
    [~,~,keyCode] = KbCheck;
    if keyCode(KbName('q')) == 1
        abort_experiment;
        break
    end
    
    rec_i = rec_i + 1;
    
    data.dat.caps_rating(rec_i,1) = GetSecs;
    data.dat.caps_rating(rec_i,2) = (x-lb)/(rb-lb);   
  
    if GetSecs - caps_run_start > expt_param.caps_duration
        break
    end
end
location = x;

nowtime = clock;
basedir = expt_param.basedir;
SubjDate = sprintf('%.2d%.2d%.2d', nowtime(1), nowtime(2), nowtime(3));
savename = fullfile(basedir,'location', [SubjDate, '_', sprintf('%.3d', expt_param.Run_Num), '_', expt_param.Run_name, '_location', '.mat']);
save(savename, 'location');

% 300 ~ 900

%% Adjusting caps time
waitsec_fromstarttime(caps_run_start, expt_param.caps_duration)

%% Check caps finished time
data.dat.caps_run_end = GetSecs;
data.dat.caps_duration = data.dat.caps_run_end - data.dat.caps_run_start;

end