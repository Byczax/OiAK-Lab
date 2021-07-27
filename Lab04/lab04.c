#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//pixel structure
typedef struct pixel
{
	unsigned char b, g, r, a; // b - blue, g - green, r - red, a - alpha
} pixel_t;

//bitmap structure
typedef struct bitmap
{
	unsigned int offset;
	unsigned int depth;
	unsigned int file_size;
	unsigned int width, height;
	pixel_t *pixels;
} bitmap_t;

// extern void encrypt(char c, pixel_t *px) asm ("encrypt");
// extern unsigned char decrypt(pixel_t *px) asm ("decrypt");

// read bits from .bmp file
bitmap_t *read_bitmap(FILE *file)
{
	bitmap_t *bmp = (bitmap_t *)malloc(sizeof(bitmap_t));

	// BM Header
	char header_field[2];
	fread(&header_field, 1, 2, file);

	if (header_field[0] != 'B' && header_field[1] != 'M')
		return NULL;

	unsigned int file_size;
	fread(&file_size, sizeof(unsigned int), 1, file);
	bmp->file_size = file_size;

	// Offset
	unsigned int offset;
	fseek(file, 10, SEEK_SET);
	fread(&offset, sizeof(unsigned int), 1, file);
	bmp->offset = offset;

	// DIB header info
	unsigned int h_size;
	fread(&h_size, sizeof(unsigned int), 1, file);

	// Width and height
	unsigned int width, height;
	unsigned short planes, depth;
	fread(&width, 4, 1, file);
	fread(&height, 4, 1, file);
	fread(&planes, 2, 1, file);
	fread(&depth, 2, 1, file);

	bmp->width = width;
	bmp->height = height;
	bmp->depth = depth;

	fseek(file, offset, SEEK_SET);
	bmp->pixels = (pixel_t *)malloc(width * height * sizeof(pixel_t));

	unsigned char r, g, b, a;
	int index = 0;
	while (ftell(file) != file_size)
	{

		fread(&b, sizeof(unsigned char), 1, file);
		fread(&g, sizeof(unsigned char), 1, file);
		fread(&r, sizeof(unsigned char), 1, file);
		fread(&a, sizeof(unsigned char), 1, file);

		bmp->pixels[index].r = r;
		bmp->pixels[index].g = g;
		bmp->pixels[index].b = b;
		bmp->pixels[index].a = a;

		index++;
	}

	return bmp;
}

// write alterned bits to new .bmp file
void write_bitmap(FILE *out, bitmap_t *bmp)
{
	int size = bmp->width * bmp->height;

	fseek(out, bmp->offset, SEEK_SET);
	fwrite(bmp->pixels, 4, size, out);
}

// create copy fo the .bmp file
void copy_file(FILE *in, FILE *out)
{
	fseek(in, 0, SEEK_END);
	long file_size = ftell(in);
	rewind(in);

	char *d = malloc(file_size * sizeof(char) + 1);
	fread(d, sizeof(char), file_size, in);

	d[file_size + 1] = '\0';

	fseek(out, 0, SEEK_SET);
	fwrite(d, sizeof(char), file_size, out);

	free(d);
}

// read text fro .txt file
char *read_text(const char *file_name)
{
	FILE *in = fopen(file_name, "rb");

	fseek(in, 0, SEEK_END);
	long file_size = ftell(in);
	rewind(in);

	char *d = malloc(file_size * sizeof(char) + 1);
	fread(d, sizeof(char), file_size, in);

	fclose(in);
	return d;
}

