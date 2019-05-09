from unittest.mock import MagicMock, Mock, patch

import module_a


@patch('module_a.FileCheck.check', return_value=True)
def test_f1(mock_):
    a = module_a.ClassA()
    assert a.do_work() == True
