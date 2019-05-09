registry = []

def register(cls):
    global registry
    import ipdb; ipdb.set_trace()
    registry.append(cls)

def get_item():
    global registry
    return registry[0]()
