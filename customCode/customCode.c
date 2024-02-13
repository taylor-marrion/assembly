
#include <asmio.h>

int main() {

	register int a, b, c, x;

	a = read_int();
	b = read_int();
	c = read_int();

	x = (a+95) * ((b*16) / c) - a + 20;

	print_int(x);
	print_nl();
}
