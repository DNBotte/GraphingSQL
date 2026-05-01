-- EXPORT DEPENDENCIES FROM SQL SERVER
;
CREATE OR ALTER VIEW ViewDependencies AS
SELECT
    OBJECT_SCHEMA_NAME(o.object_id) AS source_schema,
    o.name AS source_name,
    o.type_desc AS source_type,
    COALESCE(ref.referenced_schema_name, 'dbo') AS target_schema,
    ref.referenced_entity_name AS target_name,
    COALESCE(t.type_desc, v2.type_desc, 'UNKNOWN') AS target_type
FROM sys.objects o
JOIN sys.sql_expression_dependencies ref
    ON o.object_id = ref.referencing_id
LEFT JOIN sys.objects t
    ON t.name = ref.referenced_entity_name
    AND OBJECT_SCHEMA_NAME(t.object_id) = COALESCE(ref.referenced_schema_name, 'dbo')
LEFT JOIN sys.views v2
    ON v2.name = ref.referenced_entity_name
WHERE
    o.type IN ('V')
    AND ref.referenced_class = 1
/*

ORDER BY 
  source_schema, 
  source_name
*/
;
