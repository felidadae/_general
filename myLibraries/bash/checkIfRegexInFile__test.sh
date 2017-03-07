. checkIfRegexInFile.sh

touch test
echo "mama  tata zupa sos" >> test
echo "zupka  dupka kkkk" >> test

echo "************"
echo "Before"
echo "************"
cat test
echo "************"

echo ""
echo ""
echo ""

checkIfRegexInFile "zupka\s+d" test
echo 'checkIfRegexInFile "zupka\s+d" test'
echo "Function result code is: $?"
rm test