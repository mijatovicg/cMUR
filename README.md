This repository provides a method to quantify memory utilization in neural point processes, as introduced in the paper “A Model-Free Method to Quantify Memory Utilization in Neural Point Processes” by G. Mijatovic, S. Stramaglia, and L. Faes (https://arxiv.org/abs/2408.15875). The method offers a model-free estimation of the memory utilization rate (MUR), which serves as the continuous-time equivalent of information storage and is designed to measure the predictive capacity stored in neural point processes.
By applying nearest-neighbor entropy estimation to inter-spike intervals observed from point-process realizations, the method quantifies the extent of memory utilized by a neural spike train. To ensure accuracy, an empirical procedure based on surrogate data analysis is employed to correct for estimation bias and identify statistically significant memory levels within the analyzed point processes.

The cMUR toolbox includes the following functions:
1.	f_embeddings_MU.m - Creates embeddings at target and random events.
2.	f_MUR.m - Estimates the MUR quantity.
3.	f_shuffling_surr.m - Assesses the statistical significance of the MUR quantity and compensates for bias based on surrogate data analysis.

Additionally, a script (demo.m) is provided to simulate spike trains of length 1000, which includes inter-spike intervals (ISIs) that exhibit either mutual independence (coupling parameter p = 0) or a high degree of mutual dependence (p = 0.9). This script demonstrates the resulting MUR and its corrected values (cMUR).
