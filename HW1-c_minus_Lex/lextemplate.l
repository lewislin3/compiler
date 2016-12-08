%{
#include <string.h>
#define LIST                { strncat(buf, yytext, sizeof(buf) - strlen(buf) - 1); }
#define token(t)            { LIST; if (Opt_Token &&trigger) printf("<%s>\n", #t); }
#define tokenString(t, s)   { LIST; if (Opt_Token&&trigger) printf("<%s:%s>\n", t, s); }
#define MAX_LINE_LENGTH 257
#define MAX_ID_LENGTH 257



int Opt_Source = 1;
int Opt_Token = 1;
int Opt_Statistic = 1;
int linenum = 1;
int trigger = 1;
int i=0;
char buf[MAX_LINE_LENGTH];
typedef struct ic{
    char node[257];
    int cnt;
    struct ic* next;
} id_cnt;
char stg[MAX_LINE_LENGTH];
id_cnt* now=NULL;
id_cnt* last=NULL;
id_cnt* head=NULL;
int exist=0;
%}
%X aa
%%


"(" {
    if(trigger==1)
    tokenString("delim", "(");
    if(trigger==0) LIST;
}

")" {
    if(trigger==1)
    tokenString("delim", ")");
    if(trigger==0) LIST;
}

"," {
    if(trigger==1)
    tokenString("delim", ",");
    if(trigger==0) LIST;
}

";" {
    if(trigger==1)
    tokenString("delim", ";");
    if(trigger==0) LIST;
}

"[" {
    if(trigger==1)
    tokenString("delim", "]");
    if(trigger==0) LIST;
}

"]" {
    if(trigger==1)
    tokenString("delim", "]");
    if(trigger==0) LIST;
}

"{" {
    if(trigger==1)
    tokenString("delim", "{");
    if(trigger==0) LIST;
}

"}" {
    if(trigger==1)
    tokenString("delim", "}");
    if(trigger==0) LIST;
}

"+" {
    if(trigger==1)
    token("+");
    if(trigger==0) LIST;
}

"-" {
    if(trigger==1)
    token("-");
    if(trigger==0) LIST;
}

"*" {
    if(trigger==1)
    token("*");
    if(trigger==0) LIST;
}

"/" {
    if(trigger==1)
    token("/");
    if(trigger==0) LIST;
}

"%" {
    if(trigger==1)
    token("%");
    if(trigger==0) LIST;
}

"=" {
    if(trigger==1)
    token("=");
    if(trigger==0) LIST;
}

"<" {
    if(trigger==1)
    token("<");
    if(trigger==0) LIST;
}

"<=" {
    if(trigger==1)
    token("<=");
    if(trigger==0) LIST;
}

"!=" {
    if(trigger==1)
    token("!=");
    if(trigger==0) LIST;
}

">=" {
    if(trigger==1)
    token(">=");
    if(trigger==0) LIST;
}


">" {
    if(trigger==1)
    token(">");
    if(trigger==0) LIST;
}

"==" {
    if(trigger==1)
    token("==");
    if(trigger==0) LIST;
}

"&&" {
    if(trigger==1)
    token("&&");
    if(trigger==0) LIST;
}

"||" {
    if(trigger==1)
    token("||");
    if(trigger==0) LIST;
}

"!" {
    if(trigger==1)
    token("!");
    if(trigger==0) LIST;
}

"while" {
    if(trigger==1)
    tokenString("KW", "while");
    if(trigger==0) LIST;
}

"do" {
    if(trigger==1)
    tokenString("KW", "do");
    if(trigger==0) LIST;
}

"if" {
    if(trigger==1)
    tokenString("KW", "if");
    if(trigger==0) LIST;
}

"else" {
    if(trigger==1)
    tokenString("KW", "else");
    if(trigger==0) LIST;
}

"true" {
    if(trigger==1)
    tokenString("KW", "true");
    if(trigger==0) LIST;
}

