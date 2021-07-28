function [lb, rb, start_center] = draw_scale_soho(scale, window_info, line_parameters, color_values)

font = window_info.font ;
fontsize = window_info.fontsize;
theWindow = window_info.theWindow;
window_num = window_info.window_num ;
window_rect = window_info.window_rect;
H = window_info.H ;
W = window_info.W;

lb1 = line_parameters.lb1 ;
lb2 = line_parameters.lb2 ;
rb1 = line_parameters.rb1;
rb2 = line_parameters.rb2;
scale_H = line_parameters.scale_H ;
scale_W = line_parameters.scale_W;
anchor_lms = line_parameters.anchor_lms;

bgcolor = color_values.bgcolor;
orange = color_values.orange;
red = color_values.red;
white = color_values.white;
blue = color_values.blue;

%% Basic Settings
start_center = true;
lb = lb2;
rb = rb2;

%% Drawing scale
switch scale
    case 'overall_int'  % one-directional
        start_center = false;
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        %         DrawFormattedText(theWindow, double('���� ��������\n      ����'), lb-scale_H/0.8, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        DrawFormattedText(theWindow, double(''), lb-scale_H/0.8, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        %         DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� ����'), rb-scale_H/0.7, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        DrawFormattedText(theWindow, double(''), rb-scale_H/0.7, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
                
    case 'resting_int'  % one-directional
        start_center = false;
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double(''), lb-scale_H/0.8, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double(''), rb-scale_H/0.7, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        
    case 'resting_structural'  % one-directional
        start_center = false;
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����'), lb-scale_H/4, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        
        Screen('DrawLine', theWindow, white, lb+(rb-lb)*0.061, H*(1/2)-scale_H/5, lb+(rb-lb)*0.061, H*(1/2)+scale_H/5, 6);
        DrawFormattedText(theWindow, double('����\n����'), lb+(rb-lb)*0.061-scale_H/5, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        
        Screen('DrawLine', theWindow, white, lb+(rb-lb)*0.172, H*(1/2)-scale_H/5, lb+(rb-lb)*0.172, H*(1/2)+scale_H/5, 6);
        DrawFormattedText(theWindow, double('����'), lb+(rb-lb)*0.172-scale_H/5, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        
        Screen('DrawLine', theWindow, white, lb+(rb-lb)*0.354, H*(1/2)-scale_H/5, lb+(rb-lb)*0.354, H*(1/2)+scale_H/5, 6);
        DrawFormattedText(theWindow, double('����'), lb+(rb-lb)*0.354-scale_H/5, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        
        Screen('DrawLine', theWindow, white, lb+(rb-lb)*0.533, H*(1/2)-scale_H/5, lb+(rb-lb)*0.533, H*(1/2)+scale_H/5, 6);
        DrawFormattedText(theWindow, double('�ſ� ����'), lb+(rb-lb)*0.533-scale_H/3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
%         
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ִ�'), rb-scale_H/5-3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        
    case 'overall_alertness'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ſ� ����'), lb-scale_H/1.4, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����'), W/2-scale_W/5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ſ� �Ƿ�'), rb-scale_H/1.4, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_valence'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����'), lb-scale_H/5-3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double(' �߸�'), W/2-scale_W/5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����'), rb-scale_H/5-3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_self'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double(' ���þ���'), lb-scale_H/1.3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double(' ����'), W/2-scale_W/5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double(' ��������'), rb-scale_H/1.5, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_time'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����'), lb-scale_H/5-4, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double(' ����'), W/2-scale_W/5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�̷�'), rb-scale_H/5-4, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_task_unrelated_thought_pain'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� ���� ������\n ���� ���� ����'), lb-scale_H-16, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� ���� ������ ��'), rb-scale_H, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_task_unrelated_thought_movie'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� ���� ������\n ���� ���� ����'), lb-scale_H-16, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� ���� ������ ��'), rb-scale_H, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_stim_dependent_thought'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ֺ� �ڱ� ���� ������\n���� ���� ����'), lb-scale_H-16, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ֺ� �ڱ�\n���� ������ ��'), rb-scale_H*(1/2), H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_thought_ratio'
        DrawFormattedText(theWindow, double('��Ȳ��: ����/������� ���� ���� ����'), 'center', H*(1/2)+scale_H*1.2, orange,[],[],[],0.5);
        DrawFormattedText(theWindow, double('�ϴû�: �ֺ�ȯ�� ���� ���� ����\n\n(ex.��ĳ�� �Ҹ�, ȭ�� ��� ��)'), 'center', H*(1/2)+scale_H*1.5*1.2, blue,[],[],[],0.5);
        DrawFormattedText(theWindow, double('���: ����/��������� �ֺ�ȯ���\n\n������� ���� ����'), 'center', H*(1/2)+scale_H*2.2*1.2, white,[],[],[],0.5);
        Screen('FrameRect', theWindow, white, [lb H*(1/2)-scale_H/3 rb H*(1/2)+scale_H/3])
        
        %%%%%%%%%%%%%%%%% ETC %%%%%%%%%%%%%%%%%%%%
        
    case 'cont_glms'
        lb = lb1; % rating scale left bounds 1/6
        rb = rb1; % rating scale right bounds 5/6
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� ����'), lb-scale_H-10, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� ����'), rb-scale_H-10, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_glms'
        lb = lb1; % rating scale left bounds 1/6
        rb = rb1; % rating scale right bounds 5/6
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� ����'), lb-scale_H-10, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� ����'), rb-scale_H-10, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
             
    case 'overall_movie_int'  % one-directional
        start_center = false;
        Screen('DrawLine', theWindow, white, lb, H*(1/9), rb, H*(1/9), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, lb, H*(1/9)-scale_H/3, lb, H*(1/9)+scale_H/3, 6);
        DrawFormattedText(theWindow, double(''), lb-scale_H/0.8, H*(2/7)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/9)-scale_H/3, rb, H*(1/9)+scale_H/3, 6);
        DrawFormattedText(theWindow, double(''), rb-scale_H/0.7, H*(2/7)+scale_H/1.2, white,[],[],[],1.2);
    
    case 'general_sensitivity'  % one-directional
        start_center = false;
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� ��\n  ����'), lb-scale_H/2, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('      ����� �� �ִ�\n���� ���� ������ �ڱ�'), rb-scale_H/0.7, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        
    case 'overall_boredness'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� ������\n     ����'), lb-scale_H/1.3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ſ� ���ܿ�'), rb-scale_H/1.5  , H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_relaxed'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ſ� ������'), lb-scale_H/1.3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����'), W/2-scale_W/5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ſ� ����'), rb-scale_H/1.4, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_attention'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� ���ߵ���\n      ����'), lb-scale_H/0.9, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����'), W/2-scale_W/5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ſ� ����\n   �� ��'), rb-scale_H/1.4, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
        %     case 'overall_resting_self'
        %         Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        %         Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        %         DrawFormattedText(theWindow, double('���þ���'), lb-scale_H/1.3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        %         Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        %         DrawFormattedText(theWindow, double('��������'), rb-scale_H/1.5, H*(1/2)+scale_H/1.2, white);
        %         Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_vivid'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double(' ����'), lb-scale_H/1.3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double(' ����'), rb-scale_H/1.5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_safethreat'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('������'), lb-scale_H/1.3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�߸�'), W/2-scale_W/5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double(' ����'), rb-scale_H/1.4, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_positive'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� �׷���\n     �ʴ�'), lb-scale_H/1.3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ſ� �׷���'), rb-scale_H/1.5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_negative'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� �׷���\n     �ʴ�'), lb-scale_H/1.3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ſ� �׷���'), rb-scale_H/1.5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_myself'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� �׷���\n     �ʴ�'), lb-scale_H/1.3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ſ� �׷���'), rb-scale_H/1.5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_others'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� �׷���\n     �ʴ�'), lb-scale_H/1.3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ſ� �׷���'), rb-scale_H/1.5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_imagery'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� �׷���\n     �ʴ�'), lb-scale_H/1.3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ſ� �׷���'), rb-scale_H/1.5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_present'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� �׷���\n     �ʴ�'), lb-scale_H/1.3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ſ� �׷���'), rb-scale_H/1.5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_past'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� �׷���\n     �ʴ�'), lb-scale_H/1.3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ſ� �׷���'), rb-scale_H/1.5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_future'
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� �׷���\n     �ʴ�'), lb-scale_H/1.3, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('�ſ� �׷���'), rb-scale_H/1.5, H*(1/2)+scale_H/1.2, white);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_bitter_int'  % one-directional
        start_center = false;
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� ��������\n             ����'), lb-scale_H*2+5, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� �ڱ�'), rb-scale_H/0.9, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        
    case 'overall_resting_bitter_glms'
        lb = lb1;
        rb = rb1;
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� ����'), lb-scale_H-10, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� ����'), rb-scale_H-10, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_capsai_int'  % one-directional
        start_center = false;
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� ��������\n             ����'), lb-scale_H*2+5, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� �ڱ�'), rb-scale_H/0.9, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        
    case 'overall_resting_capsai_glms'
        lb = lb1;
        rb = rb1;
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� ����'), lb-scale_H-10, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� ����'), rb-scale_H-10, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_sweet_int'  % one-directional
        start_center = false;
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� ��������\n             ����'), lb-scale_H*2+5, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� �ڱ�'), rb-scale_H/0.9, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        
    case 'overall_resting_sweet_glms'
        lb = lb1;
        rb = rb1;
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� ����'), lb-scale_H-10, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� ����'), rb-scale_H-10, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
    case 'overall_resting_touch_int'  % one-directional
        start_center = false;
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('���� ��������\n             ����'), lb-scale_H*2+5, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� �ڱ�'), rb-scale_H/0.9, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        
    case 'overall_resting_touch_glms'
        lb = lb1;
        rb = rb1;
        Screen('DrawLine', theWindow, white, lb, H*(1/2), rb, H*(1/2), 4); % penWidth: 0.125~7.000
        Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� ����'), lb-scale_H-10, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, lb, H*(1/2)-scale_H/3, lb, H*(1/2)+scale_H/3, 6);
        DrawFormattedText(theWindow, double('����� �� �ִ�\n���� ���� ����'), rb-scale_H-10, H*(1/2)+scale_H/1.2, white,[],[],[],1.2);
        Screen('DrawLine', theWindow, white, rb, H*(1/2)-scale_H/3, rb, H*(1/2)+scale_H/3, 6);
        
end
end