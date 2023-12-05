library(tidyverse)
library(nloptr)
library(knitr)

### Sample ----

### Variables 
# R = recharge 
# alpha = constant (accounts for some percolation from irrigation)
# W_t = pumping = choice 
# H = height change 
# H = H_1 - H_0 

# need to define period 

### function 
height <- function(choice, H, R, alpha){
  
  H = H_1 - H_0 # need to add these as variables ? 
  
  H = R + (alpha - 1) * choice
  
  return(H) 
}


### options --- ??
options=list("algorithm"="NLOPT_LN_COBYLA",xtol_rel=1e-8,maxeval=16000)


### nloptr ---
output_1a=nloptr(x0 = 1, 
                 eval_f = height, 
                 lb = 0, 
                 opts = options, 
                 H = , # need 
                 R = , # need 
                 alpha = , # need 
                 )




### Maybe don't need this ? ----

### height function ---
height_funk <- function(choice, H_1, H_0, R, alpha) {
  
  ## vectors 
  state <- vector(mode = 'numeric', length = 0)
  
  ## initial value 
  state[1] = 0 #? 
  
  ## loop 
  for(i in 2:length(period)){
    
    # state[i] = R + (alpha - 1) * choice[i] # this is not going to work ? need to incorporate H = H_1 - H_0 somehow 
    # state[i] - state[i -1] = R + (alpha - 1) * choice[i]
   
     state[i] = (R + (alpha - 1) * choice[i]) + state[i - 1]
    
  }
}





### Kira Attempt ----

### Open access ---

## variables ---
# choice = W
# state = H ?
# R = 
# alpha =
# g = 
# k = 
# C_0 = 
# C_1 = 
# H_0 = 

## function ---
open_access <- function(g, k, C_0, C_1, H_0, R, alpha){
  
  choice = g + k*C_0 + k*C_1*H_0 
  
 #  H_1 = (R + (alpha - 1) * choice) + H_0 
  
  return(choice)
}

open_access(g =470365, 
            k = -3259, 
            C_0 = 125, 
            C_1 = -0.035, 
            H_0 = 3400, 
            R = 173000, 
            alpha = 1.73)

## options ---
options=list("algorithm"="NLOPT_LN_COBYLA",xtol_rel=1e-15,maxeval=16000) # need to confirm ? 

## nloptr ---
oa_output <- nloptr(x0 = 10, 
                    eval_f = open_access, 
                    opts = options, 
                    g = 470365, 
                    k = -3259, 
                    C_0 = 125, 
                    C_1 = -0.035, 
                    H_0 = 3400, 
                    R = 173000, 
                    alpha = 1.73) 

oa_output$solution

### optimally managed ---

## function ---
optimal <- function(choice, g, k, C_0, C_1, R, alpha, H_0, discount){
  
  ## vectors --- 
  state <- vector(mode = 'numeric', length = 0)
  benefits <- vector(mode = 'numeric', length = 0)
  
  ## initial values ---
  state[1] = H_0
  benefits[1] = ((g/k) * choice[1]) - ((k * (choice[1]^2)) / 2) - (C_0 - (C_1 * state[1])) * choice[1]
  
  ## loop ---
  for(i in 2:length(period)){
    
    state[i + 1] = (R + (alpha - 1) * choice[i]) + state[i]
    benefits[i + 1] = ((g/k) * choice[i]) - ((k * (choice[i]^2)) / 2) - (C_0 - (C_1 * state[i])) * choice[i]
    
  }
  
  ## sum ---
  t = seq(from = 0, period)
  pv = benefits * (1/(1+discount))^t
  npv = sum(pv)
  
  return(-npv)
  
}

### constraint function --- ?

### nloptr ---
opt_output <- nloptr(x0 = 10, 
                    eval_f = optimal, 
                    opts = options, 
                    g = 470365, 
                    k = -3259, 
                    C_0 = 125, 
                    C_1 = -0.035, 
                    H_0 = 3400, 
                    R = 173000, 
                    alpha = 1.73, 
                    discount = 0.5) 




# # OLD - open_access <- function(choice, R, alpha, H_0){
# 
# # vectors ---
# state <- vector(mode = 'numeric', length = 0)
# 
# # initial values ---
# state[1] = H_0 
# 
# # loop ---
# for(i in 2:length(period)){
#   
#   state[i] = (R + (alpha - 1) * choice[i]) + state[i - 1]
#   
# }
# 
# return()
# 
# }









