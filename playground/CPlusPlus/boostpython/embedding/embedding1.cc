//Autor: Rafal Biedrzycki
#include <boost/python.hpp>
#include <iostream>

namespace py = boost::python;

int main()
{
	Py_Initialize();
	py::object main_module = py::import("__main__");
	py::object main_namespace = main_module.attr("__dict__");
	try
	{
		py::object noneType = py::exec( "result = 2*2", main_namespace );
		int res = py::extract<int>(main_namespace["result"]);
		std::cout << res << std::endl;
	}
	catch(py::error_already_set const &)
	{
		PyErr_Print();
	}
}
