function [Jx, Cx, Ju, Cu] = f_embeddings_MU(spike_train, l_param, random_events)

if (~iscolumn(spike_train))
    spike_train = spike_train';
end

%% PASTs of the process in respect to target events
Jx = []; 
for i = l_param+1 : numel(spike_train) 
    
    spike_past = spike_train(i - l_param:i, :); 
    Jx = [Jx; diff(spike_past')];
    
end
Cx = Jx(:, end);

%% PASTs of the process in respect to random events

Ju = []; 
for i = 1 : numel(random_events)
    
    temp_spike = random_events(i, :); 
    
    past = spike_train(find(spike_train < temp_spike)); 
    
    if numel(past)>= l_param % 
        temp_array = [];
        temp_array = [temp_array; temp_spike; past(end:-1:end-l_param+1, :)]; 
        temp_array = temp_array(end:-1:1, :); 
        
        Ju = [Ju; diff(temp_array')];
        
    end
end
Cu = Ju(:, end);




