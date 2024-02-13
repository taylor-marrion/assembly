#include <stdio.h>
#include <string.h>


char str1[] = "text";
char str2[] = "test";


int hamdist(char *a, char *b) {

	int c;
	int unmatched;

	unmatched = 0;

	for(c = 0; a[c] != '\0'; c++) {

		if(a[c] != b[c])
			unmatched++;
	
	}

	return unmatched;

}


int main() {

	printf("Hamming distance = %d\n", hamdist(str1, str2));

}
