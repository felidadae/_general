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
    b=0
    i=0

    while b < len(text) - len(pattern) + 1:
        if pattern[i] == text[b+i]:
            if i == len(pattern) - 1:
                return (True, b) 
            else:
                i += 1
        else:
            # we know we have mismatch at >>i<< position
            b_shift = table[i]
            b_new = b + b_shift
            i_new = i - b_shift if b_shift <= i else 0
            i = i_new
            b = b_new

    return False
         

if __name__ == "__main__":
    r = search("kupa", "pan kupa kupy je")
    print(r)

    r = search("papak", "papapapapakzka")
    print(r)
