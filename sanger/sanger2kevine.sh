#!/bin/bash

sangerpath="$1"
kevinepath="$3"


globus transfer 19934af6-a465-11e8-96ee-0a6d4e044368:${sangerpath} a9154d42-258d-11e9-9835-0262a1f2f698:${kevinepath} --recursive
