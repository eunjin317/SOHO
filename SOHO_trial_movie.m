function [data] = SOHO_trial_movie(screen_param, expt_param, data)
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

%% Setting movie parameter and load movie
playmode = 1;

data.dat.movie_dir = {expt_param.moviefile};

movie_start = 0;
[moviePtr] = Screen('OpenMovie', theWindow, expt_param.moviefile);

%% Wait secs parameters
pre_state = 15;
data.dat.pre_state_value = pre_state;
wait_after_movie = pre_state + expt_param.movie_duration;
wait_after_post_state = expt_param.movie_run_duration;

%% Check movie run start time
Screen('SetMovieTimeIndex', moviePtr, movie_start);
Screen('PlayMovie', moviePtr, playmode); %Screen('PlayMovie?')% 0 == Stop playback, 1 == Normal speed forward, -1 == Normal speed backward,

movie_run_start = GetSecs;
data.dat.movie_run_start = movie_run_start;

%% Initial mouse position
nowtime = clock;
basedir = expt_param.basedir;
SubjDate = sprintf('%.2d%.2d%.2d', nowtime(1), nowtime(2), nowtime(3));
load(fullfile(basedir,'location', [SubjDate, '_', sprintf('%.3d', expt_param.Run_Num-1), '_', expt_param.Run_list{expt_param.Run_Num-1}, '_location', '.mat']));

SetMouse(location,H*(1/9));

% if start_center
%     SetMouse(W/2,H/2); % set mouse at the center
% else
%     SetMouse(lb,H/2); % set mouse at the left
% end

rec_i = 0;

rating_types_soho = call_ratingtypes_soho('resting');

%% Start rating
while true
    [x,~,button] = GetMouse(theWindow);
    [lb, rb, start_center] = draw_scale_soho(scale, screen_param.window_info, screen_param.line_parameters, screen_param.color_values);
    if x < lb; x = lb; elseif x > rb; x = rb; end
    
    % ------------- only rating(first 15s) ------------------
    if GetSecs - movie_run_start < pre_state
        Screen('TextSize', theWindow, fontsize);
        Screen('DrawLine', theWindow, orange, x, H*(1/9)-scale_H/3, x, H*(1/9)+scale_H/3, 6); %rating bar
        DrawFormattedText(theWindow, double(rating_types_soho.prompts{1}), 'center', H*(1/5), white, [], [], [], 2);
        
        Screen('Flip', theWindow);

        data.dat.movie_pre_state = GetSecs;
        
    elseif GetSecs - movie_run_start < wait_after_movie      
        while true            
            [x,~,button] = GetMouse(theWindow);
            [lb, rb, start_center] = draw_scale_soho(scale, screen_param.window_info, screen_param.line_parameters, screen_param.color_values);
            if x < lb; x = lb; elseif x > rb; x = rb; end

            tex = Screen('GetMovieImage', theWindow, moviePtr);   %playing movie
           
            Screen('TextSize', theWindow, fontsize);
            Screen('DrawLine', theWindow, orange, x, H*(1/9)-scale_H/3, x, H*(1/9)+scale_H/3, 6); %rating bar
%             DrawFormattedText(theWindow, double(rating_types_soho.prompts{1}), 'center', H*(1/9), white, [], [], [], 2);

%             Screen('Flip', theWindow);
            
            if tex > 0
%                 Screen('DrawTexture', theWindow, tex, [0 0 400 300],[],[]);
                Screen('DrawTexture', theWindow, tex);
%                 DrawFormattedText(theWindow, double(rating_types_soho.prompts{1}), 'center', H*(1/6), white, [], [], [], 2);
                Screen('Flip', theWindow);
                Screen('Close', tex);
            end
            
            rec_i = rec_i + 1;
            data.dat.movie_rating(rec_i,1) = GetSecs;
            data.dat.movie_rating(rec_i,2) = (x-lb)/(rb-lb);
            
%             sprintf('movie: %d',rec_i)
            
            if tex <= 0  % closing movie has loading time
                break;
            end          
        end
               
        data.dat.movie_rating_end = GetSecs;
        
%         Screen('PlayMovie',moviePtr,0);      
%         Screen('CloseAll');
%         Screen('CloseMovie',moviePtr);
%         Screen('Flip', theWindow);

    elseif GetSecs - movie_run_start < wait_after_post_state
        Screen('TextSize', theWindow, fontsize);
        Screen('DrawLine', theWindow, orange, x, H*(1/9)-scale_H/3, x, H*(1/9)+scale_H/3, 6); %rating bar
        DrawFormattedText(theWindow, double(rating_types_soho.prompts{1}), 'center', H*(1/5), white, [], [], [], 2);

        Screen('Flip', theWindow);
        
        data.dat.movie_post_state = GetSecs;
        
    elseif GetSecs - movie_run_start == wait_after_post_state
        data.dat.movie_post_state = GetSecs;
    end
    
    [~,~,keyCode] = KbCheck;
    if keyCode(KbName('q')) == 1
        abort_experiment;
        break
    end    
    rec_i = rec_i + 1;    
    data.dat.movie_rating(rec_i,1) = GetSecs;
    data.dat.movie_rating(rec_i,2) = (x-lb)/(rb-lb);
    
%     sprintf('pre-post: %d',rec_i)
    
    if GetSecs - movie_run_start > expt_param.movie_run_duration
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

%% Saving rating and time
data.dat.movie_run_end = GetSecs;
data.dat.movie_run_duration = data.dat.movie_run_end - data.dat.movie_run_start;   % 14min

data.dat.movie_pre_state_duration = data.dat.movie_pre_state - data.dat.movie_run_start;  % 15s
data.dat.movie_rating_duration = data.dat.movie_rating_end - data.dat.movie_pre_state;  % 9min 38s
data.dat.movie_post_state_duration = data.dat.movie_post_state - data.dat.movie_rating_end;

end