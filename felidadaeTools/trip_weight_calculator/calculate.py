#!/usr/bin/env python3
"""
    simple tool to calculate weight of backback
"""

def apply_fun(fun, fun_state):
    with open('data/equipment.tsv', 'r') as fref:
        header = {}

        for il, line in enumerate(fref):
            vals = line.rstrip().split('\t')
            if il == 0:
                header = { col_name: col_index for col_index, col_name in enumerate(vals) }
                continue
            fun(header, vals, fun_state)

    return fun_state


def get_options():
    state = set() 
    def get_options_internal(header, vals, fun_state):
        fun_state.add(vals[header["option_name"]])
    apply_fun(get_options_internal, state)
    return state


def calculate_taken():
    state_ = { "sum": 0, "items": [] }

    def sum_internal(header, vals, state):
        def get_col_val(col_name):
            return vals[header[col_name]]
        if get_col_val("if_taken") == "True":
            print("name: {}-{}-{}-{}".format(
                get_col_val("category"),
                get_col_val("parent_part"),
                get_col_val("part_name"),
                get_col_val("option_value")))
            state_["sum"] += int(get_col_val("weight")) * int(get_col_val("count"))

    apply_fun(sum_internal, state_) 
    return state_


def flat_print(list):
    return ("\n".join(list))


def calculate_taken_with_option(options, ignore_categories=set()):
    state_ = { "sum": 0, "items": [] }

    def sum_options(header, vals, state):
        def get_col_val(col_name):
            return vals[header[col_name]]
        
        # abbreviations
        options_k = options.keys()
        ift = get_col_val("if_taken")
        cat = get_col_val("category")
        opt_n = get_col_val("option_name")
        opt_v = get_col_val("option_value")

        if not cat in ignore_categories:
            if ift:
                if (opt_n not in options_k) or (opt_n in options_k and opt_v == options[opt_n]):
                    state["items"].append("name: {}-{}-{}-{}".format(
                        get_col_val("category"),
                        get_col_val("parent_part"),
                        get_col_val("part_name"),
                        get_col_val("option_value")))
                    state_["sum"] += int(get_col_val("weight")) * int(get_col_val("count"))

    apply_fun(sum_options, state_) 
    state_["to_print"] = "Options: {}\nIgnored categories: {}\nSum: {}kg\n{}".format(
        options, ignore_categories, state_["sum"]/1000.0, flat_print(state_["items"]))
    return state_
         

if __name__ == "__main__":
    r = calculate_taken_with_option(
        options = {
            "jacket-choice": "new", 
            "laptop-choice": "surface", 
            "burner-option": "solid-fuel"
        },
        ignore_categories = set())
    print(r["to_print"])
