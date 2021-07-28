function [data] = SOHO_postrun_survey(screen_param, expt_param, data)  
%%Assign variables
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

%% Postrun questionnaire
if expt_param.day == 2
    all_start_t = GetSecs;
    data.dat.postrun_starttime = all_start_t;
    
    post_rating_type = {'overall_alertness','overall_resting_valence','overall_resting_self','overall_resting_time',...
        'overall_thought_ratio'};
    
    if mod(expt_param.Run_Num,3) == 0
        q_index = 1:5;
    else
        q_index = 1:4;
    end       
    
    Screen(theWindow, 'FillRect', bgcolor, window_rect);
    msgtxt = [num2str(expt_param.Run_Num) '번째 세션이 끝났습니다.\n\n잠시 후 질문들이 제시될 것입니다. 참가자분께서는 기다려주시기 바랍니다.\n\n각 문항에 트랙볼을 이용하여 클릭하시면 됩니다.'];
    msgtxt = double(msgtxt);
    DrawFormattedText(theWindow, msgtxt, 'center', 'center', white, [], [], [], 2);
    Screen('Flip', theWindow);
    
    waitsec_fromstarttime(all_start_t, 3)
    
    for rating_i = q_index     %numel(post_rating_type)
        rating_types_soho = call_ratingtypes_soho(post_rating_type{rating_i});
        
        scales = rating_types_soho.postalltypes{1};
        
        for scale_i = 1:numel(scales)
            
            scale = scales{scale_i};
            [lb, rb, start_center] = draw_scale_soho(scale, screen_param.window_info, screen_param.line_parameters, screen_param.color_values);
            
            Screen(theWindow, 'FillRect', bgcolor, window_rect);
            
            start_t = GetSecs;
            eval(['data.dat.' scale '_starttime = start_t;']);
            
            rec_i = 0;
            ratetype = strcmp(rating_types_soho.alltypes, scale);
            
            % Initial position
            if rating_i == 5
                SetMouse(lb,H/2); % set mouse at the center
            else
                SetMouse(W/2,H/2); % set mouse at the left
            end
            
            % Get ratings
            while true
                rec_i = rec_i + 1;
                [x,~,button] = GetMouse(theWindow);
                [lb, rb, start_center] = draw_scale_soho(scale, screen_param.window_info, screen_param.line_parameters, screen_param.color_values);
                if x < lb; x = lb; elseif x > rb; x = rb; end
                
                DrawFormattedText(theWindow, double(rating_types_soho.prompts{ratetype}), 'center', H*(1/4), white, [], [], [], 2);
                Screen('DrawLine', theWindow, orange, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6); %rating bar
                
                if rating_i == 5
                    Screen('FillRect', theWindow, orange,[lb H*(1/2)-scale_H/3 x H*(1/2)+scale_H/3])
                    DrawFormattedText(theWindow, double('막대길이: 100'), 'center', H*(2.2/5), white, [], [], [], 2);
                end
                
                Screen('Flip', theWindow);
                
                if button(1)
                    while button(1)
                        [~,~,button] = GetMouse(theWindow);
                    end
                    break
                end
                
                cur_t = GetSecs;
                eval(['data.dat.' scale '_rating(rec_i,1) = cur_t-start_t;']);
                eval(['data.dat.' scale '_rating(rec_i,2) = (x-lb)/(rb-lb);']);
            end
            
            if rating_i == 5
                location = data.dat.overall_thought_ratio_rating(end,2);

                while true
                Screen('DrawLine', theWindow, orange, location*(rb-lb)+lb, H*(1/2)-scale_H/3, location*(rb-lb)+lb, H*(1/2)+scale_H/3, 6); %rating bar
                Screen('FillRect', theWindow, orange,[lb H*(1/2)-scale_H/3 location*(rb-lb)+lb H*(1/2)+scale_H/3])
                
                rec_i = rec_i + 1;
                [y,~,button] = GetMouse(theWindow);
                [lb, rb, start_center] = draw_scale_soho(scale, screen_param.window_info, screen_param.line_parameters, screen_param.color_values);
                if y < x; y = x; elseif y > rb; y = rb; end
                
                Screen('DrawLine', theWindow, blue, y, H*(1/2)-scale_H/3, y, H*(1/2)+scale_H/3, 6); %rating bar
                DrawFormattedText(theWindow, double(rating_types_soho.prompts{ratetype}), 'center', H*(1/4), white, [], [], [], 2);
                Screen('FillRect', theWindow, blue,[location*(rb-lb)+lb H*(1/2)-scale_H/3 y H*(1/2)+scale_H/3])
                DrawFormattedText(theWindow, double('막대길이: 100'), 'center', H*(2.2/5), white, [], [], [], 2);
                Screen('Flip', theWindow);
                
                if button(1)
