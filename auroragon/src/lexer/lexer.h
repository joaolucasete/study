#ifndef LEXER_H
#define LEXER_H

#include <stdint.h>

enum token_types
{
    TOK_NUMBER = 1,
    TOK_PLUS,
    TOK_MINUS,
    TOK_TIMES,
    TOK_DIVIDE,
    TOK_LPAREN,
    TOK_RPAREN,
    TOK_END
};

// Token structure
typedef struct
{
    uint8_t type;
    double value;
} Token;

Token *lexer(const char *input);

#endif