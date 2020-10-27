#---
# This script applies the calibration assistant function from "dycdTools" package to calibrate 
# the DYRESM-CAEDYM model for temperature simulation in Lake Okareka.
# Three parameters were tried in this process.
# Author: Songyan Yu
# Date created: 03/07/2020
#---

install.packages("dycdtools")
library(dycdtools)

calib.assist(cal.para = "../Calibration/Calibration_parameters.csv",
             combination = "random",n=3,
             model.var = c("TEMP"),
             obs.data = "../Calibration/Obs_data_template.csv",
             objective.function = c("NSE"),
             start.date="2002-01-23",
             end.date="2016-12-31",
             dycd.wd = "../Sim_DYCD",
             dycd.output = "../Sim_DYCD/DYsim.nc",
             file_name = "../Calibration.csv",
             write.out=TRUE,
             parallel=TRUE)

