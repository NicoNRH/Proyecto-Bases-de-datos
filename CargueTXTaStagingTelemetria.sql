-- CargueTXTaStagingTelemetria.sql
-- editar 4 lineas antes de correr script en pgAdmin

DO $$
DECLARE
    v_jugador      TEXT := 'Nicolas';                          
    v_mapa         TEXT := 'E1M1';                             
    v_episodio     TEXT := '1';                                
    v_ruta         TEXT := 'C:/LogsTelemetria/nicolas1.txt';   

    v_sesion_id    INTEGER;
    v_mapa_id      INTEGER;
BEGIN

    
    -- PASO 1: Limpiar staging
    TRUNCATE TABLE staging_telemetria;
    RAISE NOTICE 'Staging limpiado.';

    -- PASO 2: Obtener mapa_id
 
    SELECT mapa_id INTO v_mapa_id
    FROM mapas WHERE codigo_mapa = v_mapa;

    IF v_mapa_id IS NULL THEN
        RAISE EXCEPTION 'Mapa % no encontrado en la tabla mapas.', v_mapa;
    END IF;


    -- PASO 3: Crear sesion con siguiente ID automatico

    v_sesion_id := COALESCE((SELECT MAX(sesion_id) FROM sesiones_juego), 0) + 1;

    INSERT INTO sesiones_juego (sesion_id, modo_juego, dificultad, iniciado_en, terminado_en, mapasmapa_id)
    VALUES (v_sesion_id, 'single', 'medium', NOW(), NOW() + INTERVAL '30 minutes', v_mapa_id);

    RAISE NOTICE 'Sesion % creada para mapa %.', v_sesion_id, v_mapa;

    -- PASO 4: Cargar TXT a tabla temporal

    CREATE TEMP TABLE tmp_tel (
        raw_timestamp_ms   TEXT,
        raw_numero_tic     TEXT,
        raw_pos_x          TEXT,
        raw_pos_y          TEXT,
        raw_pos_z          TEXT,
        raw_angulo_vision  TEXT,
        raw_momentum_dx    TEXT,
        raw_momentum_dy    TEXT,
        raw_armadura       TEXT,
        raw_salud          TEXT,
        raw_municion_balas TEXT,
        raw_sector         TEXT
    ) ON COMMIT DROP;

    EXECUTE format(
        'COPY tmp_tel FROM %L WITH (FORMAT CSV, DELIMITER E''\t'', HEADER TRUE)',
        v_ruta
    );

    RAISE NOTICE 'Archivo cargado a tabla temporal.';

    
    -- PASO 5: Insertar en staging con columnas manuales
    
    INSERT INTO staging_telemetria (
        raw_episodio, raw_mapa, raw_sector, raw_jugador, raw_sesion,
        raw_numero_tic, raw_timestamp_ms, raw_pos_x, raw_pos_y, raw_pos_z,
        raw_angulo_vision, raw_momentum_dx, raw_momentum_dy, raw_velocidad,
        raw_salud, raw_armadura, raw_municion_balas
    )
    SELECT
        v_episodio,
        v_mapa,
        raw_sector,
        v_jugador,
        v_sesion_id::TEXT,
        raw_numero_tic,
        raw_timestamp_ms,
        raw_pos_x,
        raw_pos_y,
        raw_pos_z,
        raw_angulo_vision,
        raw_momentum_dx,
        raw_momentum_dy,
        CASE
            WHEN raw_momentum_dx ~ '^-?[0-9]+(\.[0-9]+)?$'
             AND raw_momentum_dy ~ '^-?[0-9]+(\.[0-9]+)?$'
            THEN CAST(
                SQRT(POWER(raw_momentum_dx::FLOAT, 2) + POWER(raw_momentum_dy::FLOAT, 2))
                AS TEXT)
            ELSE '0'
        END,
        raw_salud,
        raw_armadura,
        raw_municion_balas
    FROM tmp_tel;

    RAISE NOTICE 'Datos insertados en staging.';

END $$;

-- PASO 6: Verificacion — cuantas filas cargaron

SELECT
    COUNT(*)                                AS total_filas,
    COUNT(*) FILTER (WHERE error_flag)      AS filas_con_error,
    MIN(raw_numero_tic::INTEGER)            AS tic_minimo,
    MAX(raw_numero_tic::INTEGER)            AS tic_maximo,
    MAX(raw_sesion::INTEGER)                AS sesion_asignada
FROM staging_telemetria;
