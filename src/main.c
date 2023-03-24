#include <windows.h>

int main()
{
    for(;;) {
        Sleep(1<<31);
    }
    return 0;
}
