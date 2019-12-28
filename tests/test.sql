CREATE OR REPLACE FUNCTION m_installer_setup()
    RETURNS TEXT
    LANGUAGE 'plpython3u'

    COST 100
    VOLATILE
AS $BODY$
    # -- ==========================================================
    # --    Installer

    # --    Copyright 2019 LEE DONG GUN(2019.12.28)
    # -- ==========================================================

    from postgresql_extension_installer import Installer

    installer = Installer(plpy)
    return "ok"
$BODY$;
SELECT m_installer_setup();
select m_installer_update('me.faena.postgresql_extension_installer');
select m_installer_uninstall('me.faena.postgresql_extension_installer');
select m_installer_pylib_update('me.faena.postgresql_extension_installer');
select m_installer_delete_cache();
select m_installer_install('https://raw.githubusercontent.com/Sotaneum/PostgreSQL-Extension-Installer/beta/tests/test.query')