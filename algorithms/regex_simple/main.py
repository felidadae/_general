from collections import namedtuple
Counter = 0

class RegexGraph(object):
    def __init__(self, regex):
        """ regex <- string representing regex formula """
        global Counter 
        Counter = 0
        self.head = None 
        regex_atoms = self.parse_regex_formula(regex)
        self.build_graph(regex_atoms)

    RegexAtom = namedtuple("RegexAtom", ["character", "multiply"])
    MULTIPLY_ANYTIME = -1
    MULTIPLY_ONCE = 1

    def parse_regex_formula(self, regex_formula):
        atoms = []; i = 0
        atoms.append( self.RegexAtom("BEGIN", 1) )
        while i != len(regex_formula):
            if (i+1) != len(regex_formula) and regex_formula[i+1] == "*":
                atoms.append( self.RegexAtom(regex_formula[i], -1) ); i += 2
            else:
                atoms.append( self.RegexAtom(regex_formula[i],  1) ); i += 1
        atoms.append( self.RegexAtom("END", 1) )
        return atoms

    def build_graph(self, regex_atoms):
        # create all graph nodes on the beginning and put into array 
        self.nodes = []
        for atom in regex_atoms:
            self.nodes.append( GraphNode(atom.character) )
        self.head = self.nodes[0]
        
        self.N = len(self.nodes); N = self.N

        # link i and i+1 node
        for i in range(N-1):
            self.nodes[i].add_child(self.nodes[i+1]) 

        optional_left, optional_right = (None, None) 
        is_optional_open = False

        iatom = 0 
        while iatom != N:
            atom = regex_atoms[iatom]
            next_atom = regex_atoms[iatom+1] if iatom+1 < len(regex_atoms) else False

            if atom.multiply == self.MULTIPLY_ANYTIME:
                optional_right = iatom
                iatom += 1
            elif not is_optional_open and next_atom and next_atom.multiply == self.MULTIPLY_ANYTIME:
                optional_left = optional_right = iatom
                is_optional_open = True
                iatom += 1
            elif is_optional_open:
                self.build_half_clique(optional_left, optional_right+1)
                is_optional_open = False
            else:
                iatom += 1

    def build_half_clique(self, optional_left, optional_right):
        for i in range(optional_left, optional_right+1):
            for j in range(i+1, optional_right+1):
                if j == i + 1: continue
                self.nodes[i].add_child(self.nodes[j])
        #loops
        for i in range(optional_left, optional_right+1):
            if i != optional_left and i != optional_right:
                self.nodes[i].add_child(self.nodes[i])
        return

    def __repr__(self):
        def to_string(node):
            return str(node) + '\n'
        result = ''
        fun = to_string
        visits = [False] * Counter
        to_visit = [self.head]
        while to_visit:
            wlk = to_visit.pop()
            if not visits[wlk.id]:
                result += fun(wlk)
                visits[wlk.id] = True
                to_visit.extend([n for n in wlk.get_all_children_flat() if not visits[n.id]])
        return result

    def is_match(self, txt):
        stack = [(0, self.head)] 
        while stack:
            p,node = stack.pop()
            if p == len(txt):
                if "END" in node.children:
                    return True
            elif txt[p] in node.children or "." in node.children:
                stack.extend([(p+1, child) for child in node.get_children_matching(txt[p])])
        return False


class GraphNode(object):
    def __init__(self, last_char):
        self.is_final = True if last_char == "END" else False
        self.last_char = last_char
        global Counter; self.id = Counter; Counter += 1
        self.children = {}

    def __repr__(self):
        return_val = ""
        return_val += "*****\n"
        return_val += "id: {}\n".format(self.id)
        return_val += "is_final: {}\n".format(self.is_final)
        return_val += "last_character: {}\n".format(self.last_char)
        return_val += "children: {}\n".format(" ".join(
            [str(child.id) + "-->" + str(child.last_char) for child in self.get_all_children_flat()]
        ))
        return_val += "*****\n"
        return return_val

    def get_all_children_flat(self):
        all = []
        for key in self.children.keys():
            all.extend(self.children[key])
        return all

    def add_child(self, child):
        """ child is of class GraphNode """
        if not child.last_char in self.children:
            self.children[child.last_char] = [child]
        else:
            self.children[child.last_char].append(child)

    def get_children_matching(self, character):
        result = []
        if character in self.children: result.extend(self.children[character])
        if "." in self.children: result.extend(self.children["."])
        return result 


import unittest
class MyTestCase(unittest.TestCase):
    # def test_1(self):
    #     regex_graph = RegexGraph("ab*c*d")
    #     self.assertTrue(regex_graph.is_match("abcd"))
    #     self.assertTrue(regex_graph.is_match("abbccd"))
    #     self.assertTrue(regex_graph.is_match("accd"))
    #     self.assertTrue(regex_graph.is_match("ad"))
    #     self.assertFalse(regex_graph.is_match("add"))

    # def test_2(self):
    #     regex_graph = RegexGraph("b*c*")
    #     self.assertTrue(regex_graph.is_match("bc"))
    #     self.assertTrue(regex_graph.is_match("b"))
    #     self.assertTrue(regex_graph.is_match("bb"))
    #     self.assertTrue(regex_graph.is_match(""))
    #     self.assertTrue(regex_graph.is_match("bbbcc"))
    #     self.assertFalse(regex_graph.is_match("addd"))
    #     self.assertFalse(regex_graph.is_match("bccd"))
    #     self.assertFalse(regex_graph.is_match("abcc"))

    # def test_3(self):
    #     regex_graph = RegexGraph("a*b*abc*")
    #     self.assertFalse(regex_graph.is_match("ababbbbabccc"))
    #     self.assertTrue(regex_graph.is_match("abbbbbabccc"))
    #     self.assertTrue(regex_graph.is_match("ab"))
    #     self.assertTrue(regex_graph.is_match("aaaab"))
    #     self.assertTrue(regex_graph.is_match("abc"))

    # def test_4(self):
    #     regex_graph = RegexGraph(".*")
    #     self.assertTrue(regex_graph.is_match("aaa"))
    #     self.assertTrue(regex_graph.is_match(""))
    #     self.assertTrue(regex_graph.is_match("baxc"))

    # def test_5(self):
    #     regex_graph = RegexGraph("a*.*b*.*a*aa*a*")
    #     self.assertFalse(regex_graph.is_match("acaabbaccbbacaabbbb"))

    def test_6(self):
        regex_graph = RegexGraph("ab*ac*a")
        print(regex_graph)
        self.assertTrue(regex_graph.is_match("aaa"))


if __name__ == "__main__":
    unittest.main()
