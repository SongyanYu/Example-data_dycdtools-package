#---
# This script visualises DYRESM-CAEDYM modelling outputs for Lake Okareka in four different ways.
# 1) contour plot
# 2) profile plot
# 3) time series plot
# 4) scatter plot
#
# This script comes with the publication of R package dycdtools.
# Author: Songyan Yu
# Date created: 06/07/2020
#---

# This script should be used after you have chosen the best combination of parameter values based on 
# the results from running the calibration assistant function (i.e. "01_calibration assistant.R")
# make sure the simulation results are stored in the "Sim_DYCD" folder.

library(dycdtools)

# simulation period
library(lubridate)
sim.date<-seq.Date(from = as.Date("2002-01-23",format="%Y-%m-%d"),
                   to = as.Date("2006-12-31",format="%Y-%m-%d"),
                   by="day")

# DYCD temperature simulations using the optimal set of the three parameters
var.values<-ext.output(dycd.output = "../Sim_DYCD/DYsim.nc",
                       var.extract = c("TEMP"))

for(i in 1:length(var.values)){
  expres<-paste0(names(var.values)[i],"<-data.frame(var.values[[",i,"]])")
  eval(parse(text=expres))
}

# interpolation of temperature across water column at an intervals of 0.5m
temp.interpolated<-interpol(layerHeights = dyresmLAYER_HTS_Var,
                            var = dyresmTEMPTURE_Var,
                            min.dept = 0,max.dept = 33,by.value = 0.5)
#---
# Read in obs wq data
#---
obs.okareka<-read.csv("../Calibration/Obs_data_template.csv")
is.Date(obs.okareka$Date)
obs.okareka$Date<-as.Date(obs.okareka$Date,format="%d/%m/%Y")

obs.temp<-obs.okareka[,c(1,2,3)]

#---
# contour plot
#---
plot_cont_comp(sim = temp.interpolated,
             obs = obs.temp,
             file_name = paste0("../contour_temp.png"),
             start.date="2002-01-01",
             end.date="2016-12-31",
             legend.title = "T\n(\u00B0C)",
             min.depth = 0,
             max.depth = 33,
             by.value = 0.5)

#---
# profile plot
#---
plot_prof(sim=temp.interpolated,
          obs = obs.temp,
          sim.start = "2002-01-23",
          sim.end = "2016-12-31",
          plot.start = "2002-01-23",
          plot.end = "2002-12-31",
          file_name = "../profile plot_temp.png",
          min.depth = 0,
          max.depth = 33,
          by.value = 0.5,
          xlabel = "Temperature \u00B0C",
          height = 4,
          width = 7,
          plot.save = TRUE)

#---
# time serise plot
#---
plot_ts(sim = temp.interpolated,
        obs = obs.temp,
        file_name=paste0("../TS_temp.png"),
        target.depth=c(1,14,30),
        sim.start="2002-01-23",
        sim.end="2016-12-31",
        plot.start = "2002-01-23",
        plot.end="2012-12-31",
        min.depth=0,
        max.depth=33,
        by.value=0.5,
        ylabel="Temperature \u00B0C",
        height = 4,
        width = 7,
        plot.save = TRUE)

#---
# scatter plot
#---
plot_scatter(sim=temp.interpolated,
             obs=obs.temp,
             sim.start="2002-01-23",
             sim.end="2016-12-31",
             plot.start = "2002-01-23",
             plot.end="2012-12-31",
             file_name = "../scatter plot_temp.png",
             min.depth = 0,
             max.depth = 33,
             by.value = 0.5,
             height = 4,
             width = 7,
             plot.save = TRUE)