"false" {
    if(trigger==1)
    tokenString("KW", "false");
    if(trigger==0) LIST;
}

"for" {
    if(trigger==1)
    tokenString("KW", "for");
    if(trigger==0) LIST;
}

"int" {
    if(trigger==1)
    tokenString("KW", "int");
    if(trigger==0) LIST;
}

"print" {
    if(trigger==1)
    tokenString("KW", "print");
    if(trigger==0) LIST;
}

"const" {
    if(trigger==1)
    tokenString("KW", "const");
    if(trigger==0) LIST;
}

"read" {
    if(trigger==1)
    tokenString("KW", "read");
    if(trigger==0) LIST;
}

"boolean" {
    if(trigger==1)
    tokenString("KW", "boolean");
    if(trigger==0) LIST;
}

"bool" {
    if(trigger==1)
    tokenString("KW", "bool");
    if(trigger==0) LIST;
}

"void" {
    if(trigger==1)
    tokenString("KW", "void");
    if(trigger==0) LIST;
}

"float" {
    if(trigger==1)
    tokenString("KW", "float");
    if(trigger==0) LIST;
}

"double" {
    if(trigger==1)
    tokenString("KW", "double");
    if(trigger==0) LIST;
}


"string" {
    if(trigger==1)
    tokenString("KW", "string");
    if(trigger==0) LIST;
}


"continue" {
    if(trigger==1)
    tokenString("KW", "continue");
    if(trigger==0) LIST;
}


"break" {
    if(trigger==1)
    tokenString("KW", "break");
    if(trigger==0) LIST;
}


"return" {
    if(trigger==1)
    tokenString("KW", "return");
    if(trigger==0) LIST;
}


0|[1-9][0-9]* {
    if(trigger==1)
    tokenString("int" , yytext);
    if(trigger==0) LIST;
}

(0|[1-9][0-9]*)\.[0-9]* {
    if(trigger==1)
    tokenString("float" , yytext);
    if(trigger==0) LIST;
}

((0|[1-9][0-9]*)\.[0-9]*)("E"|"e")("+"|"-"|"*"|"/")(0|[1-9][0-9]*) {
    if(trigger==1)
    tokenString("scientific" , yytext);
    if(trigger==0) LIST;
}

"\""([\40-\176])*"\"" {
    strcpy(stg,"");
    for(i=1;i!=yyleng-1;i++){
        stg[i-1]=yytext[i];
    }
    if(trigger==1){
        tokenString("string",stg);
    }
    if(trigger==0) LIST;

}

" " {
    LIST;
}

\t {
    LIST;
}

"//"([\40-\176])* {
    
    LIST;
}

[_a-zA-Z]([_a-zA-Z]|[0-9])* {
    if(trigger==1){
        
        tokenString("id", yytext);
        
        if(exist==0){

            last = (id_cnt *)malloc(sizeof(id_cnt));
            last->cnt=1;
            strcpy(last->node,yytext);

            last->next=NULL;

            head=last;
  
            exist=1;
        }
        else{
            now=head;
            while(now->next!=NULL){
                if(strcmp(now->node,yytext)==0){
                    now->cnt++;
                    break;
                }
                now=now->next;
            }
            if(now->next==NULL){
                if(strcmp(now->node,yytext)==0){
                    now->cnt++;
                }
                else{
                    now->next = (id_cnt *)malloc(sizeof(id_cnt));
                    last=now->next;
                    last->cnt=1;
                    strcpy(last->node,yytext);
                    last->next=NULL;
                }
            }
            
        
        }
    }
    if(trigger==0) LIST;
}
^"#""pragma source on"$  {
    if(trigger==1)
    Opt_Source = 1;
    LIST;
}
^"#""pragma source on"(" ")*"//"([\40-\176])*  {
    if(trigger==1)
    Opt_Source = 1;
    LIST;
}
^"#""pragma source on"(" ")*"/*"  {
    if(trigger==1)
    Opt_Source = 1;
    
    trigger=0;
    LIST;
    BEGIN aa;
    
   
}


