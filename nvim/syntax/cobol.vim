" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

setlocal isk=@,48-57,-,_

syn case ignore

syn match   cobolLine           ".*$"      contains=cobolStatement,cobolInlineComment,cobolString,cobolKeyword,cobolDecl,cobolFunction,@cobolLine
syn match   cobolLineComment    "^[\*\/].*$"
syn match   cobolEfdDirective   "^$efd"
syn match   cobolInlineComment  "|.*$" contained
syn match   cobolDecl           "^\s*\([0-9][0-9]\)" contained
syn match   cobolString         "\"[^\"]*\"" contained
syn match   cobolStatement      "\(=\|<\|>\|\.\|(\|)\|+\|*\|/\|:\|,\)" contained
syn match   cobolFunction       /\(\$\|:>\)[a-zA-Z_]\w*\(-\w*\)*/ contained


syn keyword cobolKeyword   contained accept add all assign and call cancel close compute end-compute commit continue convert copy delete delimited display divide else end-call end-if end-evaluate end-perform
syn keyword cobolKeyword   contained evaluate exit from giving go goback if in initialize inspect into is merge move multiply not open or other perform read release return rollback run
syn keyword cobolKeyword   contained replacing rounded search select set size sort subtract start stop string end-string to trailing unstring end-unstring unlock until using varying when write .
syn keyword cobolKeyword   contained apply access address advancing after alphabet alphabetic
syn keyword cobolKeyword   contained alphabetic-lower alphabetic-upper alphanumeric alphanumeric-edited
syn keyword cobolKeyword   contained alternate any are area areas ascending as at author before binary
syn keyword cobolKeyword   contained blank block boolean bottom by capacity catch cd cf chaining character characters class
syn keyword cobolKeyword   contained clock-units cobol code code-set collating column comma common
syn keyword cobolKeyword   contained communications computational configuration content
syn keyword cobolKeyword   contained control converting corr corresponding count currency data date date-compiled
syn keyword cobolKeyword   contained date-written day day-of-week de debug-contents debug-item debug-line
syn keyword cobolKeyword   contained debug-name debug-sub-1 debug-sub-2 debug-sub-3 debugging decimal-point
syn keyword cobolKeyword   contained delaratives delimiter depending descending destination destroy
syn keyword cobolKeyword   contained detail disable disk division down duplicates dynamic egi emi
syn keyword cobolKeyword   contained environment equal error esi every exception exception-object
syn keyword cobolKeyword   contained extend external false fd file file-id filler file-control final first footing for
syn keyword cobolKeyword   contained global greater group handle heading high-value high-values i-o
syn keyword cobolKeyword   contained identification identified index indexed indicate initial
syn keyword cobolKeyword   contained initiate input input-output installation i-o-control int just
syn keyword cobolKeyword   contained justified key label last leading left length linkage lock lock-holding  manual memory
syn keyword cobolKeyword   contained message mode modules multiple native negative next no
syn keyword cobolKeyword   contained number numeric numeric-edited occurs of off omitted on
syn keyword cobolKeyword   contained object optional order organization output overflow packed-decimal padding
syn keyword cobolKeyword   contained page page-counter pic picture plus pointer position positive
syn keyword cobolKeyword   contained printing procedure procedures program program-id purge queue quotes
syn keyword cobolKeyword   contained random rd read receive record records redefines reference references
syn keyword cobolKeyword   contained relative release remainder removal replace report reporting
syn keyword cobolKeyword   contained reports repository rerun reserve reset return returning reversed rewind rewrite rf rh
syn keyword cobolKeyword   contained right same sd section security segment segment-limited
syn keyword cobolKeyword   contained send sentence separate sequence sequential sign
syn keyword cobolKeyword   contained sort-merge source standard
syn keyword cobolKeyword   contained standard-1 standard-2 status sub-queue-1 sub-queue-2
syn keyword cobolKeyword   contained sub-queue-3 sum suppress symbolic sync synchronized table tallying
syn keyword cobolKeyword   contained tape terminal terminate test text than then through thru time times top
syn keyword cobolKeyword   contained transaction true try end-try type unit up upon usage use value values
syn keyword cobolKeyword   contained window with words working-storage

hi def link cobolLineComment    Comment
hi def link cobolInlineComment  Comment
hi def link cobolStatement      Statement
hi def link cobolKeyword        Statement
hi def link cobolEfdDirective   Keyword
hi def link cobolDecl           Type
hi def link cobolString         String
hi def link cobolFunction       Function

let b:current_syntax = "cobol"

