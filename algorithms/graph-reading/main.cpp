#include <iostream>
#include <sstream>

using namespace std;

/*
	memory: row0 row1 row2
*/
struct Matrix {
	int N;
	int* data;

	Matrix(int N) {
		this->N = N;
		data = new int [N*N]();
	}
	~Matrix() {
		delete[] data;
	}

	void setVal(int col, int row, int val) {
		data[col+row*N] = val;
	}
	int  getVal(int col, int row) {
		return data[col+row*N];
	}

	void print(std::string title) {
		cout << endl;
		cout << title << endl;
		for (int i = 0; i < N; ++i) {
			for (int j = 0; j < N; ++j)
				cout << data[i + j*N] << " ";
			cout << endl;
		}
		cout << endl;
	}
};

struct Vector {
	int N;
	int* data;

	Vector(int N) {
		this->N = N;
		data = new int [N]();
	}
};


struct Graph {
	int V_N;
	Matrix connectionMatrix;
	Matrix neighbours;
	Vector neighboursCounters;

	Graph(int V_N): connectionMatrix(V_N), neighbours(V_N), neighboursCounters(V_N) {
		this->V_N = V_N;
	}

	void setEdge(int b, int e, int w) {
		neighbours.setVal(b, neighboursCounters.data[b], e);
		connectionMatrix.setVal(b, e, w);
		++neighboursCounters.data[b];
	}
	int getEdge(int b, int e) {
		return connectionMatrix.getVal(b, e);
	}

	void printAll() {
		for (int i = 0; i < V_N; ++i)
		{
			if ( neighboursCounters.data[i] == 0 ) continue;
			cout << "For vertix V" << i << ": ";
			for (int j = 0; j < neighboursCounters.data[i]; ++j) {
				int neighbour = neighbours.getVal(i, j);
				int weight = connectionMatrix.getVal(i, neighbour);

				cout << "( neighbour=" << neighbour << ", weight="    << weight << " ) ";
			}
					
			cout << endl;
		}
	}
};



int main() {
	stringstream input;
	input << "5 3\n0 1 5\n1 2 10\n0 3 5";

	int V_N;
    input >> V_N;
    int E_N;
    input >> E_N;

    Graph graph(V_N);

    for (int i = 0; i < E_N; ++i)
    {
    	int b, e, w;
    	input >> b;
    	input >> e;
    	input >> w;

    	graph.setEdge(b,e,w);
    }

    graph.printAll(); 
    return 0;
}