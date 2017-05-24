## @defgroup Tests Code tests

## @defgroup TestsPySrvcpp Server tests (Python)
#  @ingroup Tests
#  @{

## @file test_srvcpp.py
#  @brief tests the C++ library from Python
#

import unittest, time, datetime
import hello

class TestBase(unittest.TestCase):
    """test case"""

    def test01GetText(self):
        self.assertTrue( hello.getText() == "hello, world!" )
        return

    def test02(self):
        a = hello.Derived(3)
        self.assertTrue( a.get() == 3 )
        return

    def test03Time(self):
        a = hello.Derived(1)
        a = hello.Derived(2)
        a = hello.Derived(3)
        self.assertTrue( a.get() == 3 )
        return

if __name__ == "__main__":
    #runs test if executed as a script
    print '---- start C++ library python interface tests ----'
    unittest.main()

## @}

