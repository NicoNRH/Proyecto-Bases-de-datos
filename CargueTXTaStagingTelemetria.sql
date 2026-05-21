-- Truncar la tabla si es una recarga completa, o omitir si es incremental
TRUNCATE TABLE staging_telemetria;

-- Comando COPY para importar el CSV a PostgreSQL
COPY staging_telemetria (
    raw_episodio, raw_mapa, raw_sector, raw_jugador, raw_sesion, raw_numero_tic, raw_timestamp_ms, raw_pos_x, raw_pos_y, 
    raw_pos_z, raw_angulo_vision, raw_momentum_dx, raw_momentum_dy, 
    raw_velocidad, raw_salud, raw_armadura, raw_municion_balas
) 
FROM 'C:/LogsTelemetria/nicolas2.csv' 
WITH (FORMAT CSV, DELIMITER ',');