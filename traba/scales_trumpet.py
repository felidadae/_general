import xlsxwriter


def trumpet_fingering():
    fingering = \
        "XXX, X*X, *XX, XX*, X**, *X*, ***, XXX, X*X, *XX, XX*, X**, *X*, ***, *XX, XX*, X**, *X*, ***, XX*, X**, *X*, ***"
    notes = "F# G G# A A# B C C# D D# E F F# G G# A A# B C C# D D# E"
    fingering = fingering.split(", ")
    notes = notes.split(" ")
    assert(len(fingering) == len(notes))
    assert(len(fingering) == 23)
    return fingering, notes
FINGERING, NOTES = trumpet_fingering()

def find_smallest_root(root):
    for index, note in enumerate(NOTES):
        if note == root:
            return index

def formula_to_indexes(formula):
    MAJOR_TO_INDEXES = {1:0, 2: 2, 3: 4, 4:5, 5:7, 6:9, 7:11}
    indexes = []
    formula_ = formula.split()
    for el in formula_:
        mapped = MAJOR_TO_INDEXES[int(el[-1])]
        if len(el) == 2:
            assert(el[0] == 'b')
            indexes.append(mapped-1)
        else:
            indexes.append(mapped)
    return indexes
assert formula_to_indexes("1 3 5") == [0,4,7]
assert formula_to_indexes("1 b3 b5") == [0,3,6]


def build_scale(root, formula):
    indexes = []
    fingerings = []
    root_index = find_smallest_root(root)
    formula_indexes = set(formula_to_indexes(formula))
    for index, note in enumerate(NOTES):
        if (index-root_index)%12 in formula_indexes:
            indexes.append(index)
            fingerings.append(FINGERING[index])
    return indexes, fingerings
build_scale("C", '1 3 5 7')
build_scale("C", '1')
build_scale("C", "1 2 3 4 5 6 7")
build_scale("C", "1 3 5 7") # arpeggio Cdur7
build_scale("C", "1 b3 5 b7") # arpeggio C-7
assert build_scale("A", "1")[0] == [3,15] 
assert build_scale("C", "1")[0] == [6,18]
assert build_scale("C", "1 3")[0] == [6,10,18,22]
assert build_scale("D", "1")[0] == [8,20]
assert build_scale("D", "1 3")[0] == [0,8,12,20]
assert build_scale("D#", "1 3")[0] == [1,9,13,21]
assert build_scale("E", "1 3")[0] == [2,10,14,22]


def create_sheet(formula="1 2 3 4 5 6 7"):
    global ROW, WORKBOOK, WORKSHEET
    cell_format = WORKBOOK.add_format()
    # cell_format.set_border()
    cell_format.set_underline()
    cell_format.set_bold()
    cell_format.set_italic()

    for index, note in enumerate(NOTES):
        WORKSHEET.write_string(ROW, index+1, NOTES[index])
    ROW += 1

    for root in "A A# B C C# D D# E F F# G G#".split():
        scale_indexes, _ = build_scale(root, formula)
        WORKSHEET.write_string(ROW, 0, root)

        for index, note in enumerate(NOTES):
            if index in scale_indexes:
                WORKSHEET.write_string(ROW, index+1, FINGERING[index], cell_format)
            else:
                WORKSHEET.write_string(ROW, index+1, FINGERING[index])
        ROW += 1
    ROW += 1
ROW = 0
WORKBOOK = xlsxwriter.Workbook("all_together.xlsx")
WORKSHEET = WORKBOOK.add_worksheet()
create_sheet('1 2 3 4 5 6 7')
create_sheet('1 3 5 7')
create_sheet('1 b3 5 b7')
create_sheet('1 2 b3 4 5 b6 b7')
WORKBOOK.close()
