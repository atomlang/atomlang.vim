" File: atomlang.vim
" Author: Krisna Pranav 
" Description: Runtime files for AtomLang
" Last Modified: 25 Aug 2021

if exists("b:current_syntax")
  finish
endif

" Comments
" Shebang
syntax match atomlangShebang "\v#!.*$"

" Comment contained keywords
syntax keyword atomlangTodos contained TODO XXX FIXME NOTE
syntax keyword atomlangMarker contained MARK

" In comment identifiers
function! s:CommentKeywordMatch(keyword)
  execute "syntax match atomlangDocString \"\\v^\\s*-\\s*". a:keyword . "\\W\"hs=s+1,he=e-1 contained"
endfunction

syntax case ignore

call s:CommentKeywordMatch("attention")
call s:CommentKeywordMatch("author")
call s:CommentKeywordMatch("authors")
call s:CommentKeywordMatch("bug")
call s:CommentKeywordMatch("complexity")
call s:CommentKeywordMatch("copyright")
call s:CommentKeywordMatch("date")
call s:CommentKeywordMatch("experiment")
call s:CommentKeywordMatch("important")
call s:CommentKeywordMatch("invariant")
call s:CommentKeywordMatch("note")
call s:CommentKeywordMatch("parameter")
call s:CommentKeywordMatch("postcondition")
call s:CommentKeywordMatch("precondition")
call s:CommentKeywordMatch("remark")
call s:CommentKeywordMatch("remarks")
call s:CommentKeywordMatch("requires")
call s:CommentKeywordMatch("returns")
call s:CommentKeywordMatch("see")
call s:CommentKeywordMatch("since")
call s:CommentKeywordMatch("throws")
call s:CommentKeywordMatch("todo")
call s:CommentKeywordMatch("version")
call s:CommentKeywordMatch("warning")

syntax case match
delfunction s:CommentKeywordMatch


" Literals
" Strings
syntax region atomlangString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=atomlangInterpolatedWrapper oneline
syntax region atomlangInterpolatedWrapper start="\v[^\\]\zs\\\(\s*" end="\v\s*\)" contained containedin=atomlangString contains=atomlangInterpolatedString,atomlangString oneline
syntax match atomlangInterpolatedString "\v\w+(\(\))?" contained containedin=atomlangInterpolatedWrapper oneline

" Numbers
syntax match atomlangNumber "\v<\d+>"
syntax match atomlangNumber "\v<(\d+_+)+\d+(\.\d+(_+\d+)*)?>"
syntax match atomlangNumber "\v<\d+\.\d+>"
syntax match atomlangNumber "\v<\d*\.?\d+([Ee]-?)?\d+>"
syntax match atomlangNumber "\v<0x[[:xdigit:]_]+([Pp]-?)?\x+>"
syntax match atomlangNumber "\v<0b[01_]+>"
syntax match atomlangNumber "\v<0o[0-7_]+>"

" BOOLs
syntax keyword atomlangBoolean
      \ true
      \ false


" Operators
syntax match atomlangOperator "\v\~"
syntax match atomlangOperator "\v\s+!"
syntax match atomlangOperator "\v\%"
syntax match atomlangOperator "\v\^"
syntax match atomlangOperator "\v\&"
syntax match atomlangOperator "\v\*"
syntax match atomlangOperator "\v-"
syntax match atomlangOperator "\v\+"
syntax match atomlangOperator "\v\="
syntax match atomlangOperator "\v\|"
syntax match atomlangOperator "\v\/"
syntax match atomlangOperator "\v\."
syntax match atomlangOperator "\v\<"
syntax match atomlangOperator "\v\>"
syntax match atomlangOperator "\v\?\?"

" Methods/Functions/Properties
syntax match atomlangMethod "\(\.\)\@<=\w\+\((\)\@="
syntax match atomlangProperty "\(\.\)\@<=\<\w\+\>(\@!"

" Atomlang closure arguments
syntax match atomlangClosureArgument "\$\d\+\(\.\d\+\)\?"

syntax match atomlangAvailability "\v((\*(\s*,\s*[a-zA-Z="0-9.]+)*)|(\w+\s+\d+(\.\d+(.\d+)?)?\s*,\s*)+\*)" contains=atomlangString
syntax keyword atomlangPlatforms OSX iOS watchOS OSXApplicationExtension iOSApplicationExtension contained containedin=atomlangAvailability
syntax keyword atomlangAvailabilityArg renamed unavailable introduced deprecated obsoleted message contained containedin=atomlangAvailability

" Keywords {{{
syntax keyword atomlangKeywords
      \ and
      \ associatedtype
      \ associativity
      \ atexit
      \ break
      \ case
      \ catch
      \ class
      \ continue
      \ convenience
      \ default
      \ defer
      \ deinit
      \ didSet
      \ do
      \ dynamic
      \ else
      \ extension
      \ fallthrough
      \ fileprivate
      \ final
      \ for
      \ func
      \ get
      \ guard
      \ if
      \ import
      \ in
      \ infix
      \ init
      \ inout
      \ internal
      \ lazy
      \ let
      \ mutating
      \ nil
      \ nonmutating
      \ not
      \ operator
      \ optional
      \ or
      \ override
      \ postfix
      \ precedence
      \ precedencegroup
      \ prefix
      \ private
      \ protocol
      \ public
      \ repeat
      \ required
      \ rethrows
      \ return
      \ self
      \ set
      \ static
      \ subscript
      \ super
      \ switch
      \ throw
      \ throws
      \ try
      \ typealias
      \ unowned
      \ var
      \ weak
      \ where
      \ while
      \ willSet

