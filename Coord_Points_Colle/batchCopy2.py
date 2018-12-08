import shutil
import os
import glob
source = os.listdir("/home/ALI/")
destination = "/ALI/ALI2/"
for files in source:
    if files.endswith(".bat"):
        shutil.move(files,destination)

