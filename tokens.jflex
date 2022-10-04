/*-***
 *
 * This file defines a stand-alone lexical analyzer for a subset of the Pascal
 * programming language.  This is the same lexer that will later be integrated
 * with a CUP-based parser.  Here the lexer is driven by the simple Java test
 * program in ./PascalLexerTest.java, q.v.  See 330 Lecture Notes 2 and the
 * Assignment 2 writeup for further discussion.
 *
 */


import java_cup.runtime.*;


%%
/*-*
 * LEXICAL FUNCTIONS:
 */

%cup
%line
%column
%unicode
%class Lexer

%{

/**
 * Return a new Symbol with the given token id, and with the current line and
 * column numbers.
 */
Symbol newSym(int tokenId) {
    return new Symbol(tokenId, yyline, yycolumn);
}

/**
 * Return a new Symbol with the given token id, the current line and column
 * numbers, and the given token value.  The value is used for tokens such as
 * identifiers and numbers.
 */
Symbol newSym(int tokenId, Object value) {
    return new Symbol(tokenId, yyline, yycolumn, value);
}

%}


/*-*
 * PATTERN DEFINITIONS:
 */
backslash = \\
newline = \n
tab = \t
quote = \"
letter = [a-zA-Z]
number = [0-9]
char = [[[^\n]&&[^\t]]&&[[^\\][^\"]]]|\\\\|\\\"
charliteral = \'{char}\'
string = \"{char}*\"
floatingpointliteral = {number}+\.{number}+
stringlit = \"{string}\"
whitespace = [ \n\t\r]
id = {letter}[{letter}{number}]*
integerliteral = {number}+
singlecomment = {backslash}{backslash}.*\n
multicomment = \\\*~\*\\


/**
 * Implement patterns as regex here
 */



%%
/**
 * LEXICAL RULES:
 */
class               {return newSym(sym.CLASS, "start");}
final               {return newSym(sym.FINAL, "final");}
int                 {return newSym(sym.INT, "int");}
char                {return newSym(sym.CHAR, "char");}
bool                {return newSym(sym.BOOL, "bool");}
float               {return newSym(sym.FLOAT, "float");}
if                  {return newSym(sym.IF, "if");}
else                {return newSym(sym.ELSE, "else");}
while               {return newSym(sym.WHILE, "while");}
read                {return newSym(sym.READ, "read");}
print               {return newSym(sym.PRINT, "print");}
println             {return newSym(sym.PRINTLINE, "println");}
return              {return newSym(sym.RETURN, "return");}
true                {return newSym(sym.TRUE, "true");}
false               {return newSym(sym.FALSE, "false");}
void                {return newSym(sym.VOID, "void");}
"="                 {return newSym(sym.ASSIGN, "=");}
"("                 {return newSym(sym.OPENPAR, "(");}
")"                 {return newSym(sym.CLOSEPAR, ")");}
"["                 {return newSym(sym.OPENBRA, "[");}
"]"                 {return newSym(sym.CLOSEBRA, "]");}
"{"                 {return newSym(sym.OPENCURLY, "{");}
"}"                 {return newSym(sym.CLOSECURLY, "}");}
";"                 {return newSym(sym.SEMICOLON, ";");}
"++"                {return newSym(sym.INCREASE, "++");}
"--"                {return newSym(sym.DECREASE, "--");}
"+"                 {return newSym(sym.ADD, "+");}
"-"                 {return newSym(sym.SUB, "-");}
"*"                 {return newSym(sym.MULT, "*");}
"/"                 {return newSym(sym.DIV, "/");}
"<"                 {return newSym(sym.LESSTHAN, "<");}
">"                 {return newSym(sym.GREATERTHAN, ">");}
"<="                {return newSym(sym.LESSTHANOREQUAL, "<=");}
">="                {return newSym(sym.GREATERTHANOREQUAL, ">=");}
"=="                {return newSym(sym.AREEQUAL, "==");}
"<>"                {return newSym(sym.ARENOTEQUAL, "<>");}
"||"                {return newSym(sym.OR, "||");}
"&&"                {return newSym(sym.AND, "&&");}
","                 {return newSym(sym.COMMA, ",");}
"?"                 {return newSym(sym.QUESTION, "?");}
":"                 {return newSym(sym.COLON, ":");}
"~"                 {return newSym(sym.ABOUT, "~");}
{string}            {return newSym(sym.STRING, yytext());}
{integerliteral}    {return newSym(sym.INTLIT, yytext());}
{charliteral}       {return newSym(sym.CHARLIT, yytext());}
{stringlit}         {return newSym(sym.STRLIT, yytext());}
{floatingpointliteral}  {return newSym(sym.FLOATLIT, yytext());}
{id}                {return newSym(sym.ID, yytext());}
/**
 * Implement terminals here, ORDER MATTERS!
 */
{singlecomment}       { /* Ignore comment. */ }
{multicomment}        { /* Ignore multi Comment. */ }
{whitespace}    { /* Ignore whitespace. */ }
.               { System.out.println("Illegal char, '" + yytext() +
                    "' line: " + yyline + ", column: " + yychar); } 