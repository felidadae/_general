#!/usr/bin/env python3
"""
    simple tool to calculate weight of backback

    @todo:
    - fold by category, or parent_part
"""
import plot
from utilities import apply_fun, flat_print

EQUIPMENT_FILE="data/equipment.tsv"


def get_options():
    state = set() 
    def get_options_internal(header, vals, fun_state):
        fun_state.add(vals[header["option_name"]])
    apply_fun(EQUIPMENT_FILE, get_options_internal, state)
    return state


def calculate_taken_with_option(options, ignore_categories=set()):
    """

    """
    state_ = { "sum": 0, "items": [], "backpack_weight": 0 }

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
            if ift == "True":
                if (opt_n not in options_k) or (opt_n in options_k and opt_v == options[opt_n]):
                    if not get_col_val("weight") == "N/A":
                        name = "{}-{}-{}-{}".format(
                            get_col_val("category"),
                            get_col_val("parent_part"),
                            get_col_val("part_name"),
                            get_col_val("option_value"))
                        weight = int(get_col_val("weight"))
                        state["items"].append((name, weight))
                        state_["sum"] += int(get_col_val("weight")) * int(get_col_val("count"))
                        if get_col_val("part_name") == "backpack": state_["backpack_weight"] = int(get_col_val("weight"))

    apply_fun(EQUIPMENT_FILE, sum_options, state_) 

    # sort items
    state_["items"] = sorted(state_["items"], reverse=True, key=lambda item: item[1]) 

    state_["to_print"] = "Options: {}\nIgnored categories: {}\nSum: {}kg ({}% of my body)\nSum without backpack: {}kg ({}% of my body)\n{}".format(
        options, 
        ignore_categories,
		round(state_["sum"]/1000.0, 1),
        round(state_["sum"]/1000.0/79*100, 1),
		round((state_["sum"] - state_["backpack_weight"])/1000.0, 1),
        round((state_["sum"] - state_["backpack_weight"])/1000.0/79*100, 1),
        flat_print(
            [
                "name: {} weight: {} weight_all: {}%".format(
                    name, weight, round(weight/(state_["sum"]-state_["backpack_weight"])*100,2)) for name, weight in state_["items"]
            ]
        )
    )
    return state_
        

def main():
    r = calculate_taken_with_option(
        options = {
            "jacket-choice": "german", 
            "laptop-choice": "surface", 
            "tent-choice": "biwi-german",
            "burner-option": "solid-fuel"
        },
        ignore_categories = set(["computer"]))
    print(r["to_print"])
    plot.plot_pie(
        labels  = [name for name, _ in r["items"]], 
        sizes   = [weight for _, weight in r["items"]], 
        explode = [0]*len(r["items"]))


if __name__ == "__main__":
    main()
