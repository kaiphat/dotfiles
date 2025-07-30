; typescript
(
 (template_string (string_fragment) @injection.content)
 (#match? @injection.content "^.*FROM|ALTER|SELECT|CREATE|UPDATE|DELETE|INSERT|WITH.*$")
 (#set! injection.language "sql")
 )

(
 (template_string (string_fragment) @injection.content)
 (#match? @injection.content "local|redis")
 (#set! injection.language "lua")
)

(
 (comment) @injection.content
 (#match? @injection.content "^/\\*\\*")
 (#set! injection.language "jsdoc")
)
