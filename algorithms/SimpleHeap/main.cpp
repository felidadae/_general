class Heap {
	int sizeMax_;
	int size_;
	int* data_;

	Heap(sizeMax) {
		sizeMax_=sizeMax;
		size_=0;
		data_=new int[sizeMax];
	}

	int getRoot() {
		return data_[0];
	}

	void popRoot() {
		if (size_==0) throw;
		int result = data_[0];

		data_[0]=data_[size_-1];
		size_--;

		int it1=0, it2=1;
		while (it2 < size_) {
			it2=it1*2+1;
			if ( it2+1<size_ && data_[it2+1] > data_[it2] ) it2++;
			if ( data_[it1] > data_[it2] ) break;
			swap(data_[it1], data_[it2]);
			it1=it2;
		}
		return result;
	}

	void push(int element) {
		if (size_ == sizeMax_) return;
		data_[size_] = element;

		int pos=size_;
		while (pos != 0) {
			int hpos=pos/2;
			if (data[hpos] < data[pos]) {
				swap(data_[hpos], data_[pos]);
			} else { break; }
			pos = hpos;
		}
	}
};
