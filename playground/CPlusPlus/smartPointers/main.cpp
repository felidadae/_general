#include <iostream>
#include <memory>
#include <vector>



struct Foo {
    int k = 12;
    Foo()      			{ std::cout << "Foo::Foo\n";  }
    Foo(const Foo &) 	{ std::cout << "Foo::Foo\n";  }
    ~Foo()     			{ std::cout << "Foo::~Foo\n"; }
    void bar() 			{ std::cout << "Foo::bar\n";  }
};

void f(const Foo &) {
    std::cout << "f(const Foo&)\n";
}

void seeSmartness() {
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




/*
 *  tail->next points to head, head to first element;
 *  when size == 1:
 *      head and tail points to the only element, tail->next points to itself
 **/
template<typename NodeVal>
class CycledList {
public:

    struct Node;
	typedef std::shared_ptr<Node> PNode;
	struct Node {
		Node () { std::cout << "Node() " << std::endl; next.reset(); }
		Node (const NodeVal& node_val) { 
            this->data_ = node_val; /* assignment operator must be defined */
        }
		~Node() { std::cout << "~Node()" << std::endl; }

        NodeVal data_;
		PNode next;
	};

	CycledList (){ std::cout << "CycledList() " << std::endl; }
	~CycledList(){
		std::cout << "~CycledList() " << std::endl;
		if(tail) tail->next.reset();
	}

    /* makes copy of NodeVal */
	void push_back(const NodeVal& val) {
        PNode new_node(new Node(val)); 
		if (head) {
			tail->next = new_node;
			tail = tail->next;
			tail->next = head;
		} else {
			head = new_node;
			tail = new_node;
		}
	}

    struct iterator {
        PNode start_;
        PNode state_;
        iterator(const PNode& start) {
            start_ = start;
            state_ = start_;
        }
        bool operator!=(const iterator& other) {
            return this->state_ != other.state_;
        }
        const NodeVal& operator*() {
            return (const NodeVal &)this->state_->data_; 
        }
        void operator++() {
            state_ = state_->next;
        }
    };

    iterator begin() {
        return iterator(this->head);
    }
    iterator end() {
        return iterator(this->tail);
    }

private:
	PNode head, tail; 
};

int main() {
	{
        CycledList<std::string> cycledList;
		cycledList.push_back( std::string("pierwszy") );
		cycledList.push_back( std::string("drugi")    );
		cycledList.push_back( std::string("trzeci")   );
        for (const std::string& node_val: cycledList) {
            std::cout << node_val << std::endl;
        }
	}
	std::cout << "*****" << std::endl;
	return 0;
}
