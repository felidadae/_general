/*
	Bugs found:
	- using in loop S (constant) instead of activeVertex
	- infinite loop because putting to queue_ all neighbours
	- pop element from queue and not checking if after is empty :/
*/


#include <cmath>
#include <cstdio>
#include <vector>
#include <list>
#include <iostream>
#include <algorithm>
#include <queue>
#include <climits>
using namespace std;



struct Graph {
	struct Edge {
		int beginVertex_;
		int endVertex_;
		int weight_;
		int distanceFromS_;

		friend inline bool operator< (const Edge& lhs, const Edge& rhs){
			return lhs.distanceFromS_ > rhs.distanceFromS_;
		} 
	};
	std::vector<std::list<Edge>> edges_;

	Graph(int V, std::vector<Edge>& edgesLinear): edges_(V) {
		for (auto ie = edgesLinear.begin(); ie != edgesLinear.end(); ++ie)
		{
			ie->beginVertex_--;
			ie->endVertex_--;

			//we need to check if not already some edge exists;
			bool doubleEdge = false;
			for (auto ie__ = edges_[ie->beginVertex_].begin(); 
				ie__ != edges_[ie->beginVertex_].end(); 
				++ie__) 
			{
				if (ie__->endVertex_ == ie->endVertex_) {
					ie__->weight_ < ie->weight_ ? : 
						ie__->weight_ = ie->weight_;
					
					auto ie___ = edges_[ie__->endVertex_].begin();
					while (ie___->endVertex_ != ie__->beginVertex_) 
						++ie___;

					ie___->weight_ < ie->weight_ ? : 
						ie___->weight_ = ie->weight_;  
					
					doubleEdge = true;
					break;
				}
			}


			edges_[ie->beginVertex_].push_back(*ie);		
			Edge revertedEdge;
			revertedEdge.beginVertex_ = (*ie).endVertex_;
			revertedEdge.endVertex_ = (*ie).beginVertex_;
			revertedEdge.weight_ = (*ie).weight_;
			edges_[ie->endVertex_].push_back(revertedEdge);
		}
	}

	void print() {
		int iBeginVertex=0;
		for (auto edgesPerVertex = edges_.begin();
			edgesPerVertex != edges_.end();
			++edgesPerVertex)
		{
			cout << "Vertex["<<iBeginVertex<<"] <- [";
			for (auto iv = (*edgesPerVertex).begin(); 
				iv != (*edgesPerVertex).end(); 
				++iv)
			{
				cout << 
					"(endVertex=" << iv->endVertex_ << 
					", weight=" << iv->weight_ << ")" << ", ";
			}
			cout << "]" << endl;

			++iBeginVertex;
		}
	}
};



struct DixtraSpace {
	std::priority_queue<Graph::Edge, std::vector<Graph::Edge>> 
		queue_;
	std::vector<int> distances_;
	std::vector<bool> state_;

	Graph& graph_;

	DixtraSpace(int V, Graph& g):
		graph_(g), distances_(V), state_(V)
	{
		for (int i = 0; i < V; ++i)
		{
			distances_[i]=INT_MAX;
			state_[i]=false;
		}
	}

	void solve(int S) {
		int activeEdge = S;

		distances_[S] = 0;
		int iloop = 0;
		while(activeEdge != -1) {
			for (auto it_edge = graph_.edges_[activeEdge].begin();
				it_edge != graph_.edges_[activeEdge].end();
				++it_edge)
			{
				if (distances_[activeEdge] + it_edge->weight_ < 
					distances_[it_edge->endVertex_]) 
				{
					distances_[it_edge->endVertex_] = 
						distances_[activeEdge] + it_edge->weight_;

					it_edge->distanceFromS_ = distances_[it_edge->endVertex_];
					queue_.push(*it_edge);
				}
			}

			state_[activeEdge] = true;
			if(queue_.empty())
				activeEdge = -1;
			else {
				while (  state_[queue_.top().endVertex_]  ) { 
					if (queue_.empty()) {
						activeEdge = -1; 
						break;
					}
					else
						queue_.pop(); 
				}

				if (!queue_.empty()) {
					const Graph::Edge& minEdge = queue_.top();
					activeEdge = minEdge.endVertex_;
					queue_.pop();
				}
			}

			++iloop;
		}
	}
};



int main() {
	using namespace std;

	int T;
	cin >> T;

	for(unsigned it = 0; it < T; ++it) {
		int N, M;
		cin >> N >> M;

		std::vector<Graph::Edge> edgesLinear;
		for(unsigned iedge = 0; iedge < M; ++iedge) {
			Graph::Edge edge;
			cin >> edge.beginVertex_;
			cin >> edge.endVertex_;
			cin >> edge.weight_;
			edgesLinear.push_back(edge);
		}
		int S;
		cin >> S;

		Graph graph(N, edgesLinear);
		// graph.print();
		
		DixtraSpace dixtraSpace(N, graph);
		dixtraSpace.solve(S-1);

		for (auto i = dixtraSpace.distances_.begin(); 
			i != dixtraSpace.distances_.end(); 
			++i)
		{
			if (*i != 0)
				if (*i == INT_MAX) {
					cout << -1 << " ";	
				}
				else {
					cout << *i << " ";	
				}
		}

		cout << endl;

	}


	return 0;
}
