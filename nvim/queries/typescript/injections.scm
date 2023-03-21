(call_expression
  (call_expression
    (member_expression
      property: (property_identifier) @_property (#eq? @_property "query")
    )
  )
  (template_string) @sql
  (#offset! @sql 0 1 0 -1)
)

(call_expression
  (call_expression
    (await_expression
      (member_expression
        property: (property_identifier) @_property (#eq? @_property "query")
      )
    )
  )
  (template_string) @sql
  (#offset! @sql 0 1 0 -1)
)

(call_expression
  (await_expression
    (member_expression
      property: (property_identifier) @_property (#eq? @_property "query")
    )
  )
  (arguments
    (template_string) @sql
    (#offset! @sql 0 1 0 -1)
  )
)

(call_expression
  (member_expression
    property: (property_identifier) @_property (#eq? @_property "query")
  )
  (arguments
    (template_string) @sql
    (#offset! @sql 0 1 0 -1)
  )
)
