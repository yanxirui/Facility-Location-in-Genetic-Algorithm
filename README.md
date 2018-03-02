# Facility-Location-in-Genetic-Algorithm
This project use genetic algorithm to solve the facility location problem in matlab.

The problem and the model is describled in file 'Problem&Model.pdf';

And the parametres settings are shown as follows:

The following parametres are setting in file 'run.m'
% population_size: the size of population_size
% chromosome_size: the size of chromosome_size()
% generation_size: the size of generation
% cross_rate: the rate of cross
% mutate_rate: the rate of mutation
% elitism: =1:Elite choose  =0:No elite choose

% Distance: The distance between any two positions
% TravelTime: The time of travelling between any two positions
% Flow: The flow between any two positions
% FixedHubCost: The cost of fixxing hub in every position
 

The following parametres are setting in file 'fitness.m'
%distance_con:the ratio of the cost of unit distance in hub-to-hub and the cost of unit distance in hub-to-nonhub
%HubToHub_con:α
%Time_con:β
