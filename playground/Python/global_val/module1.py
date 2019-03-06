GLOBAL_VAR = [3,4,5]

def init():
    global GLOBAL_VAR
    GLOBAL_VAR = 1

def print_my_global():
    global GLOBAL_VAR
    print(GLOBAL_VAR)
