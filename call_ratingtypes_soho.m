function rating_types_soho = call_ratingtypes_soho(type)
%call_ratingtypes
%This function can call dictionary of rating types and prompts.
%its output is rating_types, and it has 3 substructure.
%rating_types.prompts_ex : prompts for explanation
%rating_types.alltypes : dictionary of rating types
%rating_types.prompts : prompts for each rating type


% ********** IMPORTANT NOTE **********
% YOU CAN ADD TYPES AND PROMPTS HERE. "cont_" AND "overall_" ARE IMPORTANT.
% * CRUCIAL: THE ORDER BETWEEN alltypes AND prompts SHOULD BE THE SAME.*

switch type
    case 'resting'
        temp_rating_types_pls = {
            'resting_int', '\n+';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'resting_int'};
        
    case 'resting_structural'
        temp_rating_types_pls = {
            'resting_structural', '\n+';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_int'};
        
    case 'overall_alertness'
        temp_rating_types_pls = {
            'overall_alertness', '��� ���ǵ��� �󸶳� �����̳���, Ȥ�� �󸶳� ������ �Ƿ��߳���?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_alertness'};
        
    case 'overall_resting_valence'
        temp_rating_types_pls = {
            'overall_resting_valence', '��� ���ǵ��� �ߴ� ������ ������ Ȥ�� �������̾�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_resting_valence'};
        
    case 'overall_resting_self'
        temp_rating_types_pls = {
            'overall_resting_self', '��� ���ǵ��� �ߴ� ������ �󸶳� �� �ڽŰ� ���õ� ���̾�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_resting_self'};
        
    case 'overall_resting_time'
        temp_rating_types_pls = {
            'overall_resting_time', '��� ���ǵ��� �ַ� �ߴ� ������ ���� Ȥ�� �̷��� ���� ���̾�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_resting_time'};
        
    case 'overall_task_unrelated_thought_pain'
        temp_rating_types_pls = {
            'overall_task_unrelated_thought_pain', '��� ���ǵ��� �ַ� �ߴ� ������ ���������� �󸶳� ������ �� ���̾�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_task_unrelated_thought_pain'};
        
    case 'overall_task_unrelated_thought_movie'
        temp_rating_types_pls = {
            'overall_task_unrelated_thought_movie', '��� ���ǵ��� �ַ� �ߴ� ������ ��������� �󸶳� ������ �� ���̾�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_task_unrelated_thought_movie'};
        
    case 'overall_stim_dependent_thought'
        temp_rating_types_pls = {
            'overall_stim_dependent_thought', '��� ���ǵ��� �ַ� �ߴ� ������ �ֺ� �ڱذ�(ex.��ĳ�� �Ҹ�, ȭ�� ��� ��)\n �󸶳� ������ �� ���̾�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_stim_dependent_thought'};
        
        case 'overall_thought_ratio'
        temp_rating_types_pls = {
            'overall_thought_ratio', '��� 3���� ���ǵ��� �ߴ� ������ ������ Ʈ���� �ٸ� �̿��Ͽ� ǥ�����ּ���';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_thought_ratio'};
        
        %%%%%%%%%%%%%%%%% ETC %%%%%%%%%%%%%%%%%%%%
        
    case 'temp'
        temp_rating_types_pls = {
            'overall_int', '������ �󸶳� ���߳���?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_int'};
        
    case 'continue'
        temp_rating_types_pls = {
            'overall_int', '������ �󸶳� ���Ѱ���?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_int'};
        
    case 'deliver'
        temp_rating_types_pls = {
            'overall_int', '������ �󸶳� ���Ѱ���?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_int'};
        
    case 'remove'
        temp_rating_types_pls = {
            'overall_int', '������ �󸶳� ���Ѱ���?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_int'}; 
        
    case 'post_movie_rating'
        temp_rating_types_pls = {
            'resting_int', '\n+';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_glms'};
        
    case 'overall_relaxed'
        temp_rating_types_pls = {
            'overall_relaxed', '���� �󸶳� ����� �����̽Ű���?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_relaxed'};
        
    case 'overall_attention'
        temp_rating_types_pls = {
            'overall_attention', '��� ���ǵ��� ������ �󸶳� �����ϼ̳���?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_attention'};
        
    case 'overall_resting_positive'
        temp_rating_types_pls = {
            'overall_resting_positive', '��� ���ǵ��� �ߴ� ������ �ַ� �������̾�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_resting_positive'};
        
    case 'overall_resting_negative'
        temp_rating_types_pls = {
            'resting_int', '��� ���ǵ��� �ߴ� ������ �ַ� �������̾�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_resting_negative'};
        
    case 'overall_resting_myself'
        temp_rating_types_pls = {
            'resting_int', '��� ���ǵ��� �ߴ� ������ �ַ� �� �ڽſ� ���� ���̾�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_resting_myself'};
        
    case 'overall_resting_others'
        temp_rating_types_pls = {
            'resting_int', '��� ���ǵ��� �ߴ� ������ �ַ� �ٸ� ����鿡 ���� ���̾�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_resting_others'};
        
    case 'overall_resting_imagery'
        temp_rating_types_pls = {
            'resting_int', '��� ���ǵ��� �ߴ� ������ �ַ� ������ �̹����� �����ϰ� �־�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_resting_imagery'};
        
    case 'overall_resting_present'
        temp_rating_types_pls = {
            'resting_int', '��� ���ǵ��� �ߴ� ������ �ַ� ����, ���⿡ ���� ���̾�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_resting_present'};
        
    case 'overall_resting_past'
        temp_rating_types_pls = {
            'resting_int', '��� ���ǵ��� �ַ� �ߴ� ������ ���ſ� ���� ���̾�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_resting_past'};
        
        
    case 'overall_resting_future'
        temp_rating_types_pls = {
            'resting_int', '��� ���ǵ��� �ַ� �ߴ� ������ �̷��� ���� ���̾�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_resting_future'};
        
        
    case 'overall_resting_capsai_int'
        temp_rating_types_pls = {
            'resting_int', '��� ���ǵ��� �����ߴ� ���� ������ ���� ������ �� �󸶳� ���߳���?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_resting_capsai_int'};
        
        
    case 'overall_resting_capsai_glms'
        temp_rating_types_pls = {
            'resting_int', '��� ���ǵ��� �����ߴ� ���� ������ ���� ������ �� �󸶳� �����߳���?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_resting_capsai_glms'};
        
    case 'overall_resting_vivid'
        temp_rating_types_pls = {
            'resting_int', '��� ���ǵ��� �ߴ� ������ �ַ� ������ �̹����� �����ϰ� �־�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_resting_capsai_glms'};
        
    case 'overall_resting_safethreat'
        temp_rating_types_pls = {
            'resting_int', '��� ���ǵ��� �ַ� �ߴ� ������ �������� Ȥ�� ������ �����̾�����?';...
            };
        
        rating_types_soho.alltypes = temp_rating_types_pls(:,1);
        rating_types_soho.prompts = temp_rating_types_pls(:,2);
        
        rating_types_soho.postallstims = {'REST'};
        rating_types_soho.postalltypes{1} = ...
            {'overall_resting_capsai_glms'};
end
