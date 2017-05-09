class MyClass:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __repr__(self):
        return "{} {}".format(self.x, self.y)

    def __lt__(self, other):
        return self.x < other.x

a = MyClass(3,3)
b = MyClass(5,3)
c = MyClass(4,3)


print(sorted([a,b,c], reverse=True))
