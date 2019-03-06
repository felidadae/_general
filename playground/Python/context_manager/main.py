def f():
    raise Exception("dupa")
def f2():
    for i in range(10):
        try:
            f()
        except Exception as e:
            print("Poczatek oblsuginwania wyjatku")
            raise Exception("Wyjatek z wyjatku ziom!")
            return "Powrotny z wyjatku"
        except InvalidArgumentException as e:
            print("dupa") 
        finally:
            print("Finally przed wyjatkiem")
            raise Exception("Wyjatek rzucone w finally")
            print("Finally po wyjatku")
    print("Some shitty code")
    return "Powrot normalny"

if __name__ == "__main__":
    print(f2())
