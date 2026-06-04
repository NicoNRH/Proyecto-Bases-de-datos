@echo off
::
:: setup_database.bat
:: Recrea el schema de la BD university y carga los datos
:: 
:: USO: Doble clic o correr desde CMD
:: REQUISITO: PostgreSQL instalado y en el PATH
::

SET PGHOST=localhost
SET PGPORT=5432
SET PGUSER=postgres
SET PGDATABASE=university

:: Pedir contrasena
SET /P PGPASSWORD=Ingresa la contrasena de PostgreSQL: 
SET PGPASSWORD=%PGPASSWORD%

echo.
echo =============================================
echo  Iniciando configuracion de la base de datos
echo =============================================
echo.


:: PASO 1: Recrear tablas (DDL)

echo [1/5] Creando tablas...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "DDLdoomchocolate.sql"
IF %ERRORLEVEL% NEQ 0 (
    echo ERROR: Fallo al crear las tablas.
    pause
    exit /b 1
)
echo Tablas creadas correctamente.
echo.


:: PASO 2: Cargar usuarios, jugadores, episodios, mapas, sesiones

echo [2/5] Cargando usuarios, jugadores, episodios y mapas...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "usuarios_y_respuestas.sql"
IF %ERRORLEVEL% NEQ 0 (
    echo ERROR: Fallo al cargar usuarios y respuestas.
    pause
    exit /b 1
)
echo Usuarios y respuestas cargados correctamente.
echo.


:: PASO 3: Crear tabla staging

echo [3/5] Creando tabla staging...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -c "CREATE TABLE IF NOT EXISTS staging_telemetria (raw_episodio TEXT, raw_mapa TEXT, raw_sector TEXT, raw_jugador TEXT, raw_sesion TEXT, raw_numero_tic TEXT, raw_timestamp_ms TEXT, raw_pos_x TEXT, raw_pos_y TEXT, raw_pos_z TEXT, raw_angulo_vision TEXT, raw_momentum_dx TEXT, raw_momentum_dy TEXT, raw_velocidad TEXT, raw_salud TEXT, raw_armadura TEXT, raw_municion_balas TEXT, cargado_en TIMESTAMP DEFAULT NOW(), error_flag BOOLEAN DEFAULT FALSE, error_detalle TEXT);"
echo Staging creado correctamente.
echo.


:: PASO 4: Cargar telemetria de cada jugador

echo [4/5] Cargando telemetria...
echo Nota: Edita las variables en CargueTXTaStagingTelemetria.sql
echo para cada archivo y luego corre InsertarDatosTelemetria.sql
echo.
echo Archivos a cargar:
echo   - nicolas_clean.txt    ^(E1M1, Episodio 1^)
echo   - Davidg_clean.txt     ^(E1M5, Episodio 1^)
echo   - gaby.12_clean.txt    ^(E1M5, Episodio 1^)
echo   - Juanes_clean.txt     ^(E3M1, Episodio 3^)
echo   - Juan_clean.txt       ^(E4M1, Episodio 4^)
echo   - Lindsay_clean.txt    ^(E1M5, Episodio 1^)
echo.


:: PASO 5: Verificacion final

echo [5/5] Verificando datos cargados...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -c "SELECT 'episodios' AS tabla, COUNT(*) AS filas FROM episodios UNION ALL SELECT 'mapas', COUNT(*) FROM mapas UNION ALL SELECT 'usuarios', COUNT(*) FROM usuarios UNION ALL SELECT 'jugadores', COUNT(*) FROM jugadores UNION ALL SELECT 'sesiones_juego', COUNT(*) FROM sesiones_juego UNION ALL SELECT 'sectores', COUNT(*) FROM sectores UNION ALL SELECT 'tic', COUNT(*) FROM tic UNION ALL SELECT 'eventos_telemetria', COUNT(*) FROM eventos_telemetria UNION ALL SELECT 'respuestas_ux', COUNT(*) FROM respuestas_ux;"

echo.
echo =============================================
echo  Setup completado exitosamente
echo =============================================
echo.
pause
