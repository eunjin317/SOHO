clear
addpath(genpath(pwd));

%% Saving
basedir = pwd;
savedir = fullfile(basedir, 'Data');

nowtime = clock;
SubjDate = sprintf('%.2d%.2d%.2d', nowtime(1), nowtime(2), nowtime(3));

data.sub_name = 'LEJ_201';
data.datafile = fullfile(savedir, [SubjDate, '_', data.sub_name, '_SOHO_post_movie_rating', '.mat']);
data.version = 'SOHO_07-15-2021_Cocoanlab';  % month-date-year
data.starttime = datestr(clock, 0);

movie_duration = 579;

[movie_file, movie_path] = uigetfile('video.mp4');
movie_dir = fullfile(movie_path, movie_file);

% moviefile = fullfile(pwd, '/Video/2222.mp4');


% if the same file exists, break and retype subject info
if exist(data.datafile, 'file')
    fprintf('\n ** EXSITING FILE: %s %s **', data.sub_name, SubjDate);
    cont_or_not = input(['\nThe typed Run name and number are already saved.', ...
        '\nWill you go on with your Run name and number that saved before?', ...
        '\n1: Yes, continue with Run name and number.  ,   2: No, it`s a mistake. I`ll break.\n:  ']);
    if cont_or_not == 2
        error('Breaked.')
    elseif cont_or_not == 1
        save(data.datafile, 'data');
    end
else
    save(data.datafile, 'data');
end

%% Start post movie rating
data.dat.all_start_time = GetSecs;

screens = Screen('Screens');
window_num = screens(1);
Screen('Preference', 'SkipSyncTests', 1);
window_info = Screen('Resolution', window_num);

screen_mode = 'Full';  % Full, Testmode

switch screen_mode
    case 'Full'
        window_rect = [0 0 window_info.width window_info.height]; % full screen
%         window_rect = [0 0 1440 900]; % full screen
        fontsize = 32;
    case 'Testmode'
        window_rect = [0 0 1200 600];  % 1920 1080]; full screen for window
        fontsize = 32;
end

% size
W = window_rect(3); % width
H = window_rect(4); % height

% lb1 = W*(2/10); % rating scale left bounds 1/6 0.1666
% rb1 = W*(8/10); % rating scale right bounds 5/6 0.83333
% lb2 = W*(3/10); % rating scale left bounds 1/4 0.25
% rb2 = W*(7/10); % rating scale right bounds 3/4 0.75

lb3 = W*(4/10);
rb3 = W*(6/10);

lb = lb3;
rb = rb3;

scale_W = W*0.1;
scale_H = H*0.1;


% anchor_lms = [W/2-0.014*(W/2-lb1) W/2-0.061*(W/2-lb1) W/2-0.172*(W/2-lb1) W/2-0.354*(W/2-lb1) W/2-0.533*(W/2-lb1);
%     W/2+0.014*(W/2-lb1) W/2+0.061*(W/2-lb1) W/2+0.172*(W/2-lb1) W/2+0.354*(W/2-lb1) W/2+0.533*(W/2-lb1)];

% color
bgcolor = 50;
white = 255;
red = [158 1 66];
orange = [255 164 0];

% font
font = 'NanumBarunGothic';
Screen('Preference', 'TextEncodingLocale', 'ko_KR.UTF-8');

theWindow = Screen('OpenWindow', window_num, bgcolor, window_rect); % start the screen
Screen('TextFont', theWindow, font);
Screen('TextSize', theWindow, fontsize);

Screen(theWindow, 'FillRect', bgcolor, window_rect);
Screen('Flip', theWindow);
HideCursor;

scale = ('post_movie_rating');
rating_types_soho = call_ratingtypes_soho('resting');
ratetype = strcmp(rating_types_soho.alltypes, scale);


[moviePtr, dura, fps, width, height] = Screen('OpenMovie', theWindow, movie_dir);

scale_movie_w = width*(width/W);
scale_movie_h = height*(height/H)*(1);

% Screen('SetMovieTimeIndex', moviePtr, 0);
% Screen('PlayMovie', moviePtr, playmode); %Screen('PlayMovie?')% 0 == Stop playback, 1 == Normal speed forward, -1 == Normal speed backward,

SetMouse(lb,lb*2)

