# ![[img|size]]
# s_!\[\[\([^\|]\)|\([^]]*\)\]\]_ <img src="\.\.\/Images\/\1" alt="\1" width="\2"> _g
# s/!\[\[\([^\|]\)|\([^]]*\)\]\]/ <img src="\.\.\/Images\/\1" alt="\1" width="\2"> /g
# [[file.pptx]]
# s_\[\[\(.*\).pptx\]\]_ <a href="\1.pptx"> \1 <\/a> _g
# [[md]]
# s/\[\[\([^]]*\)\]\]/ <a href="\1.html"> \1 <\/a> /g
# .md
s/.md/.html/g
# ../..
s!../../!./!g

