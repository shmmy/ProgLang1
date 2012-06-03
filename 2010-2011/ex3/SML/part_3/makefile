all:
	mlton mama_mia.sml
tests: test1 test2 test3 test4 test5
test1:
	time ./tester.sh "./mama_mia 1 2 2 3 10 20"
test2:
	time ./tester.sh "./mama_mia 3 2 2 3 4 5"
test3:
	time ./tester.sh "./mama_mia 5 3 2 3 2 3"
test4:
	time ./tester.sh "./mama_mia 2 42 42 1764 72364 74087"
test5:
	time ./tester.sh "./mama_mia 2 4 1 3 9000 9500"
bigTests:
	time -p ./mama_mia 1 2 2 3 10 20
	time -p ./mama_mia 3 2 2 3 4 5
	time -p ./mama_mia 5 3 2 3 2 3
	time -p ./mama_mia 2 42 42 1764 72364 74087
	time -p ./mama_mia 2 4 1 3 9000 9500
times:
	time -p ./mama_mia 1 2 2 3 10 20 > /dev/null
	time -p ./mama_mia 3 2 2 3 4 5 > /dev/null
	time -p ./mama_mia 5 3 2 3 2 3 > /dev/null
	time -p ./mama_mia 2 42 42 1764 72364 74087 > /dev/null
	time -p ./mama_mia 2 4 1 3 9000 9500 > /dev/null
