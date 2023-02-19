CREATE OR REPLACE FUNCTION keepcoding.clean_integer (int INT64) 
RETURNS INT64 AS ((SELECT IF (int IS NULL, -999999, int)));