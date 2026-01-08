" Vim syntax file
" Language:	Textile
" Maintainer:	Kornelius Kalnbach <korny@cYcnus.de>
" URL:		
" Last Change:  2006 Mar 31

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
syntax clear

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'textile'
endif

runtime! syntax/html.vim
runtime! syntax/html/*.vim

let s:cpo_save = &cpo
set cpo&vim

" don't use standard HiLink, it will not work with included syntax files
	if version < 508
		command! -nargs=+ TextileHiLink hi link <args>
		let did_textile_syn_inits = 1
	else
		command! -nargs=+ TextileHiLink hi def link <args>
	endif

syn case match
syn sync minlines=50

syn match textileGlyph /\(\s\@<=\([-x]\)\s\@=\|\.\.\.\|(\(TM\|R\|C\))\)/

syn region textileAcronym matchgroup=textileAcronymTag start=/\<\u\{3,}(/ end=/)/

syn cluster TextileFormatTags contains=textileLink,textileImage,textileAncronym,textileEm,textileStrong,textileItalic,textileBold,textileCode,textileSubtext,textileSupertext,textileCitation,textileDeleted,textileInserted,textileSpan,textileNoTextile,textileGlyph,textileAcronym,textileHtml

syn region textileSpan oneline matchgroup=textileFormatTagSpan contains=textileSpanKeyword start=/\w\@<!%\s\@!/ end=/\s\@<!%\w\@!/

syn region textileEm oneline matchgroup=textileFormatTag start=/\w\@<!_\s\@!/ end=/\s\@<!_\w\@!/ contains=@TextileFormatTags
syn region textileStrong oneline matchgroup=textileFormatTag start=/\w\@<!\*\s\@!/ end=/\s\@<!\*\w\@!/ contains=@TextileFormatTags
syn region textileItalic oneline matchgroup=textileFormatTag start=/\w\@<!__\s\@!/ end=/\s\@<!__\w\@!/ contains=@TextileFormatTags
syn region textileBold oneline matchgroup=textileFormatTag start=/\w\@<!\*\*\s\@!/ end=/\s\@<!\*\*\w\@!/ contains=@TextileFormatTags

syn region textileCode oneline matchgroup=textileFormatTag start=/\w\@<!@\s\@!/ end=/\s\@<!@\w\@!/
syn region textileSubtext oneline matchgroup=textileFormatTag start=/\w\@<!\~\s\@!/ end=/\s\@<!\~\w\@!/
syn region textileSupertext oneline matchgroup=textileFormatTag start=/\w\@<!\^\s\@!/ end=/\s\@<!\^\w\@!/
syn region textileCitation oneline matchgroup=textileFormatTag start=/\w\@<!??\s\@!/ end=/\s\@<!??\w\@!/
syn region textileDeleted oneline matchgroup=textileFormatTag start=/\w\@<!-\s\@!/ end=/\s\@<!-\w\@!/
syn region textileInserted oneline matchgroup=textileFormatTag start=/\w\@<!+\s\@!/ end=/\s\@<!+\w\@!/

syn match textileHtml /<\/\=\w[^>]*>/
syn match textileHtml /&\w\+;/

syn region textileCode matchgroup=textileTag start="<pre[^>]*>" end="</pre>"
syn region textileCode matchgroup=textileTag start="<code[^>]*>" end="</code>"

syn region textileNoTextile matchgroup=textileTag start=/\w\@<!==\s\@!/ end=/\s\@<!==\w\@!/
syn region textileNoTextile matchgroup=textileTag start="<notextile>" end="</notextile>"

syn match textileHR /^-\{3,}/

" textile
syn region textileHeadSection start=/^\(---\)/ skip=/\n\n\@!/ end=/\n/ keepend fold
syn region textileHeadLayout start=/^\(layout\)/ skip=/\n\n\@!/ end=/:/ keepend fold
syn region textileHeadTitle start=/^\(title\)/ skip=/\n\n\@!/ end=/:/ keepend fold
syn region textileHeadKeywords start=/^\(keywords\)/ skip=/\n\n\@!/ end=/:/ keepend fold
syn region textileHeadDescription start=/^\(description\)/ skip=/\n\n\@!/ end=/:/ keepend fold 
syn region textileInclude start=/\({% include\)/ skip=/\n\n\@!/ end=/%}/ keepend fold 

syn region textileH1 start=/^\(h[1]\(\[[^\]]*\]\|{[^}]*}\|([^)]*)\|[()]\+\|[<>=]\)*\.\( \|$\)\)\@=/ skip=/\n\n\@!/ end=/\n/ keepend fold contains=@TextileFormatTags,textileKeywordH1
syn region textileH start=/^\(h[2-6]\(\[[^\]]*\]\|{[^}]*}\|([^)]*)\|[()]\+\|[<>=]\)*\.\( \|$\)\)\@=/ skip=/\n\n\@!/ end=/\n/ keepend fold contains=@TextileFormatTags,textileKeyword
syn region textileP start=/^\(p\(\[[^\]]*\]\|{[^}]*}\|([^)]*)\|[()]\+\|[<>=]\)*\.\( \|$\)\)\@=/ skip=/\n\n\@!/ end=/\n/ keepend fold contains=@TextileFormatTags,textileKeyword
syn region textileBQ start=/^\(bq\(\[[^\]]*\]\|{[^}]*}\|([^)]*)\|[()]\+\|[<>=]\)*\.\( \|$\)\)\@=/ skip=/\n\n\@!/ end=/\n/ keepend fold contains=@TextileFormatTags,textileKeyword
syn region textileListItem matchgroup=textileListDot1 start=/^\*\+\(\[[^\]]*\]\|{[^}]*}\|([^)]*)\|[()]\+\|[<>=]\)*\( \|$\)/ skip=/\n\(\*\|\n\)\@!/ end=/\n/ keepend fold contains=@TextileFormatTags
syn region textileListItem matchgroup=textileListDot2 start=/^#\+\(\[[^\]]*\]\|{[^}]*}\|([^)]*)\|[()]\+\|[<>=]\)*\( \|$\)/ skip=/\n\(#\|\n\)\@!/ end=/\n/ keepend fold contains=@TextileFormatTags
syn region textileTable start=/^\(table\(\[[^\]]*\]\|{[^}]*}\|([^)]*)\|[<>=]\)*\.\( \|$\)\)\@=/ skip=/\n\n\@!/ end=/\n/ keepend fold contains=@TextileFormatTags,textileKeyword

syn region textileKeywordH1 contained start=/^\(h1\>\)/ skip=/\[[^\]]*\]\|{[^}]*}\|([^)]*)\|[()]\+\|[<>=]/ end=/\.\=/ contains=textileArg,textileLang,textileClass,textileIndent,textileArgError
syn region textileKeyword contained start=/^\(bq\>\|p\>\|h[2-6]\>\|#\+\|\*\+\|table\>\)/ skip=/\[[^\]]*\]\|{[^}]*}\|([^)]*)\|[()]\+\|[<>=]/ end=/\.\=/ contains=textileArg,textileLang,textileClass,textileIndent,textileArgError
syn region textileSpanKeyword contained start=/\(\w\@<!%\s\@!\)\@<=/ skip=/\[[^\]]*\]\|{[^}]*}\|([^)]*)\|(\+\|)\+\|[<>=]/ end=/./ contains=textileArg,textileLang,textileClass,textileIndent,textileArgError
syn region textileArg contained matchgroup=textileBrace start=/{}\@!/ end=/}/
syn match textileIndent contained /[()]\+\|[<>=]/
syn region textileClass contained matchgroup=textileBrace start=/()\@!\([^)]\+)\)\@=/ end=/)/
syn region textileLang contained matchgroup=textileBrace start=/\[\]\@!/ end=/\]/
syn match textileArgError contained /{}\|\[\]\|()/
syn match textileRestOfBlock contained /\_.*/ transparent

