BEGIN;

UPDATE staging_telemetria
SET 
    error_flag = TRUE,
    error_detalle = CONCAT_WS(
        '; ',
        error_detalle,
        CASE 
            WHEN raw_mapa IS NULL OR TRIM(raw_mapa) = '' 
            THEN 'raw_mapa vacío: no se puede relacionar con mapas'
        END,
        CASE 
            WHEN raw_sector IS NULL OR TRIM(raw_sector) = '' 
            THEN 'raw_sector vacío: no se puede relacionar con sectores'
        END,
        CASE 
            WHEN raw_jugador IS NULL OR TRIM(raw_jugador) = '' 
            THEN 'raw_jugador vacío: no se puede relacionar con jugadores'
        END,
        CASE 
            WHEN raw_sesion IS NULL OR TRIM(raw_sesion) = '' 
            THEN 'raw_sesion vacío: no se puede relacionar con sesiones_juego'
        END,
        CASE 
            WHEN raw_numero_tic IS NULL OR TRIM(raw_numero_tic) = '' 
            THEN 'raw_numero_tic vacío: no se puede crear tic'
        END,
        CASE 
            WHEN raw_numero_tic IS NOT NULL 
             AND TRIM(raw_numero_tic) <> ''
             AND raw_numero_tic !~ '^[0-9]+$'
            THEN 'raw_numero_tic no es entero'
        END
    )
WHERE
       raw_mapa IS NULL OR TRIM(raw_mapa) = ''
    OR raw_sector IS NULL OR TRIM(raw_sector) = ''
    OR raw_jugador IS NULL OR TRIM(raw_jugador) = ''
    OR raw_sesion IS NULL OR TRIM(raw_sesion) = ''
    OR raw_numero_tic IS NULL OR TRIM(raw_numero_tic) = ''
    OR raw_numero_tic !~ '^[0-9]+$';


WITH tics_nuevos AS (
    SELECT DISTINCT
        s.raw_numero_tic::INTEGER AS numero_tic,

        CASE 
            WHEN s.raw_timestamp_ms ~ '^[0-9]+$' 
            THEN s.raw_timestamp_ms::INTEGER
            ELSE 0
        END AS timestamp_ms,

        sj.sesion_id

    FROM staging_telemetria s

    INNER JOIN mapas m
        ON m.codigo_mapa = TRIM(s.raw_mapa)

    INNER JOIN sesiones_juego sj
        ON sj.modo_juego = TRIM(s.raw_sesion)
       AND sj.mapasmapa_id = m.mapa_id

    WHERE s.error_flag = FALSE

      AND NOT EXISTS (
          SELECT 1
          FROM tic t
          WHERE t.numero_tic = s.raw_numero_tic::INTEGER
            AND t.sesiones_juegosesion_id = sj.sesion_id
      )
),
numerados AS (
    SELECT
        COALESCE((SELECT MAX(tic_id) FROM tic), 0)
        + ROW_NUMBER() OVER (
            ORDER BY sesion_id, numero_tic
        ) AS tic_id,

        numero_tic,
        timestamp_ms,
        sesion_id
    FROM tics_nuevos
)
INSERT INTO tic (
    tic_id,
    numero_tic,
    timestamp_ms,
    sesiones_juegosesion_id
)
SELECT
    tic_id,
    numero_tic,
    timestamp_ms,
    sesion_id
FROM numerados;

