#!/bin/bash

plink --bfile ../cam --recode fastphase --keep-allele-order --double-id --out mydata
