all:
	javac MamaMia.java
clean:
	rm *.class
zip:
	zip MamaMia.zip -xi *.java
tar:
	tar -czvf MamaMia.tar.gz *.java
tests: test1 test2 test3 test4 test5
test1:
		time ./tester.sh "java MamaMia 1 2 2 3 10 20"
test2:
		time ./tester.sh "java MamaMia 3 2 2 3 4 5" 
test3:
		time ./tester.sh "java MamaMia 5 3 2 3 2 3"
test4:	
		time ./tester.sh "java MamaMia 2 42 42 1764 72364 74087"
test5:
		time ./tester.sh "java MamaMia 2 4 1 3 9000 9500"

