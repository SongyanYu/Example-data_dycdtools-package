cls
del DYref.nc
del DYsim.nc
del morphinterp.out
Bin\createDYref.exe Okareka.stg Okareka.met Okareka.inf Okareka.wdr DYref.nc
Bin\createDYsim.exe Okareka.pro Okareka.par Okareka.con DYsim.nc
Bin\extractDYinfo.exe DYref.nc DYsim.nc Okareka.cfg
Bin\dycd.exe > dycd_auto.log