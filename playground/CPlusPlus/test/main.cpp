#include <boost/test/minimal.hpp>


void fun() {
	BOOST_CHECK( 1 == 2 );
	BOOST_ERROR( "blad" );
	BOOST_FAIL( "blad krytyczny");
}

int test_main(int, char* [] ) {
	fun();
	return 0;
}