// encrypt char in pixels
void enc_char(char c, pixel_t *px)
{	
	/*
	extern void encrypt(char c, pixel_t *px);
	encrypt(c, px);
	*/
	char bin[9] = {'0', '0', '0', '0', '0', '0', '0', '0', '\0'};
	unsigned int cv = c;

	for (int i = 7; i > -1; i--)
	{
		if (cv % 2 != 0)
		{
			bin[i] = '1';
		}
		else
		{
			bin[i] = '0';
		}

		cv = cv / 2;
	}

	// printf("r: %u g: %u, b: %u, a: %u\n", px->r, px->g, px->b, px->a);

	px->r = px->r - (px->r % 4);
	px->g = px->g - (px->g % 4);
	px->b = px->b - (px->b % 4);
	px->a = px->a - (px->a % 4);

	if (bin[0] == '0' && bin[1] == '1')
		px->a++;
	else if (bin[0] == '1' && bin[1] == '0')
		px->a += 2;
	else if (bin[0] == '1' && bin[1] == '1')
		px->a += 3;

	if (bin[2] == '0' && bin[3] == '1')
		px->r++;
	else if (bin[2] == '1' && bin[3] == '0')
		px->r += 2;
	else if (bin[2] == '1' && bin[3] == '1')
		px->r += 3;

	if (bin[4] == '0' && bin[5] == '1')
		px->g++;
	else if (bin[4] == '1' && bin[5] == '0')
		px->g += 2;
	else if (bin[4] == '1' && bin[5] == '1')
		px->g += 3;

	if (bin[6] == '0' && bin[7] == '1')
		px->b++;
	else if (bin[6] == '1' && bin[7] == '0')
		px->b += 2;
	else if (bin[6] == '1' && bin[7] == '1')
		px->b += 3;
		
}

//decrypt char in pixels
unsigned char dec_char(pixel_t *px)
{
	/*
	asm("pushl   %ebp\n\t"
		"pushl   %edi\n\t"
		"pushl   %esi\n\t"
		"pushl   %ebx\n\t"
		"subl    $4, %esp\n\t"
		"movl    24(%esp), %eax\n\t"
		"movzbl  2(%eax), %ebx\n\t"
		"movzbl  1(%eax), %ecx\n\t"
		"movzbl  (%eax), %edx\n\t"
		"movzbl  3(%eax), %eax\n\t"
		"andl    $3, %ebx\n\t"
		"andl    $3, %ecx\n\t"
		"andl    $3, %eax\n\t"
		"andl    $3, %edx\n\t"
		"cmpb    $1, %al\n\t"
		"je      Ljump10\n\t"
		"cmpb    $2, %al\n\t"
		"je      Ljump11\n\t"
		"cmpb    $3, %al\n\t"
		"movl    $214, %esi\n\t"
		"movl    $16, %eax\n\t"
		"movl    $230, %edi\n\t"
		"cmove   %esi, %eax\n\t"
		"movl    $32, %esi\n\t"
		"movl    $246, %ebp\n\t"
		"cmove   %edi, %esi\n\t"
		"movl    $48, %edi\n\t"
		"cmovne  %edi, %ebp\n\t"
		"movl    $198, %edi\n\t"
		"movl    %ebp, (%esp)\n\t"
		"movl    $0, %ebp\n\t"
		"cmove   %edi, %ebp\n\t"
		"Ljump2:"
		"cmpb    $1, %bl\n\t"
		"je      Ljump3\n\t"
		"movl    %esi, %eax\n\t"
		"cmpb    $2, %bl\n\t"
		"je      Ljump3\n\t"
		"movl    (%esp), %eax\n\t"
		"cmpb    $3, %bl\n\t"
		"cmovne  %ebp, %eax\n\t"
		"Ljump3:"
		"cmpb    $1, %cl\n\t"
		"je      Ljump21\n\t"
		"cmpb    $2, %cl\n\t"
		"je      Ljump22\n\t"
		"leal    12(%eax), %ebx\n\t"
		"cmpb    $3, %cl\n\t"
		"cmove   %ebx, %eax\n\t"
		"Ljump5:"
		"cmpb    $1, %dl\n\t"
		"je      Ljump23\n\t"
		"cmpb    $2, %dl\n\t"
		"je      Ljump24\n\t"
		"cmpb    $3, %dl\n\t"
		"leal    3(%eax), %ecx\n\t"
		"cmove   %ecx, %eax\n\t"
		"addl    $4, %esp\n\t"
		"popl    %ebx\n\t"
		"popl    %esi\n\t"
		"popl    %edi\n\t"
		"popl    %ebp\n\t"
		"ret\n\t"
		"Ljump11:"
		"movl    $144, %eax\n\t"
		"movl    $160, %esi\n\t"
		"movl    $128, %ebp\n\t"
		"movl    $176, (%esp)\n\t"
		"jmp     Ljump2\n\t"
		"Ljump10:"
		"movl    $80, %eax\n\t"
		"movl    $96, %esi\n\t"
		"movl    $64, %ebp\n\t"
		"movl    $112, (%esp)\n\t"
		"jmp     Ljump2\n\t"
		"Ljump23:"
		"addl    $4, %esp\n\t"
		"addl    $1, %eax\n\t"
		"popl    %ebx\n\t"
		"popl    %esi\n\t"
		"popl    %edi\n\t"
		"popl    %ebp\n\t"
		"ret\n\t"
		"Ljump21:"
		"addl    $4, %eax\n\t"
		"jmp     Ljump5\n\t"
		"Ljump24:"
		"addl    $4, %esp\n\t"
		"addl    $2, %eax\n\t"
		"popl    %ebx\n\t"
		"popl    %esi\n\t"
		"popl    %edi\n\t"
		"popl    %ebp\n\t"
		"ret\n\t"
		"Ljump22:"
		"addl    $8, %eax\n\t"
		"jmp     Ljump5");
		*/
	/*
	extern unsigned char decrypt(pixel_t *px);
	decrypt(px);
	*/
	
	unsigned int value = 0;
	int r = px->r % 4;
	int g = px->g % 4;
	int b = px->b % 4;
	int a = px->a % 4;

	if (a == 1)
		value += 64; // 0100 0000
	else if (a == 2)
		value += 128; // 1000 0000
	else if (a == 3)
		value += 198; // 1100 0000

	if (r == 1)
		value += 16; // 0001 0000
	else if (r == 2)
		value += 32; // 0010 0000
	else if (r == 3)
		value += 48; // 0011 0000

	if (g == 1)
		value += 4; // 0000 0100
	else if (g == 2)
		value += 8; // 0000 1000
	else if (g == 3)
		value += 12; // 0000 1100

	if (b == 1)
		value += 1; // 0000 0001
	else if (b == 2)
		value += 2; // 0000 0010
	else if (b == 3)
		value += 3; // 0000 0011

	return (unsigned char)value;
	
}

