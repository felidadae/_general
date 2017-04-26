#!/usr/bin/python3

import os
import subprocess
import pathlib

# File extension descriptions.
# Format: "EXTENSION": [u"ICON","COLOR CODE"]
EXTENSIONS = {":FILE":	[u"", "216"],
              ":DIRECTORY":	[u"❂", "159"],
              "7z":			[u"", "229"],
              "ai":			[u"", "252"],
              "bat":		[u"", "85"],
              "bmp":		[u"", "252"],
              "bz":			[u"", "229"],
              "bz2":		[u"", "229"],
              "c":			[u"", "85"],
              "c++":		[u"", "85"],
              "cc":			[u"", "85"],
              "clj":		[u"", "85"],
              "cljc":		[u"", "85"],
              "cljs":		[u"", "85"],
              "coffee":		[u"", "85"],
              "conf":		[u"", "85"],
              "cp":			[u"", "85"],
              "cpp":		[u"", "85"],
              "css":		[u"", "85"],
              "cxx":		[u"", "85"],
              "d":			[u"", "85"],
              "dart":		[u"", "85"],
              "db":			[u"", "85"],
              "diff":		[u"", "85"],
              "dump":		[u"", "105"],
              "edn":		[u"", "85"],
              "ejs":		[u"", "85"],
              "erl":		[u"", "85"],
              "f#":			[u"", "85"],
              "fish":		[u"", "85"],
              "fs":			[u"", "85"],
              "fsi":		[u"", "85"],
              "fsscript":	[u"", "85"],
              "fsx":		[u"", "85"],
              "gif":		[u"", "252"],
              "go":			[u"", "85"],
              "gz":			[u"", "229"],
              "hbs":		[u"", "85"],
              "hrl":		[u"", "85"],
              "hs":			[u"", "85"],
              "htm":		[u"", "85"],
              "html":		[u"", "85"],
              "ico":		[u"", "252"],
              "ini":		[u"", "85"],
              "java":		[u"", "85"],
              "jl":			[u"", "85"],
              "jpeg":		[u"", "252"],
              "jpg":		[u"", "252"],
              "js":			[u"", "85"],
              "json":		[u"", "85"],
              "jsx":		[u"", "85"],
              "less":		[u"", "85"],
              "lhs":		[u"", "85"],
              "lua":		[u"", "85"],
              "markdown":	[u"", "105"],
              "md":			[u"", "105"],
              "ml":			[u"λ", "85"],
              "mli":		[u"λ", "85"],
              "mustache":	[u"", "85"],
              "php":		[u"", "85"],
              "pl":			[u"", "85"],
              "pm":			[u"", "85"],
              "png":		[u"", "252"],
              "psb":		[u"", "252"],
              "psd":		[u"", "252"],
              "py":			[u"", "85"],
              "pyc":		[u"", "85"],
              "pyd":		[u"", "85"],
              "pyo":		[u"", "85"],
              "rb":			[u"", "85"],
              "rlib":		[u"", "85"],
              "rs":			[u"", "85"],
              "rss":		[u"", "105"],
              "scala":		[u"", "85"],
              "scss":		[u"", "85"],
              "sh":			[u"", "85"],
              "slim":		[u"", "85"],
              "sln":		[u"", "85"],
              "sql":		[u"", "85"],
              "styl":		[u"", "85"],
              "suo":		[u"", "85"],
              "t":			[u"", "105"],
              "tar":		[u"", "229"],
              "ts":			[u"", "252"],
              "twig":		[u"", "85"],
              "txt":		[u"", "105"],
              "vim":		[u"", "85"],
              "xul":		[u"", "85"],
              "xz":			[u"", "229"],
              "yml":		[u"", "85"],
              "zip":		[u"", "229"],
              }

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
    meta_filenames = [
        "install.sh", "README", ".git",
        "README.sh", ".dev", 
        ".deprecated"]
    if str(el) in meta_filenames:
        return True
    else:
        return False

def add_icon_file(file_):
    import os.path
    ext = os.path.splitext(file_.name)[1][1:]
    if ext not in EXTENSIONS:
        ext = ":FILE"

    if file_.is_dir():
        ext=":DIRECTORY"
    return EXTENSIONS[ext][0]+"  "+str(file_)

def main_():
    meta  = [add_icon_file(file_) for file_ in pathlib.Path(".").iterdir() if is_meta_file(file_)]
    dirs  = [add_icon_file(dir_)  for dir_  in pathlib.Path(".").iterdir() if dir_.is_dir() and not is_meta_file(dir_)]
    files = [add_icon_file(file_) for file_ in pathlib.Path(".").iterdir() if file_.is_file()]

    def sort_and_to_str(cl):
        cl.sort()
        return "\n".join(cl)

    for cl, color in zip(
            [sort_and_to_str(meta), sort_and_to_str(dirs), sort_and_to_str(files)], 
            [bcolors.FAIL, bcolors.OKBLUE, bcolors.HEADER]):
        print(color + cl + bcolors.ENDC)

if __name__ == "__main__":
    main_()
