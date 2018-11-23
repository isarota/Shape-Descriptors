function [BestChrom] = GeneticAlgorithm (M, N, MaxGen, Pc, Pm, Er, obj)


%% Initialization
% Initialize the population
[ population ] = initialization(M, N);
% Calculate the fitness values
for i = 1 : M
    population.Chromosomes(i).fitness=obj(population.Chromosomes(i).Gene(:));
end

%% Main loop
for g = 2 : MaxGen
    disp(['Generation #', num2str(g)]);
    
    for k = 1: 2 : M
        % Selection
        [parent1,parent2] = selection(population);
        
        % Crossover
        crossoverName = 'single';
        [child1, child2] = crossover(parent1, parent2, Pc, crossoverName);
        
        % Mutation
        [child1]= mutation(child1, Pm);
        [child2]= mutation(child2, Pm);
        
        while ((sum(child1.Gene(:))==0) || (sum(child2.Gene(:))==0))
            % Crossover
            crossoverName = 'single';
            [child1, child2] = crossover(parent1, parent2, Pc, crossoverName);
            
            % Mutation
            [child1]= mutation(child1, Pm);
            [child2]= mutation(child2, Pm);
            disp(['sifir']);
        end
        disp(['children', child1.Gene, child2.Gene]);
        newPopulation.Chromosomes(k).Gene = child1.Gene;
        newPopulation.Chromosomes(k+1).Gene = child2.Gene;
        disp(['new pop chromosome', newPopulation.Chromosomes.Gene]);
        
    end  % end of Chromosomes loop
    
    for i = 1 : M
        testt= sum(newPopulation.Chromosomes(i).Gene(:))
        newPopulation.Chromosomes(i).fitness=obj(population.Chromosomes(i).Gene(:));
    end
    
    % Elitism
    [ newPopulation ]= elitism(newPopulation, Er);
    
    population = newPopulation;
    
end   % end of Generation loop

for i = 1 : M
    population.Chromosomes(i).fitness=obj(population.Chromosomes(i).Gene(:));
end

[max_val, indx]= sort([population.Chromosomes(:).fitness], 'descend');

BestChrom.Gene = population.Chromosomes(indx(1)).Gene;
BestChrom.fitness = population.Chromosomes(indx(1)).fitness;


end