%% Set directory
clear
basedir = '/Users/ieunjin/Dropbox/SOHO/sync/scripts/experiment';

filename = '20210527_002_test_heat_SOHO.mat';
sub_num = 1;

load(fullfile(basedir,'Data', filename))

% 1 = heat / 2 = structural / 3 = caps / 4 = resting / 5 = movie
if contains(filename,'heat') == 1
    run_type = 1;
elseif contains(filename,'structural') == 1
    run_type = 2;
elseif contains(filename,'caps') == 1
    run_type = 3;    
elseif contains(filename,'resting') == 1
    run_type = 4;
else
    run_type = 5;
end
    
%% DRAW RATING PLOT
% Draw rating plot (heat trial)
if run_type == 1
    rating = [];
    for i = 1:8
        a = data.dat.heat_rating{i};
        rating = [rating; a];
    end
    
    plot(rating(:,2));
    sgtitle(sprintf('Rating plot of heat trial - sub %d',sub_num));
    set(gcf,'position', [48 360 1833 420]);
    
    % Draw rating plot (structural)
elseif run_type == 2
    rating = [];
    for i = 1:8
        a = data.dat.structural_heat_rating{i};
        rating = [rating; a];
    end
    
    plot(rating(:,2));
    sgtitle(sprintf('Rating plot of structural scan - sub %d',sub_num));
    set(gcf,'position', [48 360 1833 420]);
    
% Draw rating plot (caps)
elseif run_type == 3
    rating = data.dat.caps_rating;    
    
    plot(rating(:,2));
    sgtitle(sprintf('Rating plot of caps run - sub %d',sub_num));
    set(gcf,'position', [48 360 1833 420]);

% Draw rating plot (resting)
elseif run_type == 4
    rating = data.dat.resting_rating;
    
    plot(rating(:,2));
    sgtitle(sprintf('Rating plot of resting run - sub %d',sub_num));
    set(gcf,'position', [48 360 1833 420]);

% Draw rating plot (movie)    
elseif run_type == 5
    rating = data.dat.movie_rating;
    
    plot(rating(:,2));
    sgtitle(sprintf('Rating plot of movie run - sub %d',sub_num));
    set(gcf,'position', [48 360 1833 420]);
end


%% Concatenate Day 2 data
clear
basedir = '/Users/ieunjin/Dropbox/SOHO/sync/scripts/experiment';

date = '20210525';
subj_name = 'pilot';
sub_num = 1;

filelist = dir(fullfile(basedir,'Data'));
filelist = {filelist.name}';
date_idx = contains(filelist,date);
subj_name_idx = contains(filelist,subj_name);

a = find(date_idx == 1 & subj_name_idx == 1);
filelist = filelist(a);

rating = [];
for i = 1:6
    load(fullfile(basedir,'Data', filelist{i}))
    if i == 1
        aa = data.dat.resting_rating;
    elseif i == 2
        aa = data.dat.caps_rating;
    elseif i == 3
        aa = data.dat.resting_rating;
    elseif i == 4
        aa = data.dat.resting_rating;
    elseif i == 5
        aa = data.dat.movie_rating;
    else
        aa = data.dat.resting_rating;
    end
    rating = [rating;aa];
end

plot(rating(:,2));
    sgtitle(sprintf('Rating plot of Day 2 - sub %d',sub_num));
    set(gcf,'position', [48 360 1833 420]);

