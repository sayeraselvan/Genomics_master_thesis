maxENT modeling:

Main scripts to run the maxent with the required parameters are named as maxent.R (/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/replicates/rep_1/maxent.R) and it is run with the help of java application of maxent.jar

Thus the maxent was run with 10 different replicates by spliting the testing occurences into 70/30 training/test. Each replicate is named as rep_$i where i stands from 1 to 10 in the folder (/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/replicates)

Each replicate folder has Env_variable_100 folder should have the climate files which are uncorrelated such as  bio01.asc, bio02.asc, bio03.asc, bio07.asc, bio08.asc, bio09.asc, bio_12.asc, bio_15.asc, bio_18.asc, bio_19.asc (buffered_400km_training_area) which is the same files as (/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Env_variable_100km/) 

To rerun the script from maxent.R (copy all the asc files from /netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Env_variable_100km/ to the Env_variables_100km/Best_variables folder in each replicate folder)

Candidate_model folder  has individual's model training characteristics.The best model selection is described in the next manual read me file.  
 
Information about the model parameters used are described in detail:

(a) Training and testing occurrences: We randomly split the presence occurrence sites into 70% training and 30% testing for evaluation. We created ten different random splitting replicates to prevent bias due to random splitting. 

(b) Feature classes:  We tested out all the combinations of the three feature classes named linear, quadratic, and product, which produced seven different combinations lq, lqp, q, l, qp, p, lp where linear features ‘l’ equal the continuous environmental variables, quadratic features ‘q’ equals the squares of the environmental variables and product ‘p’ features denote the products of the pairs of continuous environmental variables. For example, when a variable called precipitation is employed as a predictor, the linear feature class ensures that the predicted mean precipitation value aligns with the observed mean value where the species is present. A quadratic feature class limits the variance in rainfall at predicted occurrence sites to match observations, and a product feature class regulates the covariance of rainfall with other predictors, serving a role akin to interaction terms in regression, particularly when linear features are also part of the model.(Merow et al., 2013).

(c) Regularization multiplier:  We tested out ten different sets of regularization parameters 0.1, 0.25, 0.5, 0.75, 1, 2, 4, 6, 8, and 10, and they act as the penalty for the algorithm by controlling the trade-off between maximizing the likelihood of observed presences and minimizing model complexity through regularization. It serves to prevent overfitting by penalizing large parameter values. 

(d) Background points:  MaxEnt compares the occurrences of a species with background locations where presence or absence is not specifically recorded and primarily relies on contrasting presences with background locations to model species distribution. (Phillips and Dudik 2008). We sampled 50,000 background points to estimate environmental variation across the area of interest, determining species' habitat preferences. (Barber et al., 2021)

(e) Maximum iterations: We set the maximum interactions for the model to converge as 5000 as to enable the model to have adequate time to converge, thus, in turn, avoiding over-predictions and underpredictions.


