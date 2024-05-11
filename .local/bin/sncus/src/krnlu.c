#include <stdio.h>
#include <sys/utsname.h>

int main() {
    struct utsname name;
    uname(&name);
    printf("KRL %s\n", name.release);
    return 0;
}
