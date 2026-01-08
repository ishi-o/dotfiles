; extends

(
  (object_reference
    name: (identifier) @type.sql
  )
  (#has-ancestor? @type.sql ERROR)
  (#set! "priority" 200)
)

(
  (identifier) @variable.member.sql
  (#has-ancestor? @variable.member.sql ERROR)
)

(
  (keyword_name) @variable.member.sql
  (#has-ancestor? @variable.member.sql ERROR)
)
