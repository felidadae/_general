#include <iostream>
#include <memory>
#include <vector>



struct Foo
{
    int k = 12;
    Foo()      			{ std::cout << "Foo::Foo\n";  }
    Foo(const Foo &) 	{ std::cout << "Foo::Foo\n";  }
    ~Foo()     			{ std::cout << "Foo::~Foo\n"; }
    void bar() 			{ std::cout << "Foo::bar\n";  }
};

void f(const Foo &)
{
    std::cout << "f(const Foo&)\n";
}

int seeSmartness()
{
    std::unique_ptr<Foo> p1(new Foo);  // p1 owns Foo

    if (p1) p1->bar();

    {
        std::unique_ptr<Foo> p2(std::move(p1));  // now p2 owns Foo
        f(*p2);

        p1 = std::move(p2);  // ownership returns to p1
        std::cout << "destroying p2...\n";
    }

    if (p1) p1->bar();

    // Foo instance is destroyed when p1 goes out of scope
}

int seeSmartness2() {
	std::vector<Foo> foos;
	Foo foo;

	foos.push_back(std::move(foo));

	return 0;
}





class CycledList
{
public:
	struct Node {
		Node () { std::cout << "Node() " << std::endl; next.reset(); }
		~Node() { std::cout << "~Node()" << std::endl; }

		int a;
		int b;

		std::shared_ptr<Node> next;
	};
	typedef std::shared_ptr<Node> PNode;

	CycledList (){ std::cout << "CycledList() " << std::endl; }
	~CycledList(){
		std::cout << "~CycledList() " << std::endl;
		if(tail) tail->next.reset();
	}

	void push_back(PNode node) {
		if (head)
		{
			tail->next = node;
			tail = tail->next;
			tail->next = head;
		}
		else {
			head = node;
			tail = node;
		}
	}

private:
	PNode head, tail;
};

int main()
{
	CycledList cycledList;

	{
		CycledList::PNode p1(new CycledList::Node());
		CycledList::PNode p2(new CycledList::Node());
		CycledList::PNode p3(new CycledList::Node());

		cycledList.push_back( p1 );
		cycledList.push_back( p2 );
		cycledList.push_back( p3 );
	}

	std::cout << "*****" << std::endl;

	return 0;
}
