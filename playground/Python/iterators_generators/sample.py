from random import choice

class ShittyIterable(object):
    def __init__(self):
        self.data = [1,2,3,4,5]

    def __getitem__(self, i):
        return self.data[i]

    def __len__(self):
        return len(self.data)
        

if __name__ == "__main__":
    k = ShittyIterable()
    print(k[1:3])
    print(choice(k))
