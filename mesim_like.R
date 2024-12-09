# "Like" measurement error functions for simulation:
#   getMSE
#   create_dataset
#   me_like

# Load the broom package for the tidy() function
# (only needed if the calling code doesn't load these)
pacman::p_load(broom, modelr)


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

# define function to create dataset
create_dataset <- function(n, sd_s, sd_eta, alpha_0, alpha) {
    tibble(
        # exposure predictors
        s_1 = rnorm(n, sd = sd_s[1]),
        s_2 = rnorm(n, sd = sd_s[2]),
        s_3 = rnorm(n, sd = sd_s[3]),
        
        # generate true exposure
        x = alpha_0 + alpha[1] * s_1 + alpha[2] * s_2 + alpha[3] * s_3 + 
            rnorm(n, sd = sd_eta)
    )
}

# me_like function
# n_subj = 10000
# n_samp = 100
# s3_sd1 = 1
# s3_sd2 = 0.3

me_like <- function(n_subj = 10000, n_samp = 100, s3_sd1 = 1, s3_sd2 = 0.3) {
    # definition of terms:
    #   n for sample size (n_subj and n_samp), referring to subject and
    #       samples/monitors, respectively
    #   s for exposure model covariates (predictors of the exposure)
    #   y for outcome
    # the following terms are passed from outside if not using defaults:
    #   n_subj=10,000 (default) is the no. subjects
    #   n_samp=100 (default) is the no. monitors/monitor locations/exposure samples
    #   s3_sd is the SD for the s3 variable in the sample 
    #       and defaults to be 1 or 0.3  (All other SDs for the s's are 1)
    #       s3_sd1=1   (default) SD(s3) for subjects and monitor group 1
    #       s3_sd2=0.3 (default) SD(s3) for monitor group 2
    # the following terms are set inside the program:
    #   sd_eta=4 is the SD for the error in the exposure model
    #   sd_eps=25 is the SD for the error in the disease model
    #   alpha1=4  is the parameter for s1  in the exposure model
    #   alpha2=4  is the parameter for s2  in the exposure model
    #   alpha3=4  is the parameter for s3  in the exposure model
    #   beta0=1   is the intercept in the disease model
    #   beta1=2   is the slope in the disease model
    
    # define the exposure and health model parameters for fixed effects
    alpha_0 <- 0
    alpha <- c(4, 4, 4) 
    beta  <- c(1, 2)
    
    # define the SDs for all the components for the subjects and samples
    # Note:  for sd1, the true and sample1 dataset will have the same SDs
    sd1_s <- c(1, 1, s3_sd1)
    sd2_s <- c(1, 1, s3_sd2) # different SD for the 3rd variable
    sd_eta <- 4
    sd_e <- c(4, 4, 4)
    sd_eps <- 25
    
    # create the subject dataset, using n_subj as supplied in the
            # generate exposures x based on predictors (s_) 
    subj <- create_dataset(n_subj, sd1_s, sd_eta, alpha_0, alpha) %>% 
        # simulate the outcome for each subject
        mutate(y = beta[1] + beta[2] * x + rnorm(n_subj, sd = sd_eps))
    
    # head(subj)
    
    # now create the 1st monitoring dataset drawn from the SAME distribution as the subject data
    # inputs are the same other than the sample size is smaller
    samp1 <- create_dataset(n_samp, sd1_s, sd_eta, alpha_0, alpha)
    
    # head(samp1)
    
    # now create the 2nd monitoring dataset drawn from a DIFFERENT distribution
    # not the same as the subject data distribution
    samp2 <- create_dataset(n_samp, sd2_s, sd_eta, alpha_0, alpha)
    
    ################################################################################
    # now develop exposure predictions using the FIRST monitor dataset and predict on the subjects
    
    #################################
    # Fully specified exposure model
    lm_1full <- lm(x ~ s_1 + s_2 + s_3, data = samp1)
    
    # collect 1full model parameters 
    one_full <- tibble(a3hat = tidy(lm_1full)$estimate[4], 
                       a3var = tidy(lm_1full)$std.error[4]^2, 
                       r2 = glance(lm_1full)$r.squared, # exposure model reg-based R2
                       r2_MSE = as.numeric(getMSE(samp1$x, lm_1full$fitted.values)[2]) # exposure model MSE-based R2
                       )
    
    # head(one_full)
    
    #################################
    # Reduced exposure model (simulate a situation where the model was not fit properly b/c it is missing an important predictor)
    lm_1red <- lm(x ~ s_1 + s_2, data = samp1)
    
    # collect 1red model parameters (use NA to hold the place of values we don't
    # want for the reduced model but will be in our summary table)
    one_red <- tibble(a3hat = NA, 
                      a3var = NA, 
                      r2 = glance(lm_1red)$r.squared,
                      r2_MSE = as.numeric(getMSE(samp1$x, lm_1red$fitted.values)[2])
                      )
    
    # head(one_red)
    
    ################################################################################
    # Now develop exposure predictions using the SECOND monitor dataset and predict on the subjects
    
    #################################
    # Fully specified exposure model
    lm_2full <- lm(x ~ s_1 + s_2 + s_3, data = samp2)
    
    # collect 2full model parameters 
    two_full <- tibble(a3hat = tidy(lm_2full)$estimate[4], 
                       a3var = tidy(lm_2full)$std.error[4]^2, 
                       r2 = glance(lm_2full)$r.squared,
                       r2_MSE = as.numeric(getMSE(samp2$x, lm_2full$fitted.values)[2])
                       )
    
    #################################
    # Reduced exposure model
    lm_2red <- lm(x ~ s_1 + s_2, data = samp2)
    
    # collect 2red model parameters (use NA to hold the place of values we don't
    # want for the reduced model)
    two_red <- tibble(a3hat = NA, 
                      a3var = NA, 
                      r2 = glance(lm_2red)$r.squared,
                      r2_MSE = as.numeric(getMSE(samp2$x, lm_2red$fitted.values)[2]) 
                      )
    
    ################################################################################
    
    # add predictions from all models to subject dataframe
    subj <- subj %>%
        add_predictions(lm_1full,"xhat_1full") %>% 
        add_predictions(lm_1red,"xhat_1red") %>% 
        add_predictions(lm_2full,"xhat_2full") %>% 
        add_predictions(lm_2red,"xhat_2red")
    
    # head(subj)
    # collect key exposure model statistics 
    predictor <- list(x = c(a3hat = NA, a3var = NA, r2 = NA, r2_MSE = NA),
                      xhat_1full = one_full,
                      xhat_1red = one_red,
                      xhat_2full = two_full,
                      xhat_2red = two_red)
    
    # descriptively name these for future use
    exposure_vars <- names(predictor)
    
    ################################################################################
    # run health model for each exposure type (true and mismeasured)
    
    return_list <- lapply(exposure_vars, function(i) {
        
        # fit model for outcome, y and and exposure variable i (x [true exposure] or x hat [predicted exposure]) 
        # i's are: exposure_vars
        lmfit <- lm(subj$y ~ subj[[i]])
        
        # save variables of interest
        tibble(b1 = tidy(lmfit)$estimate[2], 
               seb1 = tidy(lmfit)$std.error[2],
               exp_var = var(subj[[i]]), 
               a3hat = predictor[[i]][["a3hat"]], 
               a3var = predictor[[i]][["a3var"]], 
               R2_W_reg = predictor[[i]][["r2"]],
               R2_W_MSE = predictor[[i]][["r2_MSE"]]
               )
    }) %>% 
        
    # set names for list items
    setNames(exposure_vars) %>% 
        
    # bind list elements
    bind_rows(.id = "exposure_vars")
    
    
    # Return estimated health effects and model fit parameters from the different exposures (true and with measurement error)
    return(return_list)
}
