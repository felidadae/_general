RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

g++ --std=c++11 main.cpp -o main 

result=$(echo -e "7\n3\n10\n100\n300\n200\n1000\n20\n30\n" | ./main )
if [[ $result != "40" ]]; then
	printf "${RED}[Error]${NC} Wrong answer bro!\n"
else 
	printf "${GREEN}[Success]${NC} Good!\n"
fi

result=$(echo -e "7\n3\n100\n10\n300\n200\n1000\n20\n30\n" | ./main )
if [[ $result != "40" ]]; then
	printf "${RED}[Error]${NC} Wrong answer bro!\n"
else 
	printf "${GREEN}[Success]${NC} Good!\n"
fi

result=$(echo -e "50\n8\n6327\n571\n6599\n479\n7897\n9322\n4518\n571\n6677\n7432\n815\n6920\n4329\n4104\n7775\n5708\n7991\n5802\n8619\n6053\n7539\n7454\n9000\n3267\n6343\n7165\n4095\n439\n5621\n4095\n153\n1948\n1018\n6752\n8779\n5267\n2426\n9649\n2190\n9103\n7081\n3006\n2376\n7762\n3462\n151\n3471\n1453\n2305\n8442\n" | ./main )
if [[ $result != "9293" ]]; then
	printf "${RED}[Error]${NC} Wrong answer bro! ($result)\n"
else 
	printf "${GREEN}[Success]${NC} Good!\n"
fi

result=$(cat testcaselong | ./main )
if [[ $result != "40" ]]; then
	printf "${RED}[Error]${NC} Wrong answer bro! ($result)\n"
else 
	printf "${GREEN}[Success]${NC} Good!\n"
fi
