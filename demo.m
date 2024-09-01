clear; close all; clc;

% input parameters
num_surr = 100;
lambda = 1;
N = 1000;
l_param = 4;
k_global = 5;
p_array = [0, 0.9]; % coupling parameter

%%
for p_ind = 1 : numel(p_array)
    p = p_array(p_ind);

    w_all = [];
    w = exprnd(1/lambda);
    for n = 1: N
        mu = 1/lambda*(1-p) + p*w;
        w = exprnd(mu);
        w_all = [w_all; w];
    end

    spike_train = cumsum(w_all);

    %% MUR analysis

    Nt = numel(spike_train);
    Nu = Nt; time_limit = max(spike_train);
    random_events = sort(round(time_limit).*rand(Nu, 1)); % gererate radnom time axis by uniform distribution

    tau  = spike_train(end, :) - spike_train(1, :); % total recording duration!
    lambda_av = numel(spike_train)/tau; % average firing rate

    [Jx, Cx, Ju, Cu] = f_embeddings_MU(spike_train, l_param, random_events);

    MUR_orig = f_MUR(Cx, Jx, Cu, Ju, lambda_av, k_global, l_param);

    [MUR_surr_array, flag] = f_shuffling_surr(spike_train, num_surr, l_param, random_events, k_global, MUR_orig);

    cMUR = MUR_orig - median(MUR_surr_array);

    disp('p parameter:'); disp(p); disp('MUR value:'); disp(MUR_orig); disp('cMUR value:'); disp(cMUR);
end
