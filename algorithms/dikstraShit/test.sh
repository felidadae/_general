rm main
g++ -g -std=c++14 main.cpp -o main

cat testCase1.txt | ./main > result
echo -e "24 3 15" > expected_result
diff -b result expected_result
[[ $? != 0 ]] && echo ERROR

cat testCase2.txt | ./main > result
diff -b result expectedOutput2.txt
[[ $? != 0 ]] && echo ERROR