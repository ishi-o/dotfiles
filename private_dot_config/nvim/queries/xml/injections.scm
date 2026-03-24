; extends

(
  (element
    (STag (Name) @_name)
    (content (CharData) @injection.content)
    (#any-of? @_name "select" "insert" "update" "delete" "sql"))
  (#set! injection.language "sql")
)

(
  (element
    (STag (Name) @_name)
    (content (CDSect (CData) @injection.content) )
    (#any-of? @_name "select" "insert" "update" "delete" "sql"))
  (#set! injection.language "sql")
)
