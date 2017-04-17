import os
import subprocess
import pathlib


class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def is_meta_file(el):
    meta_filenames = ["install.sh", "README", "README.sh", ".dev"]
    if str(el) in meta_filenames:
        return True
    else:
        return False


pathToCurrFile = (os.path.dirname(os.path.abspath(__file__)))
os.chdir(pathToCurrFile)

meta  = [str(file_) for file_ in pathlib.Path(".").iterdir() if is_meta_file(file_)]
dirs  = [str(dir_)  for dir_  in pathlib.Path(".").iterdir() if dir_.is_dir()]
files = [str(file_) for file_ in pathlib.Path(".").iterdir() if file_.is_file()]

def sort_and_to_str(cl):
    cl.sort()
    return "\n".join(cl)

for cl, color in zip(
        [sort_and_to_str(meta), sort_and_to_str(dirs), sort_and_to_str(files)], 
        [bcolors.FAIL, bcolors.OKGREEN, bcolors.HEADER]):
    print(color + cl + bcolors.ENDC)