%                     Screen('FillRect', theWindow, orange,[lb H*(1/2)-scale_H/3 location*(rb-lb)+lb H*(1/2)+scale_H/3])                   
                    while button(1)
                        [~,~,button] = GetMouse(theWindow);                        
                    end
                    break
                end
                
                cur_t = GetSecs;
                eval(['data.dat.' scale '_rating_2(rec_i,1) = cur_t-start_t;']);
                eval(['data.dat.' scale '_rating_2(rec_i,2) = (y-lb)/(rb-lb);']);
                end
                eval(['data.dat.' scale '_rating_endpoint_2 = (y-lb)/(rb-lb);']);

                location_2 = data.dat.overall_thought_ratio_rating_2(end,2);

                while true
                Screen('FillRect', theWindow, orange,[lb H*(1/2)-scale_H/3 location*(rb-lb)+lb H*(1/2)+scale_H/3])
                Screen('DrawLine', theWindow, blue, location_2*(rb-lb)+lb, H*(1/2)-scale_H/3, location_2*(rb-lb)+lb, H*(1/2)+scale_H/3, 6); %rating bar
                Screen('FillRect', theWindow, blue,[location*(rb-lb)+lb H*(1/2)-scale_H/3 location_2*(rb-lb)+lb H*(1/2)+scale_H/3])
                
                rec_i = rec_i + 1;
                [z,~,button] = GetMouse(theWindow);
                [lb, rb, start_center] = draw_scale_soho(scale, screen_param.window_info, screen_param.line_parameters, screen_param.color_values);
                if z < y; z = y; elseif z > rb; z = rb; end
                
                Screen('DrawLine', theWindow, white, z, H*(1/2)-scale_H/3, z, H*(1/2)+scale_H/3, 6); %rating bar
                DrawFormattedText(theWindow, double(rating_types_soho.prompts{ratetype}), 'center', H*(1/4), white, [], [], [], 2);
                Screen('FillRect', theWindow, white,[location_2*(rb-lb)+lb H*(1/2)-scale_H/3 z H*(1/2)+scale_H/3])
                DrawFormattedText(theWindow, double('막대길이: 100'), 'center', H*(2.2/5), white, [], [], [], 2);
                Screen('Flip', theWindow);
                
                if button(1)
%                     Screen('FillRect', theWindow, orange,[lb H*(1/2)-scale_H/3 location*(rb-lb)+lb H*(1/2)+scale_H/3])                   
                    while button(1)
                        [~,~,button] = GetMouse(theWindow);                        
                    end
                    break
                end
                
                cur_t = GetSecs;
                eval(['data.dat.' scale '_rating_3(rec_i,1) = cur_t-start_t;']);
                eval(['data.dat.' scale '_rating_3(rec_i,2) = (z-lb)/(rb-lb);']);
                end
                eval(['data.dat.' scale '_rating_endpoint_3 = (z-lb)/(rb-lb);']);
            end
            
            end_t = GetSecs;
            eval(['data.dat.' scale '_rating_endpoint = (x-lb)/(rb-lb);']);
            eval(['data.dat.' scale '_duration = end_t - start_t;']);
            
            % Freeze the screen 0.5 second with red line if overall type
            freeze_t = GetSecs;
            while true
                [lb, rb, start_center] = draw_scale_soho(scale, screen_param.window_info, screen_param.line_parameters, screen_param.color_values);
                DrawFormattedText(theWindow, double(rating_types_soho.prompts{ratetype}), 'center', H*(1/4), white, [], [], [], 2);
                if rating_i == 5
                Screen('DrawLine', theWindow, red, z, H*(1/2)-scale_H/3, z, H*(1/2)+scale_H/3, 6);    
                else
                Screen('DrawLine', theWindow, red, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6);
                end
                Screen('Flip', theWindow);
                freeze_cur_t = GetSecs;
                if freeze_cur_t - freeze_t > 0.5
                    break
                end
            end
        end
    end
    
    msgtxt = '질문이 끝났습니다.';
    msgtxt = double(msgtxt); % korean to double
    DrawFormattedText(theWindow, msgtxt, 'center', 'center', white, [], [], [], 2);
    Screen('Flip', theWindow);
    
    % wait for 2 secs to end
    postrun_end = GetSecs;
    waitsec_fromstarttime(postrun_end, 2);
    
    all_end_t = GetSecs;
    data.dat.postrun_dur = all_end_t - all_start_t;
end

%% Saving Data
save(data.datafile, 'data', '-append');
end