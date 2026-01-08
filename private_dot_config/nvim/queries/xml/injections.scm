; extends

(
  (element
    (STag (Name) @_name)
    (content (CharData) @injection.content)
    (#any-of? @_name "select" "insert" "update" "delete" "sql"))
  (#set! injection.language "sql")
)
