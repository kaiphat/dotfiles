; typescript
(
 (template_string) @sql
 (#match? @sql "^.*FROM|ALTER|SELECT|CREATE|UPDATE|DELETE|INSERT|WITH.*$")
 (#offset! @sql 0 1 0 -1)
 )