^"#""pragma source off"$ {
    if(trigger==1)
    Opt_Source = 0;
    LIST;
}
^"#""pragma source off"(" ")*"//"([\40-\176])* {
    if(trigger==1)
    Opt_Source = 0;
    LIST;
}
^"#""pragma source off"(" ")*"/*" {
    if(trigger==1)
    Opt_Source = 0;
    
    trigger=0;
    LIST;
    BEGIN aa;
}

^"#""pragma statistic off"$ {
    if(trigger==1)
    Opt_Statistic = 0;
    LIST;
}
^"#""pragma statistic off"(" ")*"//"([\40-\176])* {
    if(trigger==1)
    Opt_Statistic = 0;
    LIST;
}
^"#""pragma statistic off"(" ")*"/*" {
    if(trigger==1)
    Opt_Statistic = 0;
    
    trigger=0;
    LIST;
    BEGIN aa;
    
    
}
^"#""pragma statistic on"(" ")$ {
    if(trigger==1)
    Opt_Statistic = 1;
    LIST;
}
^"#""pragma statistic on"(" ")*"//"([\40-\176])* {
    if(trigger==1)
    Opt_Statistic = 1;
    LIST;
}
^"#""pragma statistic on"(" ")*"/*" {
    if(trigger==1)
    Opt_Statistic = 1;
    
    trigger=0;
    LIST;
    BEGIN aa;
    
    
}

^"#""pragma token off"$ {
    if(trigger==1)
    Opt_Token = 0;
    LIST;
}
^"#""pragma token off"(" ")*"//"([\40-\176])* {
    if(trigger==1)
    Opt_Token = 0;
    LIST;

}
^"#""pragma token off"(" ")*"/*" {
    if(trigger==1)
    Opt_Token = 0;
    
    trigger=0;
    LIST;
    BEGIN aa;
    

}

^"#""pragma token on"$ {
    if(trigger==1)
    Opt_Token = 1;
    LIST;
}
^"#""pragma token on"(" ")*"//"([\40-\176])* {
    if(trigger==1)
    Opt_Token = 1;
    LIST;
}
^"#""pragma token on"(" ")*"/*" {
    if(trigger==1)
    Opt_Token = 1;
    
    trigger=0;
    LIST;
    BEGIN aa;
    
}


"/*" {
    BEGIN aa;
    trigger=0;
    LIST;
}





<aa>"*/" {
    BEGIN 0;
    trigger=1;

    LIST;
}

<aa>([^*^\n]|(\*+([^*/^\n]))) {
    LIST;
 
    trigger=0;
}


<aa>\n {
    LIST;
    if (Opt_Source)
    printf("%d:%s\n", linenum, buf);
    ++linenum;
    buf[0] = '\0';
}

<aa>. { // Unrecognized character
    fprintf(stderr, "Error at line %d: %s\n", linenum, yytext);
    exit(1);
}


\r {
    LIST;
}

\n {
    LIST;
    if (Opt_Source)
    printf("%d:%s\n", linenum, buf);
    ++linenum;
    buf[0] = '\0';
}

. { // Unrecognized character
    fprintf(stderr, "Error at line %d: %s\n", linenum, yytext);
    exit(1);
}






%%

int main( int argc, char **argv )
{
    if (argc >= 2)
    {
        yyin = fopen( argv[1], "r" );
        if ( NULL == yyin ) {
            fprintf( stderr, "Cannot open: %s\n", argv[1] );
            exit(-1);
        }
    }
    else
    {
        yyin = stdin;
    }

    yylex();

    if (Opt_Statistic)
    {
        printf("frequencies of identifiers:\n");
        now=head;
        while(now->next!=NULL){
            printf("%s %d\n",now->node,now->cnt);
            now=now->next;
        }
        printf("%s %d\n",now->node,now->cnt);

    }

    exit(0);
}
