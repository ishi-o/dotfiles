;; extends

(
  (annotation
    name: (identifier) @annotation_name
    arguments: (annotation_argument_list
      (string_literal
        (multiline_string_fragment) @injection.content)))
  (#any-of? @annotation_name "Select" "Query" "Insert" "Update" "Delete")
  (#set! injection.language "sql")
)

(
  (annotation
    name: (identifier) @annotation_name
    arguments: (annotation_argument_list
      (string_literal
        (string_fragment) @injection.content)))
  (#any-of? @annotation_name "Select" "Query" "Insert" "Update" "Delete")
  (#set! injection.language "sql")
)

