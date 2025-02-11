#include <stdio.h>
#include <sys/utsname.h>

int main(void) {
    struct utsname name;
    uname(&name);
    fprintf(stdout, "KRL %s\n", name.release);
    return 0;
}
