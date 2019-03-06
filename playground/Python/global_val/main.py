from module1 import GLOBAL_VAR, init, print_my_global

if __name__ == "__main__":
    print("Before init()")
    print(GLOBAL_VAR)
    init()
    print("After init()")
    print_my_global()
    print(GLOBAL_VAR)
