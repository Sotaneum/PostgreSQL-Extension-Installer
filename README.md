
# Get Started with `Postgresql Extension Installer`

## Getting Started

- Use our step-by-step guide to get started with `Postgresql Extension Installer` in minutes.

### 1. Download Python

- Get started with Python to use everything in the `Postgresql Extension Installer`. We recommend using the 3.6 version.

- [`Download Python`](https://www.python.org/downloads/)

### 2. Get the command line tool

```bash
pip install postgresql-extension-installer
```

### 3. Download PostgreSQL

- Get started with PostgreSQL to use everything in the `Postgresql Extension Installer`. We recommend using the latest version.

### 4. Enabling Contrib

```SQL
-- Must be python3u
CREATE EXTENSION python3u;
```

### 5. Enabling PostgreSQL Extension Installer

```SQL
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
```

## Documentation

### API Reference

#### .Query Format

- It is similar to XML.

##### Info

```SQL
-->Info<--
--<Name>--
    -- INSERT UNIQUE NAME HERE (e.q com.example.packagename)
--<Version>--
    -- INSERT VERSION HERE
--<Provider>--
    -- INSERT PROVIDER HERE
--<lib>--
    -- INSERT PYTHON LIBRARY HERE
```

- Example

    ```SQL
    -->Info<--
    --<Name>--
    me.faena.postgresql_extension_installer
    --<Version>--
    2019.12.22.1010
    --<Provider>--
    https://raw.githubusercontent.com/Sotaneum/PostgreSQL-Extension-Installer/master/tests/test.query
    https://raw.githubusercontent.com/Sotaneum/PostgreSQL-Extension-Installer/alpha/tests/test.query
    --<lib>--
    postgresql_deepgeo
    ```

##### Table

```SQL
-->Table<--
--<TABLE_NAME>--
CREATE TABLE TABLE_NAME(
   -- INSERT HERE COLUMN
);
```

- Example

    ```SQL
    -->Table<--
    --<sql_list>--
    CREATE TABLE sql_list(
        sql json
    );
    ```

  - 2 or more

    ```SQL
    -->Table<--
    --<sql_list>--
    CREATE TABLE sql_list(
        sql json
    );
    --<log_list>--
    CREATE TABLE log_list(
        log text
    );
    ```

##### Function

```SQL
-->Function<--
--<FUNCTION_NAME>--
CREATE OR REPLACE FUNCTION FUNCTION_NAME()
    -- INSERT HERE FUNCTION
```

- Example

    ```SQL
    -->Function<--
    --<print_info>--
    CREATE OR REPLACE FUNCTION print_info()
        RETURNS TEXT
        LANGUAGE 'plpython3u'

        COST 100
        VOLATILE
    AS $BODY$
        # -- ==========================================================
        # --    Installer

        # --    Copyright 2019 LEE DONG GUN(2019.12.22)
        # -- ==========================================================

        return 'TEST'

    $BODY$;
    ```

  - 2 or more

    ```SQL
    -->Function<--
    --<print_info>--
    CREATE OR REPLACE FUNCTION print_info()
        RETURNS TEXT
        LANGUAGE 'plpython3u'

        COST 100
        VOLATILE
    AS $BODY$
        # -- ==========================================================
        # --    Installer

        # --    Copyright 2019 LEE DONG GUN(2019.12.22)
        # -- ==========================================================

        return 'TEST'

    $BODY$;
    --<create_table>--
    CREATE OR REPLACE FUNCTION create_table(
        character varying
        )
        RETURNS text
        LANGUAGE 'plpgsql'

        COST 100
        VOLATILE STRICT 
    AS $BODY$
    DECLARE        
        f_table_name 	alias for $1;

        model_name_str	text;
    BEGIN
        sql := 'CREATE TABLE ' || f_table_name || '(log TEXT);';
        EXECUTE sql INTO model_name_str;
        RETURN
            quote_literal(model_name_str);
    END;
    $BODY$;
    COMMENT ON FUNCTION create_table(character varying)
        IS 'args: table_name';
    ```

##### Type

```SQL
-->Type<--
--<TYPE_NAME>--
CREATE TYPE TYPE_NAME AS
(
    -- INSERT HERE COLUMN
);
```

- Example

    ```SQL
    -->Type<--
    --<point>--
    CREATE TYPE point AS
    (
        x int,
        y int
    );
    ```

  - 2 or more

    ```SQL
    -->Type<--
    --<point>--
    CREATE TYPE point AS
    (
        x int,
        y int
    );
    --<mpoint>--
    CREATE TYPE mpoint AS
    (
        point point[]
    );
    ```

##### Other

- Other SQL usage is possible if supported by PostgreSQL.

#### Support Functions

##### Install

- Example

    ```SQL
    SELECT m_installer_install("https://raw.githubusercontent.com/Sotaneum/PostgreSQL-Extension-Installer/beta/postgresql_extension_installer/default.py")
    ```

##### Update

- Will try to reinstall base on the installed information.

- Example

    ```SQL
    SELECT m_installer_update("me.faena.postgresql_extension_installer");
    ```

##### Uninsall

- Will try to uninstall base on the installed information.

- Example

    ```SQL
    SELECT m_installer_uninstall("me.faena.postgresql_extension_installer");
    ```

##### Python Library Install(Update)

- Will try to Install about Python Library based on the installed information.

- Example

    ```SQL
    SELECT m_installer_pylib_update("me.faena.postgresql_extension_installer");
    ```

##### Remove Cache

- Try delete the space used for the installation.

- Example

    ```SQL
    SELECT m_installer_delete_cache();
    ```

## Log

- 2019.12.29.0014
  - Bug fix
    - update
    - insert
    - delete
- 2019.12.28.1256
  - create
    - loader
      - from db, file, default
    - pyhon_package
      - install python lib
    - query
    - util
- 2019.12.22.1618
  - defualt format modify
  - Provider Bug fix
- 2019.12.22.0216
  - Python library Install
    - Bug fix

## Copyright

- Copyright (C) 2019 LEE DONG GUN. (gnyontu39@gmail.com) and contributors
