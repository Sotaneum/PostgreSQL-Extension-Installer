CREATE OR REPLACE FUNCTION m_installer_install()
    RETURNS Boolean
    LANGUAGE 'plpython3u'

    COST 100
    VOLATILE
AS $BODY$
    # -- ==========================================================
    # --    Installer

    # --    Copyright 2019 LEE DONG GUN(2019.12.22)
    # -- ==========================================================

    from postgresql_extension_installer import Installer

    installer = Installer(plpy, 'https://raw.githubusercontent.com/Sotaneum/PostgreSQL-Extension-Installer/alpha/tests/test.query')
    installer.install()
    print("Success")
$BODY$;

ALTER FUNCTION m_installer_install();

SELECT m_installer_install();

SELECT m_installer_update();

SELECT m_installer_pylib_update();

SELECT m_installer_delete_cache();