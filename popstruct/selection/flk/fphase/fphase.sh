#!/bin/bash

#--- Run fastPhase with only 1 EM run and assess cross-validation error (K-parameter)
fastPHASE -T1 -F -KL10 -KU30 -Ki5 -oMyresults mydata.chr-21.recode.phase.inp
