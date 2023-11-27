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

