def apply_fun(tsv_file, fun, fun_state):
    with open(tsv_file, 'r') as fref:
        header = {}

        for il, line in enumerate(fref):
            vals = line.rstrip().split('\t')
            if il == 0:
                header = { col_name: col_index for col_index, col_name in enumerate(vals) }
                continue
            fun(header, vals, fun_state)

    return fun_state


def flat_print(list):
    return ("\n".join(list))