syntax match atomlangMultiwordKeywords "indirect case"
syntax match atomlangMultiwordKeywords "indirect enum"
" }}}

" Names surrounded by backticks. This aren't limited to keywords because 1)
" Atomlang doesn't limit them to keywords and 2) I couldn't make the keywords not
" highlight at the same time
syntax region atomlangEscapedReservedWord start="`" end="`" oneline

syntax keyword atomlangAttributes
      \ @assignment
      \ @autoclosure
      \ @available
      \ @convention
      \ @discardableResult
      \ @exported
      \ @IBAction
      \ @IBDesignable
      \ @IBInspectable
      \ @IBOutlet
      \ @noescape
      \ @nonobjc
      \ @noreturn
      \ @NSApplicationMain
      \ @NSCopying
      \ @NSManaged
      \ @objc
      \ @testable
      \ @UIApplicationMain
      \ @warn_unused_result

syntax keyword atomlangConditionStatement #available

syntax keyword atomlangStructure
      \ struct
      \ enum

syntax keyword atomlangDebugIdentifier
      \ #column
      \ #file
      \ #function
      \ #line
      \ __COLUMN__
      \ __FILE__
      \ __FUNCTION__
      \ __LINE__

syntax keyword atomlangLineDirective #setline

syntax region atomlangTypeWrapper start="\v:\s*" skip="\s*,\s*$*\s*" end="$\|/"me=e-1 contains=ALLBUT,atomlangInterpolatedWrapper transparent
syntax region atomlangTypeCastWrapper start="\(as\|is\)\(!\|?\)\=\s\+" end="\v(\s|$|\{)" contains=atomlangType,atomlangCastKeyword keepend transparent oneline
syntax region atomlangGenericsWrapper start="\v\<" end="\v\>" contains=atomlangType transparent oneline
syntax region atomlangLiteralWrapper start="\v\=\s*" skip="\v[^\[\]]\(\)" end="\v(\[\]|\(\))" contains=ALL transparent oneline
syntax region atomlangReturnWrapper start="\v-\>\s*" end="\v(\{|$)" contains=atomlangType transparent oneline
syntax match atomlangType "\v<\u\w*" contained containedin=atomlangTypeWrapper,atomlangLiteralWrapper,atomlangGenericsWrapper,atomlangTypeCastWrapper

syntax keyword atomlangImports import
syntax keyword atomlangCastKeyword is as contained

" 'preprocesor' stuff
syntax keyword atomlangPreprocessor
      \ #if
      \ #elseif
      \ #else
      \ #endif
      \ #selector


" Comment patterns
syntax match atomlangComment "\v\/\/.*$"
      \ contains=atomlangTodos,atomlangDocString,atomlangMarker,@Spell oneline
syntax region atomlangComment start="/\*" end="\*/"
      \ contains=atomlangTodos,atomlangDocString,atomlangMarker,atomlangComment,@Spell fold


" Range patterns, ex: start...end
syntax match atomlangRange "\v[a-zA-Z0-9]+\.\.[<\.]{1}[a-zA-Z0-9]+"
syntax match atomlangRangeFalse "\v[a-zA-Z0-9]+[\.]{2}[a-zA-Z0-9]+"

" Set highlights
highlight default link atomlangTodos Todo
highlight default link atomlangDocString String
highlight default link atomlangShebang Comment
highlight default link atomlangComment Comment
highlight default link atomlangRange PreProc
highlight default link atomlangMarker Comment

highlight default link atomlangString String
highlight default link atomlangInterpolatedWrapper Delimiter
highlight default link atomlangNumber Number
highlight default link atomlangBoolean Boolean

highlight default link atomlangOperator Operator
highlight default link atomlangCastKeyword Keyword
highlight default link atomlangKeywords Keyword
highlight default link atomlangMultiwordKeywords Keyword
highlight default link atomlangEscapedReservedWord Normal
highlight default link atomlangClosureArgument Operator
highlight default link atomlangAttributes PreProc
highlight default link atomlangConditionStatement PreProc
highlight default link atomlangStructure Structure
highlight default link atomlangType Type
highlight default link atomlangImports Include
highlight default link atomlangPreprocessor PreProc
highlight default link atomlangMethod Function
highlight default link atomlangProperty Identifier

highlight default link atomlangConditionStatement PreProc
highlight default link atomlangAvailability Normal
highlight default link atomlangAvailabilityArg Normal
highlight default link atomlangPlatforms Keyword
highlight default link atomlangDebugIdentifier PreProc
highlight default link atomlangLineDirective PreProc

" Force vim to sync at least x lines. This solves the multiline comment not
" being highlighted issue
syn sync minlines=100

let b:current_syntax = "atomlang"