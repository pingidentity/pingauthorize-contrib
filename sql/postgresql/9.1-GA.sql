-- *********************************************************************
-- Update Database Script
-- *********************************************************************
-- Change Log: META-INF/resourcesPrivate/com.symphonicsoft.db.cli/liquibase/symphonic-changelog.xml
-- Liquibase version: 3.10.2
-- *********************************************************************

SET SEARCH_PATH TO public;

-- Lock Database
UPDATE public.databasechangeloglock SET LOCKED = TRUE, LOCKEDBY = '127.0.0.1 (127.0.0.1)', LOCKGRANTED = '2022-06-27 15:27:43.321' WHERE ID = 1 AND LOCKED = FALSE;

SET SEARCH_PATH TO public;

SET SEARCH_PATH TO public;

-- Changeset META-INF/resourcesPrivate/com.symphonicsoft.db.cli/liquibase/9.1-GA/changelog.xml::1::symphonic
SET SEARCH_PATH TO public;

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('1', 'symphonic', 'META-INF/resourcesPrivate/com.symphonicsoft.db.cli/liquibase/9.1-GA/changelog.xml', NOW(), 465, '8:2d31a85f5b6d8d1ddaac69d8bf72388c', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.10.2', '6361663323', '9.1-GA');

-- Release Database Lock
SET SEARCH_PATH TO public;

UPDATE public.databasechangeloglock SET LOCKED = FALSE, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;

SET SEARCH_PATH TO public;

-- Grant privileges to user
DO $$
    BEGIN
        IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'pap_user') THEN
            REVOKE ALL ON SCHEMA public FROM PUBLIC;
            GRANT USAGE ON SCHEMA public TO pap_user;
            GRANT SELECT ON ALL TABLES IN SCHEMA public TO pap_user;
            GRANT INSERT ON ALL TABLES IN SCHEMA public TO pap_user;
            GRANT UPDATE ON ALL TABLES IN SCHEMA public TO pap_user;
            GRANT DELETE ON ALL TABLES IN SCHEMA public TO pap_user;
            GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO pap_user;
        END IF;
    END;
$$ LANGUAGE plpgsql;
