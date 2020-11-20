// This code was written by Prof. Vasilis Samoladas
#ifndef TEACLIB_H
#define TEACLIB_H

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define writeString(x) printf("%s",(x))
#define writeInt(x) printf("%d",(x))
#define writeReal(x) printf("%g",(x))

char* strdup(const char*);

#define BUFSIZE 1024
char* readString() {
  char buffer[BUFSIZE];
  buffer[0]='\0';
  fgets(buffer, BUFSIZE, stdin);
  /* strip newline from the end */
  int blen = strlen(buffer);
  if(blen>0 && buffer[blen-1]=='\n')
    buffer[blen-1] = '\0';
  return strdup(buffer);
}
#undef BUFSIZE

int readInt() { return atoi(readString()); }
double readReal() { return atof(readString()); }

#endif 
