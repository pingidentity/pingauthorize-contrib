-- *********************************************************************
-- Update to '8.2' Database Script
-- *********************************************************************
-- Change Log: META-INF/resourcesPrivate/com.symphonicsoft.db.cli/liquibase/symphonic-changelog.xml
-- Ran at: 7/20/21 9:57 AM
-- Against: papadmin@jdbc:postgresql://localhost:5432/pap?allowEncodingChanges=false&ApplicationName=PostgreSQL+JDBC+Driver&autosave=never&binaryTransfer=true&binaryTransferDisable=&binaryTransferEnable=&cancelSignalTimeout=10&cleanupSavepoints=false&connectTimeout=10&databaseMetadataCacheFields=65536&databaseMetadataCacheFieldsMiB=5&defaultRowFetchSize=0&disableColumnSanitiser=false&escapeSyntaxCallMode=select&gsslib=auto&hideUnprivilegedObjects=false&hostRecheckSeconds=10&jaasLogin=true&loadBalanceHosts=false&loginTimeout=0&logServerErrorDetail=true&logUnclosedConnections=false&preferQueryMode=extended&preparedStatementCacheQueries=256&preparedStatementCacheSizeMiB=5&prepareThreshold=5&readOnly=false&readOnlyMode=transaction&receiveBufferSize=-1&reWriteBatchedInserts=false&sendBufferSize=-1&socketTimeout=0&sspiServiceClass=POSTGRES&targetServerType=any&tcpKeepAlive=false&unknownLength=2147483647&useSpnego=false&xmlFactoryFactory=
-- Liquibase version: 3.10.2
-- *********************************************************************

SET SEARCH_PATH TO public;

-- Lock Database
UPDATE public.databasechangeloglock SET LOCKED = TRUE, LOCKEDBY = '172.16.252.128 (172.16.252.128)', LOCKGRANTED = '2021-07-20 09:57:24.468' WHERE ID = 1 AND LOCKED = FALSE;

SET SEARCH_PATH TO public;

SET SEARCH_PATH TO public;

-- Changeset META-INF/resourcesPrivate/com.symphonicsoft.db.cli/liquibase/8.2/modify-definition-table-parentId.xml::1::symphonic
SET SEARCH_PATH TO public;

ALTER TABLE public."Definition" ALTER COLUMN "parentId" TYPE VARCHAR(36) USING ("parentId"::VARCHAR(36));

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('1', 'symphonic', 'META-INF/resourcesPrivate/com.symphonicsoft.db.cli/liquibase/8.2/modify-definition-table-parentId.xml', NOW(), 165, '8:f4aa8c74420c3a2746eda3e8a835385f', 'modifyDataType columnName=parentId, tableName=Definition', '', 'EXECUTED', NULL, NULL, '3.10.2', NULL);

-- Changeset META-INF/resourcesPrivate/com.symphonicsoft.db.cli/liquibase/8.2/changelog.xml::1::symphonic
SET SEARCH_PATH TO public;

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('1', 'symphonic', 'META-INF/resourcesPrivate/com.symphonicsoft.db.cli/liquibase/8.2/changelog.xml', NOW(), 166, '8:c646a30b05282749a451e0cd02d86276', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.10.2', NULL, '8.2');

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