while true
    [x,y,button] = GetMouse(theWindow);
    Screen('DrawLine', theWindow, white, lb, H*(9.8/10), rb, H*(9.8/10), 6); % penWidth: 0.125~7.000
    Screen('DrawLine', theWindow, [238,238,238,1], lb, H*(9.8/10)-(rb-lb), rb, H*(9.8/10)-(rb-lb), 0.5); % upper horizontal
    Screen('DrawLine', theWindow, white, lb, H*(9.8/10)-(rb-lb), lb, H*(9.8/10), 6); % left vertical
    Screen('DrawLine', theWindow, [238,238,238,1], rb, H*(9.8/10)-(rb-lb), rb, H*(9.8/10), 0.5); % right vertical
    
    Screen('DrawLine', theWindow, white, lb-15, H*(9.8/10)+15-(rb-lb), lb, H*(9.8/10)-(rb-lb), 6); % left vertical arrow
    Screen('DrawLine', theWindow, white, lb+15, H*(9.8/10)+15-(rb-lb), lb, H*(9.8/10)-(rb-lb), 6); % left vertical arrow
    Screen('DrawLine', theWindow, white, rb-14.6, H*(9.8/10)+15, rb, H*(9.8/10), 6); % low horizontal arrow
    Screen('DrawLine', theWindow, white, rb-14.6, H*(9.8/10)-15, rb, H*(9.8/10), 6); % low horizontal arrow
    
    DrawFormattedText(theWindow, double('긍정'), rb+scale_H*(0.1),H*(9.8/10), white,[],[],[],1.2);
    DrawFormattedText(theWindow, double('부정'), lb-scale_H*(0.7), H*(6.5/10), white,[],[],[],1.2);
    DrawFormattedText(theWindow, double('중립'), lb-scale_H*(0.7), H*(9.8/10), white,[],[],[],1.2);
    
    DrawFormattedText(theWindow, double('준비하세요'), W*(1/2)-scale_H*(0.8), H*(5/10), white,[],[],[],1.2);
    DrawFormattedText(theWindow, double('스캔실에서의 감정을 떠올려주세요'), W*(1/2)-scale_H*(2.1), H*(4.5/10), white,[],[],[],1.2);
    Screen('TextSize', theWindow, fontsize);

    if x < lb; x = lb; elseif x > rb; x = rb; end
    if y < H*(9.8/10)-(rb-lb); y = H*(9.8/10)-(rb-lb); elseif y > H*(9.8/10); y = H*(9.8/10); end
    Screen('DrawDots', theWindow, [x, y], 10, orange, [0 0], 1); %x, H*(4/5)-scale_H/3, x, H*(4/5)+scale_H/3
    Screen('Flip', theWindow);
    
    if button(1)
        while button(1)
            [~,~,button] = GetMouse(theWindow);
        end
        break
    end
 
    [~,~,keyCode] = KbCheck;
    if keyCode(KbName('q')) == 1
        abort_experiment('manual');
        break
    end
end

clear x y button


t = GetSecs;
data.dat.post_movie_run_start = t;
         
seg_time = [0:20:560];
movie_l = [repmat(20,1,29),19];

% seg_time = [0,5,10];
% movie_l = [5,5,5];

playmode = 1;

