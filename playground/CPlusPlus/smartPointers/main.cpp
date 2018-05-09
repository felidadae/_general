#include <iostream>
#include <memory>
#include <vector>



/*
 *  tail->next points to head, head to first element;
 *  when size == 1:
 *      head and tail points to the only element, tail->next points to itself
 *
 *  Problem:
 *  iterating through cycled list through all the elements: first, end, last
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
		if(tail) tail->next.reset(); /* breaks the loop */
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
        PNode last_;
        PNode state_;
        bool if_after_last_ = false;

        iterator(const PNode& start, const PNode& last) {
            start_ = start;
            state_ = start_;
            last_ = last;
        }
        bool operator!=(const iterator& other) {
            if (this->if_after_last_ != other.if_after_last_) return true;
            return this->state_ != other.state_;
        }
        const NodeVal& operator*() {
            return (const NodeVal &)this->state_->data_;
        }
        void operator++() {
            if (state_ == last_) {
                /* state_.reset(); */
                if_after_last_ = true;    
            }
            else
                state_ = state_->next;
        }
    };

    iterator begin() {
        return iterator(this->head, this->tail);
    }
    iterator end() {
        iterator after_last(this->tail, this->tail);
        ++after_last;
        return after_last;
    }

private:
	PNode head, tail; 
};

int main() {
	{
        CycledList<std::string> cycledList;
		cycledList.push_back( std::string("one") );
		cycledList.push_back( std::string("two")    );
		cycledList.push_back( std::string("three")   );
        for (const std::string& node_val: cycledList)
            std::cout << node_val << std::endl;
	}
	std::cout << "*****" << std::endl;
	return 0;
}
