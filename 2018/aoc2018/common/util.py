def read_file(path):
    file = open(path, "r")
    lines = file.read().split("\n")
    file.close()
    return lines