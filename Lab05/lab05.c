#include <stdlib.h>
#include <stdio.h>
#include <string.h>


int filter(FILE *in_file, FILE *out_file, char mode)
{
    int width, height, row_padding;

    char *image_hedder[18];
    char *image_footer[28];

    // read image informations
    fread(image_hedder, 18, 1, in_file);
    fread(&width, 4, 1, in_file);
    fread(&height, 4, 1, in_file);
    fread(image_footer, 28, 1, in_file);

    row_padding = (width * 3 + 3) & (~3);

    unsigned char *image_data = (unsigned char *)malloc(row_padding * height);
    unsigned char *after_data = (unsigned char *)malloc(row_padding * height);

    fread(image_data, 1, row_padding * height, in_file);

    // select filter type
    if (mode == '1')
    {
        extern void assembly_filter(unsigned char *img_ptr, int height, int width, int row_p, unsigned char *after_ptr);
        assembly_filter(image_data, height, width, row_padding, after_data);
    }
    else if (mode == '2')
    {
        extern void assembly_filter2(unsigned char *img_ptr, int height, int width, int row_p, unsigned char *after_ptr);
        assembly_filter2(image_data, height, width, row_padding, after_data);
    }
    else if (mode == '3')
    {
        extern void assembly_filter3(unsigned char *img_ptr, int height, int width, int row_p, unsigned char *after_ptr);
        assembly_filter3(image_data, height, width, row_padding, after_data);
    }
    else
    {
        printf("ERROR, wrong option");
        return 0;
    }

    // save edited image, add old headers and footers
    fwrite(image_hedder, 1, 18, out_file);
    fwrite(&width, 4, 1, out_file);
    fwrite(&height, 4, 1, out_file);
    fwrite(image_footer, 1, 28, out_file);
    fwrite(after_data, 1, row_padding * height, out_file);

    int end_position = 54 + height * row_padding;
    fseek(in_file, end_position, SEEK_SET);
    fseek(out_file, end_position, SEEK_SET);
    unsigned char c;

    while (!feof(in_file))
    {
        fread(&c, 1, 1, in_file);
        fputc(c, out_file);
    }
    return 1;
}

// help menu for program
void print_help()
{
    const char *help =
        "\n./lab05 <mode> <input_file> <output_file>\n"
        "Mode : \n\t"
        "-1 - filter nr. 1\n\t"
        "-2 - filter nr. 2\n\t"
        "-3 - filter nr. 3\n\t"
        "Example :\n\t"
        "./lab05 -1 input.bmp output.bmp\n";

    printf("%s\n", help);
}

// main program
int main(int argc, const char *argv[argc + 1])
{

    // if there is insufficient arguments
    if (argc < 3)
    {
        print_help();
        return 1;
    }

    // save user input
    const char *mode = argv[1];
    const char *in_name = argv[2];
    const char *out_name = argv[3];


    // open given files
    FILE *in_file, *out_file;
    in_file = fopen(in_name, "rb");
    


    // check if file exist
    if (in_file == NULL)
    {
        printf("Error : %s doesn't exist", in_name);
        fclose(in_file);
        return 0;
    }
    // create output file
    out_file = fopen(out_name, "wb");

    // check if user input is correct
    if (mode[0] == '-')
    {
        int result = filter(in_file, out_file, mode[1]);
        if (result == 1)
        {
            printf("Done\nOuput : %s\n", out_name);
        }
        else
        {
            printf("ERROR, something gone wrong\n");
        }
    }
    else
    {
        // if user input is incorrect, print help 
        print_help();
    }
    // afster all save and close files
    fclose(in_file);
    fclose(out_file);

    return 0;
}