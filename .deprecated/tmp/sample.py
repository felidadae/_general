import csv

def sample_filter_fun(irow, icell, cell, args):
    print("{}:{} {}".format(irow, icell, cell))
    return None
    
def map_tsv(file_name, filter_fun, args=None):
    result = []
    with open('sample.tsv', 'r') as ftsv:
        for irow, row in enumerate(csv.reader(ftsv, delimiter='\t')):
            for icell, cell in enumerate(row):
                ret = sample_filter_fun(irow, icell, cell, args)
                if ret != None:
                    result.append(ret)
    return result

def get_cell_from_tsv(tsv_path, irow_, icell_):
    """
        icell, irow as 0 indexed
        returns None if no cell found
    """
    with open(tsv_path, 'r') as ftsv:
        for irow, row in enumerate(csv.reader(ftsv, delimiter='\t')):
            for icell, cell in enumerate(row):
                if icell == icell_ and irow == irow_:
                    return cell
    return None

def search_all_lines_containing_pattern(file_path, pattern):
    result_lines=[]
    with open(file_path, 'r') as fout:
        for line in fout:
            if re.match(pattern, line):
                result_lines.append(line)
    return result_lines

def read_to_memory(tsv_path):
    tsv = []
    with open(tsv_path, 'r') as ftsv:
        for irow, row in enumerate(csv.reader(ftsv, delimiter='\t')):
            row = []
            for icell, cell in enumerate(row):
                row.append(cell)
        tsv.append(row)
    return tsv

tsv_sample_path = 'sample.tsv'
print(map_tsv(tsv_sample_path, sample_filter_fun) == [])
print(get_cell_from_tsv(tsv_sample_path, 1,1) == 'martitka')
print(read_to_memory(tsv_sample_path))
print(read_to_memory(tsv_sample_path) == [["zupa", "mama", "tata"], ["marteczka", "martitka", "zupitka"]])
