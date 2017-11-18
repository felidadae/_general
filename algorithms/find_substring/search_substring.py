def build_table(p):
    table = [None] * len(p)
    for mi in range(len(p)):
        expected = p[mi]
        for new_begin in range(1, mi+1):
            if is_matching(new_begin, mi, p):
                table[mi] = new_begin
                break
        if table[mi] is None:
            table[mi] = mi+1
    return table


def is_matching(bi, mi, p):
    if bi == mi or p[bi:mi] == p[0:(mi-bi)]:
        #all previous position match; let's look at mismatch position
        expected=p[mi]
        if p[mi-bi] != expected:
            return True
    return False


def search(pattern, text):
    table = build_table(pattern)
    while b != len()


if __name__ == "__main__":
    t = build_table("papak")
    print(t)
    t = build_table("papapaszka")
    print(t)
