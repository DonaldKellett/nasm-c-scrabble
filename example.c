#include <stdio.h>

int scrabble(const char *);

int main() {
  char word[101];
  printf("Enter a single word to calculate its Scrabble score: ");
  scanf("%s", word);
  printf("The Scrabble score of your word is: %d\n", scrabble(word));
  return 0;
}
