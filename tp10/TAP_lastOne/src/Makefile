ASPECTJPATH = /home/renault/fich/Java/aspectj-1.7
CLASSPATH = $(ASPECTJPATH)/lib/aspectjrt.jar
BINPATH = $(ASPECTJPATH)/bin

all:
	CLASSPATH=$(CLASSPATH) $(BINPATH)/ajc -argfile all.lst
	java -cp .:$(CLASSPATH) Main

clean:
	rm -f *~ *.class
