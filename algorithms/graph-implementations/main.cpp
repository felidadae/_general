#include <iostream>
#include <vector>
#include <list>
using namespace std;

struct IGraph {
	int getVertexDegree();
	bool addEdge(int v1, int v2);
	bool checkIfEdgeExists(v1, v2);
	int getWeightOfEdge(v1,v2);
	:w

};


struct Graph {
	/*
	 * Space complexity: 2*|E|
	 */
	std::vector< std::list<int> > vertexsNeighbours_;

	int getVertexDegree(int v) { return vertexsNeighbours_[v].size();  }

};

int main(int argc, char const *argv[])
{
	return 0;
}