WITH eventos_limpios AS (
    SELECT
        CASE 
            WHEN s.raw_momentum_dx ~ '^-?[0-9]+(\.[0-9]+)?$' 
            THEN s.raw_momentum_dx::FLOAT 
            ELSE 0 
        END AS momentum_dx,

        CASE 
            WHEN s.raw_pos_x ~ '^-?[0-9]+(\.[0-9]+)?$' 
            THEN s.raw_pos_x::FLOAT 
            ELSE 0 
        END AS pos_x,

        CASE 
            WHEN s.raw_pos_y ~ '^-?[0-9]+(\.[0-9]+)?$' 
            THEN s.raw_pos_y::FLOAT 
            ELSE 0 
        END AS pos_y,

        CASE 
            WHEN s.raw_angulo_vision ~ '^-?[0-9]+(\.[0-9]+)?$' 
            THEN s.raw_angulo_vision::FLOAT 
            ELSE 0 
        END AS angulo_vision,

        CASE 
            WHEN s.raw_momentum_dy ~ '^-?[0-9]+(\.[0-9]+)?$' 
            THEN s.raw_momentum_dy::FLOAT 
            ELSE 0 
        END AS momentum_dy,

        CASE 
            WHEN s.raw_velocidad ~ '^-?[0-9]+(\.[0-9]+)?$' 
            THEN s.raw_velocidad::FLOAT
            ELSE 0
        END AS velocidad_momentum,

        CASE 
            WHEN s.raw_salud ~ '^[0-9]+$' 
            THEN s.raw_salud::INTEGER 
            ELSE 0 
        END AS salud,

        CASE 
            WHEN s.raw_armadura ~ '^[0-9]+$' 
            THEN s.raw_armadura::INTEGER 
            ELSE 0 
        END AS armadura,

        CASE 
            WHEN s.raw_municion_balas ~ '^[0-9]+$' 
            THEN s.raw_municion_balas::INTEGER 
            ELSE 0 
        END AS municion_balas,

        sec.sector_id,
        j.jugador_id,
        t.tic_id

    FROM staging_telemetria s

    INNER JOIN mapas m
        ON m.codigo_mapa = TRIM(s.raw_mapa)

    INNER JOIN sectores sec
        ON sec.nombre_sector = TRIM(s.raw_sector)
       AND sec.mapasmapa_id = m.mapa_id

    INNER JOIN jugadores j
        ON j.alias = TRIM(s.raw_jugador)

    INNER JOIN sesiones_juego sj
        ON sj.modo_juego = TRIM(s.raw_sesion)
       AND sj.mapasmapa_id = m.mapa_id

    INNER JOIN tic t
        ON t.numero_tic = s.raw_numero_tic::INTEGER
       AND t.sesiones_juegosesion_id = sj.sesion_id

    WHERE s.error_flag = FALSE
),
numerados AS (
    SELECT
        COALESCE((SELECT MAX(evento_id) FROM eventos_telemetria), 0)
        + ROW_NUMBER() OVER (
            ORDER BY jugador_id, tic_id, sector_id
        ) AS evento_id,

        momentum_dx,
        pos_x,
        pos_y,
        angulo_vision,
        momentum_dy,
        velocidad_momentum,
        salud,
        armadura,
        municion_balas,
        sector_id,
        jugador_id,
        tic_id
    FROM eventos_limpios
)
INSERT INTO eventos_telemetria (
    evento_id,
    momentum_dx,
    pos_x,
    pos_y,
    angulo_vision,
    momentum_dy,
    velocidad_momentum,
    salud,
    armadura,
    municion_balas,
    sectoressector_id,
    jugadoresjugador_id,
    tictic_id
)
SELECT
    evento_id,
    momentum_dx,
    pos_x,
    pos_y,
    angulo_vision,
    momentum_dy,
    velocidad_momentum,
    salud,
    armadura,
    municion_balas,
    sector_id,
    jugador_id,
    tic_id
FROM numerados;

WITH sectores_nuevos AS (
    SELECT
        TRIM(s.raw_sector) AS nombre_sector,
        m.mapa_id,

        MIN(
            CASE 
                WHEN s.raw_pos_x ~ '^-?[0-9]+(\.[0-9]+)?$' 
                THEN s.raw_pos_x::FLOAT 
                ELSE 0 
            END
        ) AS bbox_x_min,

        MAX(
            CASE 
                WHEN s.raw_pos_x ~ '^-?[0-9]+(\.[0-9]+)?$' 
                THEN s.raw_pos_x::FLOAT 
                ELSE 0 
            END
        ) AS bbox_x_max,

        MIN(
            CASE 
                WHEN s.raw_pos_y ~ '^-?[0-9]+(\.[0-9]+)?$' 
                THEN s.raw_pos_y::FLOAT 
                ELSE 0 
            END
        ) AS bbox_y_min,

        MAX(
            CASE 
                WHEN s.raw_pos_y ~ '^-?[0-9]+(\.[0-9]+)?$' 
                THEN s.raw_pos_y::FLOAT 
                ELSE 0 
            END
        ) AS bbox_y_max

    FROM staging_telemetria s
    INNER JOIN mapas m
        ON m.codigo_mapa = TRIM(s.raw_mapa)

    WHERE s.error_flag = FALSE

    GROUP BY
        TRIM(s.raw_sector),
        m.mapa_id

    HAVING NOT EXISTS (
        SELECT 1
        FROM sectores sec
        WHERE sec.nombre_sector = TRIM(s.raw_sector)
          AND sec.mapasmapa_id = m.mapa_id
    )
),
numerados AS (
    SELECT
        COALESCE((SELECT MAX(sector_id) FROM sectores), 0)
        + ROW_NUMBER() OVER (ORDER BY nombre_sector, mapa_id) AS sector_id,

        nombre_sector,

        CASE 
            WHEN bbox_x_min = bbox_x_max THEN bbox_x_min - 0.5 
            ELSE bbox_x_min 
        END AS bbox_x_min,

        CASE 
            WHEN bbox_x_min = bbox_x_max THEN bbox_x_max + 0.5 
            ELSE bbox_x_max 
        END AS bbox_x_max,

        CASE 
            WHEN bbox_y_min = bbox_y_max THEN bbox_y_min - 0.5 
            ELSE bbox_y_min 
        END AS bbox_y_min,

        CASE 
            WHEN bbox_y_min = bbox_y_max THEN bbox_y_max + 0.5 
            ELSE bbox_y_max 
        END AS bbox_y_max,

        mapa_id
    FROM sectores_nuevos
)
INSERT INTO sectores (
    sector_id,
    nombre_sector,
    bbox_x_min,
    bbox_x_max,
    bbox_y_min,
    bbox_y_max,
    mapasmapa_id
)
SELECT
    sector_id,
    nombre_sector,
    bbox_x_min,
    bbox_x_max,
    bbox_y_min,
    bbox_y_max,
    mapa_id
FROM numerados;

COMMIT;