all: clean beep
beep:
	gcc -Wall -lm -lopenal beep.c -o beep
clean: 
	rm -f beep
