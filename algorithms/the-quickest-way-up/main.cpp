#include <iostream>
#include <sstream>

using namespace std;



struct Matrix {
	/*
		memory: row0 row1 row2
	*/

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

struct DVHeap {
	struct DV {
		int d; //distance
		int v; //vertex
	};
	DV* data;
	int N;
	int _N;
	DVHeap(int maxElements) {
		data = new DV[maxElements];
		N = maxElements;
		_N = 0;
	}
	~DVHeap() {
		delete[] data;
	}
	bool empty() { return _N == 0; }
	DV seeMin() {
		return data[0];
	}
	void swap(int i, int j) {
		DV tmp = data[j];
		data[j] = data[i];
		data[i] = tmp;
	}
	DV popMin() {
		if (_N == 0) throw (5);

		DV min = data[0];
		data[0] = data[_N-1];
		--_N;

		int i = 0;
		bool ifAlreadyDone = false;
		while ((i+1)*2-1 < _N && !ifAlreadyDone) {
			int icl  = (i+1)*2-1; 	
			int icr  = (i+1)*2;
			if (icr >= _N) icr = icl;
			if (data[i].d > data[icl].d || data[i].d > data[icr].d) {
				int ic_;
				data[icl].d < data[icr].d ? ic_=icl : ic_=icr;
				swap (i, ic_);
				i = ic_;
			}
			else { ifAlreadyDone = true; }
		}

		return min;
	}
	void push(DV newEl) {
		if (_N == N) return;

		data[_N] = newEl;
		++_N;
		
		bool ifAlreadyDone = false;
		int i = _N-1;
		while (i > 0 && !ifAlreadyDone) {
			int iparent;
			(i % 2 == 1) ? iparent = (i-1)/2 : iparent = (i-2)/2;

			if (data[i].d < data[iparent].d) { 
				swap(i, iparent);   
				i = iparent;   
			}
			else { ifAlreadyDone = true; } 
		}
	}

	void print(std::string title) {
		cout << endl;
		cout << title << endl;
		cout << "_N <- " << _N << endl;
		for (int i = 0; i < _N; ++i) {
			cout << "(" << data[i].d << ", " << data[i].v << ") ";
		}
		cout << endl;
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

int findTheShortestPathBetween(Graph& graph, int v1, int v2) {
	if (v1 == v2) return 0;

	DVHeap dvheap(100*100);
	int visited[100] = {0};
	
	int v_ = v1;
	int d_ = 0;
	visited[0] = 1;
	while(1) {
		for (int j = 0; j < graph.neighboursCounters.data[v_]; ++j) {
			int neighbour = graph.neighbours.getVal(v_, j);
			if (visited[neighbour]) continue;
			DVHeap::DV dv;
			dv.d = d_ + graph.connectionMatrix.getVal(v_, neighbour);
			dv.v = neighbour;
			dvheap.push(dv);
		}
		DVHeap::DV min = dvheap.popMin();
		v_ = min.v;
		visited[v_] = 1;
		d_ = min.d;

		if (v_ == v2) {	//we found path
			return d_;
		}
	}
	return -1;							//we havent found path;
}



int main() {
	stringstream input;
	input << "2\n3\n32 62\n42 68\n12 98\n7\n95 13\n97 25\n93 37\n79 27\n75 19\n49 47\n67 17\n4\n8 52\n6 80\n26 42\n2 72\n9\n51 19\n39 11\n37 29\n81 3\n59 5\n79 23\n53 7\n43 33\n77 21";
	int Nfields = 100;
	
	int T;	//how many testcases
	input >> T;
	for (int it = 0; it < T; ++it)
	{
		Graph graph(Nfields);

		int N;
		input >> N; //number of ladders
		for (int iladder = 0; iladder < N; ++iladder)
		{
			int begin_ladder, end_ladder;
			input >> begin_ladder;
			input >> end_ladder;

			graph.setEdge(begin_ladder-1, end_ladder-1, 0);
		}

		int M;
		input >> M; //number of snakes
		for (int isnake = 0; isnake < M; ++isnake)
		{
			int begin_snake, end_snake;
			input >> begin_snake;
			input >> end_snake;

			graph.setEdge(begin_snake-1, end_snake-1, 0);
		}

		for (int ifield = 0; ifield < Nfields; ++ifield)
		{
			if (graph.neighboursCounters.data[ifield] > 0 )
				//graph.connectionMatrix.getVal(ifield, graph.neighbours.getVal(ifield, 0)) == 0 )
				continue;
			
			for (int idiemove = 1; idiemove < 7; ++idiemove)
			{
				if (ifield + idiemove > Nfields) break;
				graph.setEdge(ifield, ifield + idiemove, 1 );
			}
		}
		graph.printAll();
		// cout << findTheShortestPathBetween(graph, 0, 99) << endl;
	}

    return 0;
}