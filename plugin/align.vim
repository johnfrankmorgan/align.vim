function! s:align_regex(regex) range abort
  let max_position = 0
  let replacements = {}

  for line_num in range(a:firstline, a:lastline)
    let line = getline(line_num)
    let position = match(line, a:regex)

    if position < 0
      continue
    endif

    if position > max_position
      let max_position = position
    endif

    let replacements[line_num] = position
  endfor

  for [line_num, position] in items(replacements)
    let line = getline(line_num)

    let start = strpart(line, 0, position)
    let end = strpart(line, position)
    let padding = repeat(' ', max_position-position)

    call setline(line_num, printf('%s%s%s', start, padding, end))
  endfor
endfunction

command! -nargs=1 -range AlignRegex <line1>,<line2>call <SID>align_regex(<args>)

" [
"   "test" => "tttt",
"   "fsdfsdf" => "sfddsfd",
"   "fsdfsdfsdf" => "sfddsfd",
" ]
