# GraphingSQL
Leveraging SQL with Graph DB Methods

### Proposed Layout:

SSMS (main machine)
  └─ SQL query → sys.sql_expression_dependencies
       └─ Python extraction script → nodes.csv + edges.csv
            └─ Copy to Remote Desktop
                 └─ WSL + Docker → Neo4j container
                      └─ Cypher LOAD CSV → graph
                           └─ Browse at localhost:[insert # here] in browser