for seg_i = 1:numel(seg_time)
    movie_start(seg_i) = GetSecs; 
    data.dat.movie_seg_start(seg_i) = movie_start(seg_i);
    
    Screen('SetMovieTimeIndex', moviePtr, seg_time(seg_i));
    Screen('PlayMovie', moviePtr, playmode); %Screen('PlayMovie?')% 0 == Stop playback, 1 == Normal speed forward, -1 == Normal speed backward,
    
    while GetSecs - movie_start(seg_i) < movie_l(seg_i)
        tex = Screen('GetMovieImage', theWindow, moviePtr);
        
        if tex > 0
            [x,y,button] = GetMouse(theWindow);
            Screen('DrawTexture', theWindow, tex, [ ], [W/2-scale_movie_w*(6/10) H*(0.5/10)-scale_movie_h*(1/10) W/2+scale_movie_w*(6/10) H*(2/10)+scale_movie_h*(8/10)]);
            Screen('Flip', theWindow);
            Screen('Close', tex);
        end
    end
    
   Screen('PlayMovie', moviePtr,0);
   data.dat.movie_seg_end(seg_i) = GetSecs;
   data.dat.movie_seg_dur(seg_i) = data.dat.movie_seg_end(seg_i) - data.dat.movie_seg_start(seg_i);
   
   if seg_i == 1
       SetMouse(lb,lb*2)
   else
       SetMouse(location(1),location(2));
   end
   
   rec_i = 0;
   
    while true
        [x,y,button] = GetMouse(theWindow);
        if x < lb; x = lb; elseif x > rb; x = rb; end
        if y < H*(9.8/10)-(rb-lb); y = H*(9.8/10)-(rb-lb); elseif y > H*(9.8/10); y = H*(9.8/10); end
        
        Screen('TextSize', theWindow, fontsize);
        Screen('DrawLine', theWindow, white, lb, H*(9.8/10), rb, H*(9.8/10), 6); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, [238,238,238,1], lb, H*(9.8/10)-(rb-lb), rb, H*(9.8/10)-(rb-lb), 0.5);
        Screen('DrawLine', theWindow, white, lb, H*(9.8/10)-(rb-lb), lb, H*(9.8/10), 6);
        Screen('DrawLine', theWindow, [238,238,238,1], rb, H*(9.8/10)-(rb-lb), rb, H*(9.8/10), 0.5);
        
        Screen('DrawLine', theWindow, white, lb-15, H*(9.8/10)+15-(rb-lb), lb, H*(9.8/10)-(rb-lb), 6); % left vertical arrow
        Screen('DrawLine', theWindow, white, lb+15, H*(9.8/10)+15-(rb-lb), lb, H*(9.8/10)-(rb-lb), 6); % left vertical arrow
        Screen('DrawLine', theWindow, white, rb-14.6, H*(9.8/10)+15, rb, H*(9.8/10), 6); % low horizontal arrow
        Screen('DrawLine', theWindow, white, rb-14.6, H*(9.8/10)-15, rb, H*(9.8/10), 6); % low horizontal arrow
        
        DrawFormattedText(theWindow, double('긍정'), rb+scale_H*(0.1),H*(9.8/10), white,[],[],[],1.2);
        DrawFormattedText(theWindow, double('부정'), lb-scale_H*(0.7), H*(6.5/10), white,[],[],[],1.2);
        DrawFormattedText(theWindow, double('중립'), lb-scale_H*(0.7), H*(9.8/10), white,[],[],[],1.2);
        
        Screen('DrawDots', theWindow, [x, y], 10, orange, [0 0], 1);
        Screen('Flip', theWindow);
        Screen('TextSize', theWindow, fontsize);
        
        rec_i = rec_i + 1;
                    
        if button(1)
            data.dat.movie_rating_end(seg_i) = GetSecs;
            while button(1)
                [~,~,button] = GetMouse(theWindow);
            end
            break
        end
        
        data.dat.movie_seg_rating{seg_i}(rec_i,1) = GetSecs;
        data.dat.movie_seg_rating{seg_i}(rec_i,2) = data.dat.movie_seg_rating{seg_i}(rec_i,1) - data.dat.movie_seg_end(seg_i);
        data.dat.movie_seg_rating{seg_i}(rec_i,3) = (x-lb)/(rb-lb);
        data.dat.movie_seg_rating{seg_i}(rec_i,4) = abs(1 - (y - (H*(9.8/10)-(rb-lb)))/(H*(9.8/10) - (H*(9.8/10)-(rb-lb))));
        
        location = [x,y];
        data.dat.movie_seg_rating_endpoint{seg_i} = [(x-lb)/(rb-lb), abs(1 - (y - (H*(9.8/10)-(rb-lb)))/(H*(9.8/10) - (H*(9.8/10)-(rb-lb))))];
    end    

    data.dat.movie_rating_dur(seg_i) = data.dat.movie_rating_end(seg_i) - data.dat.movie_seg_end(seg_i);
    
    [~,~,keyCode] = KbCheck;
    if keyCode(KbName('q')) == 1
        abort_experiment('manual');
        break
    end
end
data.dat.post_movie_run_end = GetSecs;
data.dat.post_movie_run_dur = data.dat.post_movie_run_end - data.dat.post_movie_run_start;

save(data.datafile, 'data', '-append');

WaitSecs(0.3)
msgtxt = '질문이 끝났습니다.';
msgtxt = double(msgtxt); % korean to double
DrawFormattedText(theWindow, msgtxt, 'center', 'center', white, [], [], [], 2);
Screen('Flip', theWindow);
WaitSecs(2)

data.dat.all_end_time = GetSecs;
data.dat.total_dur = data.dat.all_end_time - data.dat.all_start_time;

ShowCursor;
sca;
Screen('CloseAll');
    
% Screen('PlayMovie', moviePtr,0);
% Screen('CloseMovie',moviePtr);
% Screen('Flip', theWindow);
% Screen('CloseAll');


%% Check the rating plot
figure;
for i = 1:29
    scatter(data.dat.movie_seg_rating_endpoint{i}(1),data.dat.movie_seg_rating_endpoint{i}(2));
    hold on
%     legend('seg 1','seg 2','seg 3');
end
xlim([0 1]);
ylim([0 1]);
xlabel('positive'); 
ylabel('negative');

figure;
for i = 1:29
    plot(data.dat.movie_seg_rating{i}(:,3),data.dat.movie_seg_rating{i}(:,4));
    hold on
%     legend('seg 1','seg 2','seg 3');
end
xlim([0 1]);
ylim([0 1]);
xlabel('positive'); 
ylabel('negative');


plot3(data.dat.movie_seg_rating{1}(:,2),data.dat.movie_seg_rating{1}(:,3),data.dat.movie_seg_rating{1}(:,4))
xlabel('time');
ylabel('positive');
zlabel('negative');
