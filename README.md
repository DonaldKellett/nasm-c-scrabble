# nasm-c-scrabble

A function written for C programs that calculates the English Scrabble score of a single word, written in NASM v2.13.03 for Mac OSX.

## File Synopsis

- `scrabble.asm` - A NASM v2.13.03 file (for Mac OS X) containing a function `scrabble` for use in C programs which accepts a string containing a single word (i.e. only English letters) and computes its English Scrabble word score
- `example.c` - An example C program utilizing the `scrabble` function from `scrabble.asm` demonstrated in the section "Assemble, Compile and Execute", included for your reference
- `purity_check.c` - Another example C program used to demonstrate the purity of the `scrabble` function, included for your reference
- `README.md` - This README

## Assemble, Compile and Execute

*N.B.* `scrabble.asm` *only works on Mac OS X with NASM 2 or later installed.  If you're using a Mac, you can check whether you have an update version of NASM (at least v2) by executing* `nasm -v` *in the command line.*

To use `scrabble.asm`, first create a new C file (or use an existing one - it doesn't matter) - let's call it `example.c` in this example.  Above your `main` function (or any other function that will invoke `scrabble`), add the following function declaration: `int scrabble(const char *);`, then invoke the `scrabble` function with a string containing a single word (i.e. only English letters) in your `main` function body (or any other function that uses it) as required.  For example, the C program shown below asks the user to input a single word and uses the `scrabble` function to calculate its word score, then outputs the score to the user:

```c
#include <stdio.h>

int scrabble(const char *);

int main() {
  char word[101];
  printf("Enter a single word to calculate its Scrabble score: ");
  scanf("%s", word);
  printf("The Scrabble score of your word is: %d\n", scrabble(word));
  return 0;
}
```

Then, once you're ready, you can assemble, compile and run your program in one go by executing `nasm -fmacho64 scrabble.asm && gcc example.c scrabble.o && ./a.out` (or replace `example.c` in the command shown with the filename of your selected C program) in the Terminal.

Here is some example output from my command line:

```
$ nasm -fmacho64 scrabble.asm && gcc example.c scrabble.o && ./a.out
ld: warning: PIE disabled. Absolute addressing (perhaps -mdynamic-no-pic) not allowed in code signed PIE, but used in printErr from scrabble.o. To fix this warning, don't compile with -mdynamic-no-pic or link with -Wl,-no_pie
Enter a single word to calculate its Scrabble score: netwide
The Scrabble score of your word is: 11
```

*NOTE: When assembling* `scrabble.asm` *or compiling your C program with the generated object file, you may receive a warning.  However, don't worry - it's just a warning, not an error* :wink:

## Input Range and Error Handling

The `scrabble` function implemented in `scrabble.asm` is only meant to receive valid non-empty strings containing a single word (i.e. contains only English letters in either upper or lower case).  In the case where the input string is empty or contains anything other than English letters, the function prints out a catch-all error message and exits the program with exit code `1` - however, there are no checks against invalid pointers, including the `NULL` pointer.  In that case, the program is likely to crash.  For example:

```
$ nasm -fmacho64 scrabble.asm && gcc example.c scrabble.o && ./a.out
ld: warning: PIE disabled. Absolute addressing (perhaps -mdynamic-no-pic) not allowed in code signed PIE, but used in printErr from scrabble.o. To fix this warning, don't compile with -mdynamic-no-pic or link with -Wl,-no_pie
Enter a single word to calculate its Scrabble score: Hello!
Error: input string to function `scrabble` cannot be empty and may only contain English letters
```

## Purity of Function

The `scrabble` function as implemented here is guaranteed to leave the input string intact.  Furthermore, it *should* not cause any side effects in your program (though that is untested).  This can be verified by compiling and executing `purity_check.c` (provided for your reference in this repo) with the resulting `scrabble.o` file, testing the program with different user inputs:

```c
#include <stdio.h>

int scrabble(const char *);

int main() {
  char word[101];
  printf("Enter a single word to calculate its Scrabble score: ");
  scanf("%s", word);
  printf("Your input word was: %s\n", word);
  printf("Its English Scrabble score is: %d\n", scrabble(word));
  printf("Your input word is now: %s\n", word);
  return 0;
}
```

```
$ nasm -fmacho64 scrabble.asm && gcc purity_check.c scrabble.o && ./a.out
ld: warning: PIE disabled. Absolute addressing (perhaps -mdynamic-no-pic) not allowed in code signed PIE, but used in printErr from scrabble.o. To fix this warning, don't compile with -mdynamic-no-pic or link with -Wl,-no_pie
Enter a single word to calculate its Scrabble score: intermission
Your input word was: intermission
Its English Scrabble score is: 14
Your input word is now: intermission
```
