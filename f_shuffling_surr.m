function [MUR_surr_array, flag] = f_shuffling_surr(spike_train, num_surr, l_param, random_events, k_global, MUR_orig)

MUR_surr_array = [];
cnt = 1;
while cnt <= num_surr
    
    ISI = diff (spike_train);
    ISI_shuffled = ISI(randperm(length(ISI)));
    spikes_surr = cumsum(ISI_shuffled);
    
    Nu = numel(spikes_surr);
    time_limit = max(spikes_surr);
    random_events = sort(round(time_limit).*rand(Nu, 1)); % gererate radnom time axis by uniform distribution
    tau  = spikes_surr(end, :) - spikes_surr(1, :); % total recording duration!
    lambda_av = numel(spikes_surr)/tau; % average firing rate
    
    [Jx, Cx, Ju, Cu] = f_embeddings_MU(spikes_surr, l_param, random_events);
    MUR_surr = f_MUR(Cx, Jx, Cu, Ju, lambda_av, k_global, l_param);
    
    if isa(MUR_surr,'double')
        MUR_surr_array = [MUR_surr_array; MUR_surr];
        cnt = cnt + 1;
    else
    end
end 

thr = prctile(MUR_surr_array, 95);

if MUR_orig >= thr
    flag = 1; % significant
else
    flag = 0; % non-significant
end




