# Pure measurement error functions for simulation:
#   getMSE
#   me_pure_data
#   me_pure

# Load the broom package for the tidy() function
pacman::p_load(broom, stringr,
               tidyverse
               )


# getMSE function:
getMSE <- function(obs,pred) {
    # obs is the outcome variable
    # pred is the prediction from a model
    obs_avg <- mean(obs)
    MSE_obs <- mean((obs - obs_avg) ^ 2)
    MSE_pred <- mean((obs - pred) ^ 2)
    result <- c(sqrt(MSE_pred),
                max(1 - MSE_pred / MSE_obs, 0))
    names(result) <-  c("RMSE", "R2(MSE-based)")
    
    return(result)
}

# simulate true exposure, mismeasured exposure, and the health outcome
# n_subj = 10000
me_pure_data <- function(n_subj = 10000) {
    # definition of terms:
    #   n_subj for subject sample size
    #   s for exposure model covariates (e.g., distance to road)
    #   y for outcome
    # # sd: define SDs for errors 
    #   sd_eta=4  is the SD for the error in the exposure model
    #   sd_e1=4   is the SD for the extra classical error of exposure
    #   sd_e2=4   is the SD for the extra classical error of exposure
    #   sd_e3=4   is the SD for the extra classical error of exposure
    #   sd_eps=25 is the SD for the error in the disease model
    # # alpha: exposure model parameters
    #   alpha_0=0 is the intercept parameter in the exposure model
    #   alpha[1]=4is the parameter for s1 in the exposure model
    #   alpha[2]=4is the parameter for s2 in the exposure model
    #   alpha[3]=4is the parameter for s3 in the exposure model
    # # beta: health model parameter
    #   beta[1]=1   is the intercept in the disease model
    #   beta[2]=2   is the slope in the disease model (called \beta_x in the lab)
    
    # define the coefficients alpha (for exposure models) and beta (for health models)
    alpha_0 <- 0
    alpha <- c(4, 4, 4) 
    beta  <- c(1, 2)
    
    # define the SDs for all the components for the subjects and samples 
    sd_s <- c(1, 1, 1)
    sd_eta <- 4
    sd_e <- c(4, 4, 4)
    sd_eps <- 25
    
    
    # create the subject dataset, using n_subj as supplied in the
    # function's parameter list:
    tibble( 
        # generate exposure predictors
        s_1 = rnorm(n = n_subj, mean = 0, sd = sd_s[1]),
        s_2 = rnorm(n_subj, sd = sd_s[2]), # mean 0 is the default so excluded below
        s_3 = rnorm(n_subj, sd = sd_s[3]),
        
        # generate the exposure
        x = alpha_0 + alpha[1] * s_1 + alpha[2] * s_2 + alpha[3] * s_3 +
            # add random noise
            rnorm(n_subj, sd = sd_eta),
        
        # association between exposure and outcome, with noise added
        y = beta[1] + beta[2] * x + rnorm(n_subj, sd = sd_eps),
        
        # estimate the true exposure (with Berkson error)
        Berk_1 = alpha_0 + alpha[1] * s_1,
        Berk_2 = alpha_0 + alpha[1] * s_1 + alpha[2] * s_2,
        Berk_3 = alpha_0 + alpha[1] * s_1 + alpha[2] * s_2 + alpha[3] * s_3,
        
        # add random noise to the exposure
        class_1 = x       + rnorm(n_subj, sd = sd_e[1]),
        class_2 = class_1 + rnorm(n_subj, sd = sd_e[2]),
        class_3 = class_2 + rnorm(n_subj, sd = sd_e[3])
    )
    
}


# pure measurement error for ONE simulation with n_subj
# use this with lapply() to repeat numerous times
me_pure <- function(n_subj = 10000){
    
    # simulated true exposures, exposures with error, and outcomes for subjects
    d <- me_pure_data(n_subj)
    # head(d)
    
    # list predictors in d, looking for x, berkson and classical variable names
    predictors <- str_subset(names(d), "x|Berk_|class_")
    # predictors
    
    # for each predictor, fit a health model
    
    # **NOTE: here, we are using 'MEASURED' (not predicted) exposures like we do in Like (vs Pure) measurement error scenarios**
    
    # i=predictors[1]
    ret <- lapply(predictors, function(i) {
        
        # specify formula
        frmla <- as.formula(paste("y ~", i))
        
        # fit linear model
        lmfit <- lm(frmla, data = d)
        
        #compile parameters of interest
        tibble(b1 = tidy(lmfit)$estimate[2],
               seb1 = tidy(lmfit)$std.error[2],
               R2_W_reg = cor(d[[i]],d$x)^2, # regression-based R2 for exposures
               R2_W_MSE = as.numeric(getMSE(d$x, d[[i]])[2]), # MSE-based R2 for exposures
               exp_var = var(d[[i]]) # variability of the exposure
        )
    }) %>% 
        
        # Set names for list items
        setNames(predictors) %>% 
        
        # bind list rows together
        bind_rows(.id = "predictor")
    
    # summarize results for one simulation with n_subj
    # ret
    return(ret)
}

