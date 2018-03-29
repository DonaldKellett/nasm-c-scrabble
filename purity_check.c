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
