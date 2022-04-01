-- *********************************************************************
-- Update Database Script
-- *********************************************************************
-- Change Log: META-INF/resourcesPrivate/com.symphonicsoft.db.cli/liquibase/symphonic-changelog.xml
-- Liquibase version: 3.10.2
-- *********************************************************************

SET SEARCH_PATH TO public;

-- Lock Database
UPDATE public.databasechangeloglock SET LOCKED = TRUE, LOCKEDBY = '127.0.0.1 (127.0.0.1)', LOCKGRANTED = '2022-03-31 15:53:38.583' WHERE ID = 1 AND LOCKED = FALSE;

SET SEARCH_PATH TO public;

SET SEARCH_PATH TO public;

-- Changeset META-INF/resourcesPrivate/com.symphonicsoft.db.cli/liquibase/9.1-EA/add-effect-condition-column-to-rule2-table.xml::1::symphonic
SET SEARCH_PATH TO public;

ALTER TABLE public."Rule2" ADD effect_condition TEXT;

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('1', 'symphonic', 'META-INF/resourcesPrivate/com.symphonicsoft.db.cli/liquibase/9.1-EA/add-effect-condition-column-to-rule2-table.xml', NOW(), 463, '8:84a770cf1e5bf6c1499a8f6d207438c1', 'addColumn tableName=Rule2', '', 'EXECUTED', NULL, NULL, '3.10.2', '8756418584');

-- Changeset META-INF/resourcesPrivate/com.symphonicsoft.db.cli/liquibase/9.1-EA/changelog.xml::1::symphonic
SET SEARCH_PATH TO public;

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('1', 'symphonic', 'META-INF/resourcesPrivate/com.symphonicsoft.db.cli/liquibase/9.1-EA/changelog.xml', NOW(), 464, '8:06e1811734a7b49bb617ce6d2940e00c', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.10.2', '8756418584', '9.1-EA');

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
