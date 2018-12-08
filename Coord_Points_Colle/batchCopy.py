#!/usr/bin/env python

# Fait par alain lismont le 08/12/2018

import shutil
import os
import glob
fiche=[]
fiche=glob.glob('/tmp/*.jpg')
print fiche[0]
shutil.copy(fiche[0],'/home/lismont/Mac/Coord_Points_Colle/data/Lot_piece69.jpg')
os.remove(fiche[0])
