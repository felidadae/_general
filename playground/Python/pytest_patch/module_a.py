import module_b

class ClassA:
    def do_work(self):
        file_check = module_b.get_item()
        return file_check.check()

class FileCheck:
    def check(a):
        return False

module_b.register(FileCheck)

print("inside module_a")