syn match textileLink /"[^"]*":\S*[[:alnum:]_\/]/ keepend contains=textileLinkName
syn region textileLinkName matchgroup=textileBrace contained start=/"/ end=/"/ contains=@TextileFormatTags nextgroup=textileLinkColon
syn match textileLinkColon contained /:/ nextgroup=textileLinkURL
syn match textileLinkURL contained /.*/

syn match textileImage /![^!(]*\(([^)]*)\)\=!/ contains=textileImageURL
syn region textileImageURL matchgroup=textileFormatTag contained contains=textileImageTitle start=/!/ skip=/([^(])/ end=/!/ nextgroup=textileLinkColon
syn region textileImageTitle matchgroup=textileFormatTag contained start="(" end=")"


  TextileHiLink textileHeadSection Type
  TextileHiLink textileHeadLayout String
  TextileHiLink textileHeadTitle Identifier
  TextileHiLink textileHeadKeywords Identifier
  TextileHiLink textileHeadDescription Identifier
  TextileHiLink textileInclude String
  TextileHiLink textileTag Identifier
  "TextileHiLink textileFormatTag Normal
  "TextileHiLink textileNoTextile Normal
  
  TextileHiLink textileEm textileItalic
  TextileHiLink textileStrong textileBold
  TextileHiLink textileItalic textileMakeItalic
  TextileHiLink textileBold textileMakeBold
  TextileHiLink textileCode Identifier

  TextileHiLink textileSubtext String
  TextileHiLink textileSupertext String
  TextileHiLink textileCitation String
  TextileHiLink textileDeleted String
  TextileHiLink textileInserted textileUnderline
  
  "TextileHiLink textileSpan Normal
  TextileHiLink textileFormatTagSpan textileTag

  TextileHiLink textileH1 Type
  TextileHiLink textileKeywordH1 htmlTagName

  TextileHiLink textileH Title
  TextileHiLink textileHTag textileTag
  TextileHiLink textileP Normal
  TextileHiLink textilePTag textileTag
  TextileHiLink textileBQ Normal
  TextileHiLink textileBQTag textileTag
  TextileHiLink textileListDot1 Type
  TextileHiLink textileListDot2 Todo
  
  "TextileHiLink textileTable Normal
  TextileHiLink textileTableTag textileTag

  TextileHiLink textileKeyword htmlTagName
  TextileHiLink textileArg Type
  TextileHiLink textileClass Statement
  TextileHiLink textileLang String
  TextileHiLink textileIndent String
  TextileHiLink textileArgError Error
  TextileHiLink textileBrace Normal
  TextileHiLink textileRestOfBlock Number

  "TextileHiLink textileLink Normal
  TextileHiLink textileLinkName String
  TextileHiLink textileLinkColon textileBrace
  TextileHiLink textileLinkURL Underlined
  
  TextileHiLink textileImage Type
  TextileHiLink textileImageURL String
  TextileHiLink textileImageTitle Statement

	TextileHiLink textileGlyph Special
	TextileHiLink textileHR Title
	TextileHiLink textileAcronym String
	TextileHiLink textileAcronymTag Special

	TextileHiLink textileHtml Normal
  
  if !exists("html_no_rendering")
    if !exists("textile_my_rendering")
      hi def textileMakeBold            term=bold cterm=bold gui=bold
      hi def textileBoldUnderline       term=bold,underline cterm=bold,underline gui=bold,underline
      hi def textileBoldItalic          term=bold,italic cterm=bold,italic gui=bold,italic
      hi def textileBoldUnderlineItalic term=bold,italic,underline cterm=bold,italic,underline gui=bold,italic,underline
      hi def textileUnderline           term=underline cterm=underline gui=underline
      hi def textileUnderlineItalic     term=italic,underline cterm=italic,underline gui=italic,underline
      hi def textileMakeItalic          term=italic cterm=italic gui=italic
      hi def textileLink                term=underline cterm=underline gui=underline
    endif
  endif



let b:current_syntax = "textile"

if main_syntax == 'textile'
  unlet main_syntax
endif
