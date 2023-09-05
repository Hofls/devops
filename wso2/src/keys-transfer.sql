SET REFERENTIAL_INTEGRITY FALSE;

UPDATE idn_oidc_property
SET consumer_key = 'tXVHcsZe9qI7777I997hGO_fQGUa'
WHERE consumer_key = 'QTzioDUi7777i3AEOxeTfcFrxVYa';

UPDATE idn_oauth_consumer_apps
SET consumer_key = 'tXVHcsZe9qI7777I997hGO_fQGUa',
    consumer_secret = 'PgJge6N7777YZh0J8Qb8ICxLx70a'
WHERE consumer_key = 'QTzioDUi7777i3AEOxeTfcFrxVYa';

SET REFERENTIAL_INTEGRITY TRUE;

UPDATE am_application_key_mapping
SET consumer_key = 'tXVHcsZe9qI7777I997hGO_fQGUa'
WHERE consumer_key = 'QTzioDUi7777i3AEOxeTfcFrxVYa';

UPDATE sp_inbound_auth
SET inbound_auth_key = 'tXVHcsZe9qI7777I997hGO_fQGUa'
WHERE inbound_auth_key = 'QTzioDUi7777i3AEOxeTfcFrxVYa';

UPDATE idn_oauth2_access_token
SET access_token = '20708561-31ab-7777-bb72-559e9923f774'
WHERE access_token = '01ddfa16-c365-7777-8d02-0431456e9558';
