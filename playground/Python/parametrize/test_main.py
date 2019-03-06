import pytest

@pytest.mark.parametrize('foo', ['a', 'b', 'c'])
@pytest.mark.parametrize('bar', [1, 2, 3])
def test_things(foo, bar):
    assert foo in ['a', 'b', 'c']
    assert bar in [1, 2, 3]
