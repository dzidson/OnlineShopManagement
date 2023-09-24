-- Database: Online Shop Management

-- DROP DATABASE IF EXISTS "Online Shop Management";

CREATE DATABASE "Online Shop Management"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Polish_Poland.1250'
    LC_CTYPE = 'Polish_Poland.1250'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

COMMENT ON DATABASE "Online Shop Management"
    IS 'Database Management System Project: Online Shop Management';