// help menu for program
void print_help()
{
	const char *help =
		"\n./lab04 <mode> <input_file> <output_file> <text file>\n"
		"Mode : Encrypting or decrypting\n\t"
		"-e - encrypting\n\t"
		"-d - decrypting\n"
		"Example : Encrypting (-e)\n\t"
		"./lab04 -e input.bmp output.bmp text.txt\n"
		"Example : Decrypting (-d)\n\t"
		"./lab04 -d input.bmp output.txt\n";

	printf("%s\n", help);
}

// main program
int main(int argc, const char *argv[argc + 1])
{
	if (argc < 3)
	{
		print_help();
		return 1;
	}

	const char *mode = argv[1];
	const char *in_name = argv[2];
	const char *out_name = argv[3];

	FILE *in_file, *out_file;
	in_file = fopen(in_name, "rb");
	out_file = fopen(out_name, "wb");

	if (in_file == NULL)
	{
		printf("Error : %s doesn't exist", in_name);
		fclose(out_file);
		return 0;
	}
	else if (out_file == NULL)
	{
		printf("Error : %s doesn't exist", out_name);
		fclose(out_file);
		return 0;
	}

	bitmap_t *bmp = read_bitmap(in_file);

	if (mode[0] == '-' && mode[1] == 'e')
	{
		printf("Encrypting...\n");
		copy_file(in_file, out_file);
		const char *text_path = argv[4];
		char *data = read_text(text_path);

		if (strlen(data) > (bmp->width * bmp->height))
		{
			printf("Text too large for file\n"
				   "Should be less than %d characters\n",
				   bmp->width * bmp->height);
			fclose(in_file);
			fclose(out_file);
			free(bmp->pixels);
			free(bmp);
			return 0;
		}
		size_t size = strlen(data);

		for (size_t i = 0; i < size; i++)
		{
			char c = data[i];
			pixel_t *px = &bmp->pixels[i];
			enc_char(c, px);
		}

		enc_char('\0', &bmp->pixels[size]);

		write_bitmap(out_file, bmp);

		free(data);

		printf("Done\nOuput : %s\n", out_name);
	}
	else if (mode[0] == '-' && mode[1] == 'd')
	{
		printf("Decrypting...\n");
		int size = bmp->width * bmp->height;
		for (int i = 0; i < size; i++)
		{
			struct pixel *px = &(bmp->pixels[i]);
			unsigned char c = dec_char(px);
			if (c == '\0')
				break;
			fwrite(&c, sizeof(unsigned char), 1, out_file);
		}
		printf("Done\nOuput : %s\n", out_name);
	}
	else
	{
		print_help();
	}
	fclose(in_file);
	fclose(out_file);
	free(bmp->pixels);
	free(bmp);
	return 0;
}