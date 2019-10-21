import pmapi

type
  pmnsNode* {.bycopy.} = object
    parent*: ptr pmnsNode
    next*: ptr pmnsNode
    first*: ptr pmnsNode
    hash*: ptr pmnsNode       ##  used as "last" in build, then pmid hash synonym
    name*: cstring
    pmid*: pmID


##
##  Internal structure of a PMNS tree
##

type
  pmnsTree* {.bycopy.} = object
    root*: ptr pmnsNode       ##  root of tree structure
    htab*: ptr ptr pmnsNode    ##  hash table of nodes keyed on pmid
    htabsize*: cint            ##  number of nodes in the table
    mark_state*: cint          ##  the total mark value for trimming

  pmdaNameSpace* = pmnsTree
