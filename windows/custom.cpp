#include <windows.h>
#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <fstream>

std::string replace_all(std::string str, std::string substr1, std::string substr2)
{
    for (size_t index = str.find(substr1, 0); index != std::string::npos && substr1.length(); index = str.find(substr1, index + substr2.length() ) )
        str.replace(index, substr1.length(), substr2);
    return str;
}

int main(int argc, char **argv)
{   
    std::string option(argv[1]);
    if (option == "/i") {
        std::string filename_in = argv[2];
        std::string filename_out = argv[3];
        std::string directory = argv[4];
        std::string content;

        std::ifstream file(filename_in);
        std::string contents((std::istreambuf_iterator<char>(file)), (std::istreambuf_iterator<char>()));
        file.close();

        std::string needle = "%GenesisDir%";
        size_t pos2 = contents.find(needle);
        contents.replace(pos2, needle.length(), replace_all(directory, "\\", "\\\\"));

        std::ofstream file2(filename_out);
        file2 << contents << std::flush;
    } else if (option == "/u") {
        unlink(argv[2]);
    }

    return EXIT_SUCCESS;
}
