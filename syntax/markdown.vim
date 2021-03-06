" Vim syntax file
" Language: Markdown
" Author:   Hallison Batista <hallison.batista@gmail.com>
" URL:      http://github.com/hallison/vim-markdown/
" Version:  fatal: Not a git repository (or any of the parent directories): .git 
" Release:  
" Remark:
"   This syntax plugin was fully rewritten from source written by Ben Williams <benw@plasticboy.com>
" Remark:
"   Uses HTML syntax file
if exists("b:current_syntax")
  finish
endif
" Commands for compatibilities and helpers
if version < 508
  syntax clear
  command! -nargs=+ Highlight highlight link <args>
  " Read the HTML syntax
  source <sfile>:p:h/html.vim
else
  command! -nargs=+ Highlight highlight default link <args>
  " Read the HTML syntax
  runtime! syntax/html.vim
endif
unlet b:current_syntax
syntax spell toplevel
syntax sync minlines=10
syntax sync linebreaks=1
"syntax case ignore
syntax match markdownAsterisk         contained "\*"   conceal
syntax match markdownPlus             contained "+"   "conceal
syntax match markdownMinus            contained "\-"  "conceal
syntax match markdownUnderscore       contained "_"    conceal
syntax match markdownHash             contained "#"   "conceal
syntax match markdownBacktick         contained "`"    conceal
syntax match markdownQuote            contained "\""   conceal
syntax match markdownApostrophe       contained "'"    conceal
syntax match markdownColon            contained ":"   "conceal
syntax match markdownBracketLeft      contained "\["   conceal
syntax match markdownBracketRight     contained "\]"   conceal
syntax match markdownParenthesisLeft  contained "("    conceal
syntax match markdownParenthesisRight contained ")"    conceal
Highlight markdownAsterisk         Operator
Highlight markdownPlus             Operator
Highlight markdownMinus            Operator
Highlight markdownUnderscore       Operator
Highlight markdownHash             Operator
Highlight markdownBacktick         Operator
Highlight markdownQuote            Operator
Highlight markdownApostrophe       Operator
Highlight markdownColon            Operator
Highlight markdownBracketLeft      Operator
Highlight markdownBracketRight     Operator
Highlight markdownParenthesisLeft  Operator
Highlight markdownParenthesisRight Operator
" Escapes
syntax match markdownEscapeChars "\\[][\\`*_{}()#+.!-]"
" Spans
syntax cluster markdownSpan       contains=@markdownStyle,markdownLineBreak,markdownLink
syntax cluster markdownStyle      contains=markdownBold,markdownEmphasis,markdownBoldEmphasis,markdownCode,htmlSpecialChar
syntax match   markdownStyleRule  /^\s*_\s\{0,1}_\s\{0,1}_$/
"@ *markdown* - Syntax highlight for Vim editor
"@
"@ Keywords: *markdown* *mkd*
"@
"@ ==============================================================================
"@ Contents                                                   *markdown-contents*
"@
"@   1. Information about this plugin......................|markdown|
"@   2. Markdown Syntax....................................|markdown-syntax|
"@      2.1. Paragraphs....................................|markdown-paragraphs|
"@      2.2. Line breaks...................................|markdown-line-breaks|
"@      2.3. Headers.......................................|markdown-headers|
"@      2.4. Blockquotes...................................|markdown-blockquotes|
"@      2.5. Lists.........................................|markdown-lists|
"@      2.6. Codeblocks....................................|markdown-codeblocks|
"@      2.7. Horizontal rules..............................|markdown-hrules|
"@      2.8. Links.........................................|markdown-links|
"@      2.9. Emphasis......................................|markdown-emphasis|
"@      2.10. Code.........................................|markdown-code|
"@      2.11. Images.......................................|markdown-images|
"@   3. Snippets...........................................|markdown-snippets|
"@
"@ ==============================================================================
"@ Information about this plugin                                       *markdown*
"@
"@ Author          : Hallison Batista <hallison.batista@gmail.com>
"@ Vim Script Page : http://www.vim.org/scripts/script.php?script_id=2882
"@ Repository      : http://github.com/hallison/vim-markdown
"@
"@ ==============================================================================
"@ Formatting Syntax                                            *markdown-syntax*
"@
"@ The full syntax reference can be read in the official site of the author John
"@ Grubber http://daringfireball.net/projects/markdown/.
"@
"@ This *plugin* is a *syntax* *highlight* and was developed and tested using
"@ the official parser implemented by John Grubber in Perl. Other parsers was
"@ used:
"@
"@ * maruku    - Ruby implementation library.
"@ * rdiscount - Ruby implementation library.
"@
"@ ------------------------------------------------------------------------------
"@ Paragraphs                                               *markdown-paragraphs*
"@
"@ A paragraph is simply one or more consecutive lines of text, separated by one
"@ or more blank lines. Normal paragraphs should not be indented with spaces or
"@ tabs. Example: >
"@
"@   This is a sample of paragraph that will separated by blank lines before and
"@   after.
"@
"@ >
"@ 
"@ ------------------------------------------------------------------------------
"@ Line breaks                                             *markdown-line-breaks*
"@
"@ The line breaks can be included inside a paragraph by two or more spaces
"@ followed by return. Example: >
"@    
"@   This is a sample of paragraph that will separated by blank lines and   
"@   contains a line break.
syntax match markdownLineBreak /\s\{2,}$/ conceal cchar=¬ "cchar=¶
syntax cluster markdownParagraph contains=markdownLineBreak,@markdownSpans
Highlight markdownLineBreak Comment
syntax cluster markdownBlocks contains=@markdownParagraph
"@ ------------------------------------------------------------------------------
"@ Headers                                                      *markdown-headers*
"@ 
"@ For headers, *Markdown* offers two styles to write: setext and atx. Example: >
"@ 
"@   1st level header
"@   ================
"@ 
"@   2nd level header
"@   ----------------
"@ 
"@   Body text and several paragraphs separated by blank lines.
"@ 
"@   ### 3rd level header
"@ 
"@   Body text and several paragraphs separated by blank lines.
"@
"@   #### 4th level header
"@
"@   ##### 5th level header
"@
"@   ###### 6th level header
"@ >
"@ 
"@ To create an atx-style header, you put 1-6 hash marks (#) at the beginning of
"@ the line — the number of hashes equals the resulting HTML header level.
"@ 
syntax match markdownHeaderUnderline contained /^[=-]\+$/
syntax match markdownHeaderLine      contained /^[#]{1,6}/
syntax match markdownHeader1 /^.\+\n=\+$/ contains=markdownHeaderUnderline,@markdownStyle,@Spell
syntax match markdownHeader2 /^.\+\n-\+$/ contains=markdownHeaderUnderline,@markdownStyle,@Spell
syntax region markdownHeader1 start="^\s*#"      end="\($\|#\+\)" contains=markdownHash,@markdownSpanElements,@Spell
syntax region markdownHeader2 start="^\s*##"     end="\($\|#\+\)" contains=markdownHash,@markdownSpanElements,@Spell
syntax region markdownHeader3 start="^\s*###"    end="\($\|#\+\)" contains=markdownHash,@markdownSpanElements,@Spell
syntax region markdownHeader4 start="^\s*####"   end="\($\|#\+\)" contains=markdownHash,@markdownSpanElements,@Spell
syntax region markdownHeader5 start="^\s*#####"  end="\($\|#\+\)" contains=markdownHash,@markdownSpanElements,@Spell
syntax region markdownHeader6 start="^\s*######" end="\($\|#\+\)" contains=markdownHash,@markdownSpanElements,@Spell
" Highlight headers
Highlight markdownHeader1         htmlH1
Highlight markdownHeader2         htmlH2
Highlight markdownHeader3         htmlH3
Highlight markdownHeader4         htmlH4
Highlight markdownHeader5         htmlH5
Highlight markdownHeader6         htmlH6
Highlight markdownHeaderUnderline Operator
Highlight markdownHeaderLine      Operator
syntax cluster markdownBlocks contains=markdownHeader1,markdownHeader2,markdownHeader3,markdownHeader4,markdownHeader5,markdownHeader6
" Blockquotes
syntax match  markdownBlockquoteRule /^[>]\{1,6}/ contained conceal
syntax region markdownBlockquote matchgroup=markdownBlockquoteRule start=/^\s*>/ end=/$/ contains=@markdownBlock,@Spell
Highlight markdownBlockquoteRule Ignore
Highlight markdownBlockquote     htmlItalic
"@ ------------------------------------------------------------------------------
"@ Lists                                                         *markdown-lists*
"@
"@ Unordered (bulleted) lists use asterisks and hyphens (* and -) and ordered
"@ lists use plus (+). >
"@
"@   Unordered list:
"@
"@   * item two
"@   * item one
"@   * item three
"@
"@   Or
"@
"@   - item two
"@   - item one
"@   - item three
"@
"@   Ordered list:
"@
"@   + item one
"@   + item two
"@   + item three
"@
"@   Or uses nested list:
"@
"@   + Item one
"@
"@     It's possible includes paragraphs.
"@
"@     - content 1.1
"@     - content 1.2
"@
"@   + Item two
"@
"@     - content 2.1
"@     - content 2.2
"@ >
"@
" Lists
" TOFIX: Lists and codeblocks collide
syntax match markdownListItemRule /^\([\*\+\-]\|\s\{0,3}[\*\+\-]\)\s/
syntax region markdownListItem matchgroup=markdownListItemRule start=/^\([\*\+\-]\|\s\{1,}[\*\+\-]\)\s/ end=/$/
"syntax match markdownListMultiLineItemRule /^\(\s\{4,}\|\t{1,}\)[\*\+\-]\s/
"/^[\*\-\+].*$\n/
"/^\s*\zs[\*\+\-].*$/
" List items
"syntax match markdownListItem /^\s*[-*+]\s\+.*\n\(\(^.\+\n\)*\n\?\)\(\(^\(\s\{4}\|\t\)\+.*\n\)\(^.\+\n\)*\n\?\)*/  contains=@markdownSpan
"syntax match markdownListItem /^\s*\d\+\.\s\+.*\n\(\(^.\+\n\)*\n\?\)\(\(^\(\s\{4}\|\t\)\+.*\n\)\(^.\+\n\)*\n\?\)*/ contains=@markdownSpan
"syntax region markdownListItem matchgroup=markdownListOneItemRule start="^[\*\-\+].*$\n" end="$\n"
"syntax cluster markdownList contains=markdownListOneItemRule,markdownListItem
"Highlight markdownListMultiLineItemRule Special
Highlight markdownListItemRule Identifier
Highlight markdownListItem String
syntax cluster markdownBlocks contains=markdownListItem
"@ ------------------------------------------------------------------------------
"@ Blockquotes                                             *markdown-blockquotes*
"@ 
"@ A blockquote text must start with > a
"@
syntax match markdownCodeBlockRule /^\(\s\{4}\|\t{1}\)[^\*\-\+]/ conceal
" Code Block
syntax region markdownCodeBlock matchgroup=markdownCodeBlockRule start=/^\(\s\{4}\|\t{1}\)[^\*\-\+]/ end="$"
syntax region markdownCodeBlock start=/^```$/ end=/^```$/ keepend contains=markdownBacktick
Highlight markdownCodeBlockRule Identifier
Highlight markdownCodeBlock     Identifier
syntax cluster markdownBlocks contains=markdownCodeBlock,@Spell
"MKD_HRULES
"@ ------------------------------------------------------------------------------
"@ Links                                                         *markdown-links*
"@ 
syntax region markdownLink      start="\[\S\@="    end="\S\@<=\]\s\{,1}[\[(]"me=e-1 skipwhite keepend oneline nextgroup=markdownLinkUrl,markdownLinkId contains=markdownBracketLeft,markdownBracketRight,@Spell
syntax region markdownLinkId    start="\["         end="\]"  contained keepend oneline conceal contains=markdownBracketLeft,markdownBracketRight
syntax region markdownLinkId    start="^\s\{,3}\[" end="\]:" keepend oneline skipwhite nextgroup=markdownUrl,markdownLinkTitle contains=markdownBracketLeft,markdownBracketRight,markdownColon
syntax region markdownLinkUrl   start="("          end=")"   contained keepend oneline contains=markdownLinkExternalUrl,markdownParenthesisRight,markdownLinkTitle
syntax region markdownLinkTitle start=+"+          end=+"+   contained keepend contains=markdownQuote,@Spell
syntax region markdownLinkTitle start=+'+          end=+'+   contained keepend contains=markdownApostrophe,@Spell
syntax region markdownLinkTitle start=+(+          end=+)+   contained keepend contains=markdownParenthesisLeft,markdownParenthesisRight,@Spell
syntax match markdownLinkExternalUrl contained "("    nextgroup=markdownUrl conceal cchar=> "cchar=»
syntax match markdownUrl             contained "\S\+" nextgroup=markdownLinkTitle skipwhite skipnl
Highlight markdownLink            htmlLink
Highlight markdownLinkId          Identifier
Highlight markdownLinkUrl         Operator
Highlight markdownLinkTitle       Comment
Highlight markdownUrl             String
Highlight markdownLinkExternalUrl Operator
syntax cluster markdownSpans contains=markdownLink
"@ ------------------------------------------------------------------------------
"@ Phase emphasis                                             *markdown-emphasis*
"@ 
"@ *Markdown* uses asterisks and underscores to indicate spans of emphasis. >
"@ 
"@   This text has *several* _emphasis_. But if you want use strong emphasis,
"@   just write using double **asterisks** or __underscores__.
"@ >
"@ 
syntax region markdownEmphasis start=/_\S\@=/  end=/\S\@<=_/  keepend contains=markdownUnderscore,@Spell
syntax region markdownEmphasis start=/\*\S\@=/ end=/\S\@<=\*/ keepend contains=markdownAsterisk,@Spell
Highlight markdownEmphasis htmlItalic
syntax cluster markdownSpans contains=markdownEmphasis
syntax region markdownBold start=/\*\*\S\@=/ end=/\S\@<=\*\*/ keepend contains=markdownAsterisk,markdownAsterisk,@Spell
syntax region markdownBold start=/__\S\@=/   end=/\S\@<=__/   keepend contains=markdownUnderscore,markdownUnderscore,@Spell
Highlight markdownBold htmlBold
syntax cluster markdownSpans contains=markdownBold
syntax region markdownBoldEmphasis start=/\*__\S\@=/   end=/\S\@<=__\*/   keepend contains=markdownAsterisk,markdownUnderscore,markdownUnderscore,@Spell
syntax region markdownBoldEmphasis start=/\*\*_\S\@=/  end=/\S\@<=_\*\*/  keepend contains=markdownAsterisk,markdownAsterisk,markdownUnderscore,@Spell
syntax region markdownBoldEmphasis start=/\*\*\*\S\@=/ end=/\S\@<=\*\*\*/ keepend contains=markdownAsterisk,markdownAsterisk,markdownAsterisk,@Spell
syntax region markdownBoldEmphasis start=/_\*\*\S\@=/  end=/\S\@<=\*\*_/  keepend contains=markdownUnderscore,markdownAsterisk,markdownAsterisk,@Spell
syntax region markdownBoldEmphasis start=/__\*\S\@=/   end=/\S\@<=\*__/   keepend contains=markdownUnderscore,markdownUnderscore,markdownAsterisk,@Spell
syntax region markdownBoldEmphasis start=/___\S\@=/    end=/\S\@<=___/    keepend contains=markdownUnderscore,markdownUnderscore,markdownUnderscore,@Spell
Highlight markdownBoldEmphasis htmlBoldItalic
syntax cluster markdownSpans contains=markdownBoldEmphasis
" Code
syntax region markdownCode start=/\\\@<!`/    end=/\\\@<!`/    keepend contains=markdownBacktick
syntax region markdownCode start=/\s*``[^`]*/ end=/[^`]*``\s*/ keepend contains=markdownBacktick
syntax region markdownCode start=/<pre[^>]*/  end=/<\/pre>/    keepend
syntax region markdownCode start=/<code[^>]*/  end=/<\/code>/  keepend
Highlight markdownCode Identifier
syntax cluster markdownSpans contains=markdownCode,@Spell
"MKD_IMAGE
let b:current_syntax = "markdown"
delcommand Highlight
" vim:tabstop=2
