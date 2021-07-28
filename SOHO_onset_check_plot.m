%% Set directory
clear
basedir = pwd;

filename = '20210602_001_pilot2_resting_SOHO.mat';
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
    
%% DRAW ONSET PLOT
% Draw onset plot (heat trial)
if run_type == 1
    % experiment start
    a = [horzcat(data.dat.experiment_start_time,0);
        horzcat(data.dat.experiment_start_time,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % fmri start
    a = [horzcat(data.dat.fmri_start_time,0);
        horzcat(data.dat.fmri_start_time,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % run start
    a = [horzcat(data.dat.run_starttime,0);
        horzcat(data.dat.run_starttime,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % baseline
    baseline = [];
    for trial_num = 1:8
        a = [horzcat(data.dat.heat_rating_start(trial_num),0);
            horzcat(data.dat.heat_rating_start(trial_num),1);
            horzcat(data.dat.heat_stim_latter_baseline_end(trial_num),1);
            horzcat(data.dat.heat_stim_latter_baseline_end(trial_num),0)];
        baseline = [baseline;a];
    end
    plot(baseline(:,1),baseline(:,2));
    hold on
    
    % heat
    heat = [];
    for trial_num = 1:8
        a = [horzcat(data.dat.heat_stim_trigger_start(trial_num),0);
            horzcat(data.dat.heat_stim_trigger_start(trial_num),1);
            horzcat(data.dat.heat_stim_trigger_end(trial_num),1);
            horzcat(data.dat.heat_stim_trigger_end(trial_num),0)];
        heat = [heat;a];
    end
    plot(heat(:,1),heat(:,2));
    hold on
    
    % rest
    rest = [];
    for trial_num = 1:8
        a = [horzcat(data.dat.heat_stim_trigger_end(trial_num),0);
            horzcat(data.dat.heat_stim_trigger_end(trial_num),1);
            horzcat(data.dat.heat_stim_rest_end(trial_num),1);
            horzcat(data.dat.heat_stim_rest_end(trial_num),0)];
        rest = [rest;a];
    end
    plot(rest(:,1),rest(:,2));
    hold on
    
    % iti
    iti = [];
    for trial_num = 1:7
        a = [horzcat(data.dat.heat_rating_end(trial_num),0);
            horzcat(data.dat.heat_rating_end(trial_num),1);
            horzcat(data.dat.trial_starttime(trial_num+1),1);
            horzcat(data.dat.trial_starttime(trial_num+1),0)];
        iti = [iti;a];
    end
    plot(iti(:,1),iti(:,2));
    hold on
    
    % run end
    a = [horzcat(data.dat.run_end_time,0);
        horzcat(data.dat.run_end_time,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % experiment end
    a = [horzcat(data.dat.experiment_end_time,0);
        horzcat(data.dat.experiment_end_time,1)];
    plot(a(:,1),a(:,2));

    sgtitle(sprintf('Onset plot of heat trial - sub %d',sub_num));
    legend('experiment start','fmri start','run start','baseline','heat pain','rest','iti','run end','experiment end');
    set(gcf,'position', [48 360 1833 420]);

% Draw onset plot (structural)
elseif run_type == 2
    % experiment start
    a = [horzcat(data.dat.experiment_start_time,0);
        horzcat(data.dat.experiment_start_time,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % fmri start
    a = [horzcat(data.dat.structural_fmri_start_time,0);
        horzcat(data.dat.structural_fmri_start_time,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % run start
    a = [horzcat(data.dat.structural_starttime,0);
        horzcat(data.dat.structural_starttime,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % baseline
    baseline = [];
    for trial_num = 1:8
        a = [horzcat(data.dat.structural_rating_start(trial_num),0);
            horzcat(data.dat.structural_rating_start(trial_num),1);
            horzcat(data.dat.structural_heat_stim_latter_baseline_end(trial_num),1);
            horzcat(data.dat.structural_heat_stim_latter_baseline_end(trial_num),0)];
        baseline = [baseline;a];
    end
    plot(baseline(:,1),baseline(:,2));
    hold on
    
    % heat
    heat = [];
    for trial_num = 1:8
        a = [horzcat(data.dat.structural_heat_stim_latter_baseline_end(trial_num),0);
            horzcat(data.dat.structural_heat_stim_latter_baseline_end(trial_num),1);
            horzcat(data.dat.structural_heat_stim_trigger_end(trial_num),1);
            horzcat(data.dat.structural_heat_stim_trigger_end(trial_num),0)];
        heat = [heat;a];
    end
    plot(heat(:,1),heat(:,2));
    hold on
    
    % rest
    rest = [];
    for trial_num = 1:8
        a = [horzcat(data.dat.structural_heat_stim_trigger_end(trial_num),0);
            horzcat(data.dat.structural_heat_stim_trigger_end(trial_num),1);
            horzcat(data.dat.structural_heat_stim_rest_end(trial_num),1);
            horzcat(data.dat.structural_heat_stim_rest_end(trial_num),0)];
        rest = [rest;a];
    end
    plot(rest(:,1),rest(:,2));
    hold on
    
    % iti
    iti = [];
    for trial_num = 1:7
        a = [horzcat(data.dat.structural_rating_end(trial_num),0);
            horzcat(data.dat.structural_rating_end(trial_num),1);
            horzcat(data.dat.structural_trial_starttime(trial_num+1),1);
            horzcat(data.dat.structural_trial_starttime(trial_num+1),0)];
        iti = [iti;a];
    end
    plot(iti(:,1),iti(:,2));
    hold on
    
    % run end
    a = [horzcat(data.dat.structural_end_time,0);
        horzcat(data.dat.structural_end_time,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % blank screen
    a = [horzcat(data.dat.structural_blank_start_time,0);
        horzcat(data.dat.structural_blank_start_time,1);
        horzcat(data.dat.structural_blank_end_time,1);
        horzcat(data.dat.structural_blank_end_time,0)];
    plot(a(:,1),a(:,2));
    hold on
    
    % experiment end
    a = [horzcat(data.dat.experiment_end_time,0);
        horzcat(data.dat.experiment_end_time,1)];
    plot(a(:,1),a(:,2));

    sgtitle(sprintf('Onset plot of structural scan - sub %d',sub_num));
    legend('experiment start','fmri start','run start','baseline','heat pain','rest','iti','run end','blank','experiment end');
    set(gcf,'position', [48 360 1833 420]);
    
% Draw onset plot (caps)
elseif run_type == 3
    % experiment start
    a = [horzcat(data.dat.experiment_start_time,0);
        horzcat(data.dat.experiment_start_time,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % fmri start
    a = [horzcat(data.dat.fmri_start_time,0);
        horzcat(data.dat.fmri_start_time,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % run start
    a = [horzcat(data.dat.run_starttime,0);
        horzcat(data.dat.run_starttime,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % caps
    caps = [];
    a = [horzcat(data.dat.caps_run_start,0);
        horzcat(data.dat.caps_run_start,1);
        horzcat(data.dat.caps_run_end,1);
        horzcat(data.dat.caps_run_end,0)];
    caps = [caps;a];
    plot(caps(:,1),caps(:,2));
    hold on
    
    % run end
    a = [horzcat(data.dat.run_end_time,0);
        horzcat(data.dat.run_end_time,1)];
    plot(a(:,1),a(:,2));
    hold on

    % experiment end
    a = [horzcat(data.dat.experiment_end_time,0);
        horzcat(data.dat.experiment_end_time,1)];
    plot(a(:,1),a(:,2));

    sgtitle(sprintf('Onset plot of caps run - sub %d',sub_num));
    legend('experiment start','fmri start','run start','caps','run end','experiment end');
    set(gcf,'position', [48 360 1833 420]);
    
% Draw onset plot (resting)    
elseif run_type == 4
    % experiment start
    a = [horzcat(data.dat.experiment_start_time,0);
        horzcat(data.dat.experiment_start_time,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % fmri start
    a = [horzcat(data.dat.fmri_start_time,0);
        horzcat(data.dat.fmri_start_time,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % run start
    a = [horzcat(data.dat.run_starttime,0);
        horzcat(data.dat.run_starttime,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % resting
    pre_state = [];
    a = [horzcat(data.dat.resting_run_start,0);
        horzcat(data.dat.resting_run_start,1);
        horzcat(data.dat.resting_run_end,1);
        horzcat(data.dat.resting_run_end,0)];
    pre_state = [pre_state;a];
    plot(pre_state(:,1),pre_state(:,2));
    hold on
    
    % run end
    a = [horzcat(data.dat.run_end_time,0);
        horzcat(data.dat.run_end_time,1)];
    plot(a(:,1),a(:,2));
    hold on

    % experiment end
    a = [horzcat(data.dat.experiment_end_time,0);
        horzcat(data.dat.experiment_end_time,1)];
    plot(a(:,1),a(:,2));
    
    sgtitle(sprintf('Onset plot of resting run - sub %d',sub_num));
    legend('experiment start','fmri start','run start','resting','run end','experiment end');
    set(gcf,'position', [48 360 1833 420]);
    
% Draw onset plot (movie)
elseif run_type == 5
    % experiment start
    a = [horzcat(data.dat.experiment_start_time,0);
        horzcat(data.dat.experiment_start_time,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % fmri start
    a = [horzcat(data.dat.fmri_start_time,0);
        horzcat(data.dat.fmri_start_time,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % run start
    a = [horzcat(data.dat.run_starttime,0);
        horzcat(data.dat.run_starttime,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % pre_state
    pre_state = [];
    a = [horzcat(data.dat.movie_run_start,0);
        horzcat(data.dat.movie_run_start,1);
        horzcat(data.dat.movie_pre_state,1);
        horzcat(data.dat.movie_pre_state,0)];
    pre_state = [pre_state;a];
    plot(pre_state(:,1),pre_state(:,2));
    hold on
    
    % movie
    movie = [];
    a = [horzcat(data.dat.movie_pre_state,0);
        horzcat(data.dat.movie_pre_state,1);
        horzcat(data.dat.movie_rating_end,1);
        horzcat(data.dat.movie_rating_end,0)];
    movie = [movie;a];
    plot(movie(:,1),movie(:,2));
    hold on
    
    % post_state
    post_state = [];
    a = [horzcat(data.dat.movie_rating_end,0);
        horzcat(data.dat.movie_rating_end,1);
        horzcat(data.dat.movie_post_state,1);
        horzcat(data.dat.movie_post_state,0)];
    post_state = [post_state;a];
    plot(post_state(:,1),post_state(:,2));
    hold on
    
    % run end
    a = [horzcat(data.dat.movie_run_end,0);
        horzcat(data.dat.movie_run_end,1)];
    plot(a(:,1),a(:,2));
    hold on
    
    % experiment end
    a = [horzcat(data.dat.experiment_end_time,0);
        horzcat(data.dat.experiment_end_time,1)];
    plot(a(:,1),a(:,2));
    
    sgtitle(sprintf('Onset plot of movie run - sub %d',sub_num));
    legend('experiment start','fmri start','run start','pre state','movie','post state','run end','experiment end');
    set(gcf,'position', [48 360 1833 420]);
end

%% ETC
% data.dat.heat_jitter_value
% data.dat.heat_stim_setting_toc
% data.dat.heat_stim_preheat_toc
% data.dat.heat_stim_trigger_toc

