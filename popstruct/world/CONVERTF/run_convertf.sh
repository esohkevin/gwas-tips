#!/bin/bash


# Convert files into eigensoft compartible formats
convertf -p par.PED.PACKEDPED 	# ped to packedped
convertf -p par.PACKEDPED.PACKEDANCESTRYMAP	# packedped to packedancestrymap
convertf -p par.PACKEDANCESTRYMAP.ANCESTRYMAP	# packedancestrymap to ancestrymap
convertf -p par.ANCESTRYMAP.EIGENSTRAT	# ancestrymap to eigenstrat

