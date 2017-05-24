//Autor: Rafal Biedrzycki
#include <boost/python.hpp>
#include <iostream>

namespace py = boost::python;

struct Cat
{
		std::string greet() { return "miau"; }
};

BOOST_PYTHON_MODULE(zpr)
{
		py::class_<Cat>("Cat")
				.def("greet", &Cat::greet)
		;
}

int main()
{
	Py_Initialize();
	if (PyImport_AppendInittab("zpr", initzpr) == -1)
		throw std::runtime_error("Failed to add zpr to the interpreter's builtin modules");

	py::object main_module = py::import("__main__");
	py::object main_namespace = main_module.attr("__dict__");
	try
	{
		py::object noneType = py::exec( "import zpr\n"
			"cat = zpr.Cat()\n"
			"print cat.greet()\n", main_namespace );
	}
	catch(py::error_already_set const &)
	{
		PyErr_Print();
	}
}
