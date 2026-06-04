-- DDLdoomchocolate.sql

-- TABLA: episodios

CREATE TABLE episodios (
    episodio_id      INTEGER      NOT NULL,
    numero_episodio  INTEGER      NOT NULL,
    nombre_episodio  VARCHAR(100) NOT NULL,

    CONSTRAINT pk_episodios PRIMARY KEY (episodio_id)
);

-- TABLA: mapas
CREATE TABLE mapas (
    mapa_id              INTEGER      NOT NULL,
    codigo_mapa          VARCHAR(10)  NOT NULL,
    nombre_mapa          VARCHAR(100) NOT NULL,
    ancho_unidades       FLOAT        NOT NULL,
    alto_unidades        FLOAT        NOT NULL,
    episodiosepisodio_id INTEGER      NOT NULL,

    CONSTRAINT pk_mapas PRIMARY KEY (mapa_id),
    CONSTRAINT fk_mapas_episodios FOREIGN KEY (episodiosepisodio_id)
        REFERENCES episodios (episodio_id)
);


-- TABLA: sectores

CREATE TABLE sectores (
    sector_id     INTEGER      NOT NULL,
    nombre_sector VARCHAR(50)  NOT NULL,
    bbox_x_min    FLOAT        NOT NULL,
    bbox_x_max    FLOAT        NOT NULL,
    bbox_y_min    FLOAT        NOT NULL,
    bbox_y_max    FLOAT        NOT NULL,
    mapasmapa_id  INTEGER      NOT NULL DEFAULT 1,

    CONSTRAINT pk_sectores PRIMARY KEY (sector_id),
    CONSTRAINT fk_sectores_mapas FOREIGN KEY (mapasmapa_id)
        REFERENCES mapas (mapa_id)
);


-- TABLA: sesiones_juego
CREATE TABLE sesiones_juego (
    sesion_id    INTEGER     NOT NULL,
    modo_juego   VARCHAR(20) NOT NULL,
    dificultad   VARCHAR(20) NOT NULL,
    iniciado_en  TIMESTAMP   NOT NULL,
    terminado_en TIMESTAMP   NOT NULL,
    mapasmapa_id INTEGER     NOT NULL,

    CONSTRAINT pk_sesiones_juego PRIMARY KEY (sesion_id),
    CONSTRAINT fk_sesiones_mapas FOREIGN KEY (mapasmapa_id)
        REFERENCES mapas (mapa_id)
);


-- TABLA: tic

CREATE TABLE tic (
    tic_id                  INTEGER NOT NULL,
    numero_tic              INTEGER NOT NULL,
    timestamp_ms            INTEGER NOT NULL,
    sesiones_juegosesion_id INTEGER NOT NULL,

    CONSTRAINT pk_tic PRIMARY KEY (tic_id),
    CONSTRAINT fk_tic_sesiones FOREIGN KEY (sesiones_juegosesion_id)
        REFERENCES sesiones_juego (sesion_id)
);


-- TABLA: usuarios

CREATE TABLE usuarios (
    user_id                  INTEGER       NOT NULL,
    nombre_usuario           VARCHAR(50)   NOT NULL,
    email                    VARCHAR(100)  NOT NULL,
    edad                     INTEGER       NOT NULL,
    genero                   VARCHAR(20)   NOT NULL,
    nivel_experiencia        VARCHAR(20)   NOT NULL,
    creado_en                TIMESTAMP     NOT NULL,
    esta_activo              BOOLEAN       NOT NULL,
    firma_consentimiento_en  TIMESTAMP     NOT NULL,
    consentimiento           VARCHAR(1000) NOT NULL,

    CONSTRAINT pk_usuarios PRIMARY KEY (user_id)
);

-- -------------------------------------------------------------
-- TABLA: jugadores
-- -------------------------------------------------------------
CREATE TABLE jugadores (
    jugador_id      INTEGER     NOT NULL,
    alias           VARCHAR(50) NOT NULL,
    creado_en       TIMESTAMP   NOT NULL,
    usuariosuser_id INTEGER     NOT NULL,

    CONSTRAINT pk_jugadores PRIMARY KEY (jugador_id),
    CONSTRAINT fk_jugadores_usuarios FOREIGN KEY (usuariosuser_id)
        REFERENCES usuarios (user_id)
);


-- TABLA: instrumentos_ux

CREATE TABLE instrumentos_ux (
    instrumento_id    INTEGER       NOT NULL,
    nombre_instrumento VARCHAR(20)  NOT NULL,
    versionn          VARCHAR(10)   NOT NULL,
    nombre_episodio   VARCHAR(100)  NOT NULL,
    descripcion       VARCHAR(1000) NOT NULL,
    escala_max        INTEGER       NOT NULL,
    escala_min        INTEGER       NOT NULL,
    usuariosuser_id   INTEGER       NOT NULL DEFAULT 1,

    CONSTRAINT pk_instrumentos_ux PRIMARY KEY (instrumento_id),
    CONSTRAINT fk_instrumentos_usuarios FOREIGN KEY (usuariosuser_id)
        REFERENCES usuarios (user_id)
);


-- TABLA: items_ux

CREATE TABLE items_ux (
    item_id                       INTEGER       NOT NULL,
    numero_item                   INTEGER       NOT NULL,
    texto_item                    VARCHAR(1000) NOT NULL,
    dimension                     VARCHAR(50)   NOT NULL,
    puntaje_invertido             BOOLEAN       NOT NULL,
    instrumentos_uxinstrumento_id INTEGER       NOT NULL,

    CONSTRAINT pk_items_ux PRIMARY KEY (item_id),
    CONSTRAINT fk_items_ux_instrumentos FOREIGN KEY (instrumentos_uxinstrumento_id)
        REFERENCES instrumentos_ux (instrumento_id)
);


-- TABLA: respuestas_ux

CREATE TABLE respuestas_ux (
    respuesta_id            INTEGER   NOT NULL,
    respondido_en           TIMESTAMP NOT NULL,
    puntaje_total           FLOAT     NOT NULL,
    usuariosuser_id         INTEGER   NOT NULL,
    sesiones_juegosesion_id INTEGER   NOT NULL,
    items_uxitem_id         INTEGER   NOT NULL,

    CONSTRAINT pk_respuestas_ux PRIMARY KEY (respuesta_id),
    CONSTRAINT fk_respuestas_usuarios FOREIGN KEY (usuariosuser_id)
        REFERENCES usuarios (user_id),
    CONSTRAINT fk_respuestas_sesiones FOREIGN KEY (sesiones_juegosesion_id)
        REFERENCES sesiones_juego (sesion_id),
    CONSTRAINT fk_respuestas_items FOREIGN KEY (items_uxitem_id)
        REFERENCES items_ux (item_id)
);


-- TABLA: eventos_telemetria

CREATE TABLE eventos_telemetria (
    evento_id           INTEGER NOT NULL,
    momentum_dx         FLOAT   NOT NULL,
    pos_x               FLOAT   NOT NULL,
    pos_y               FLOAT   NOT NULL,
    angulo_vision       FLOAT   NOT NULL,
    momentum_dy         FLOAT   NOT NULL,
    velocidad_momentum  FLOAT   NOT NULL,
    salud               INTEGER NOT NULL,
    armadura            INTEGER NOT NULL,
    municion            INTEGER NOT NULL,
    sectoressector_id   INTEGER NOT NULL,
    jugadoresjugador_id INTEGER NOT NULL,
    tictic_id           INTEGER NOT NULL,

    CONSTRAINT pk_eventos_telemetria PRIMARY KEY (evento_id),
    CONSTRAINT fk_eventos_sectores FOREIGN KEY (sectoressector_id)
        REFERENCES sectores (sector_id),
    CONSTRAINT fk_eventos_jugadores FOREIGN KEY (jugadoresjugador_id)
        REFERENCES jugadores (jugador_id),
    CONSTRAINT fk_eventos_tic FOREIGN KEY (tictic_id)
        REFERENCES tic (tic_id)
);


-- TABLA: staging_telemetria

CREATE TABLE staging_telemetria (
    raw_episodio       TEXT,
    raw_mapa           TEXT,
    raw_sector         TEXT,
    raw_jugador        TEXT,
    raw_sesion         TEXT,
    raw_numero_tic     TEXT,
    raw_timestamp_ms   TEXT,
    raw_pos_x          TEXT,
    raw_pos_y          TEXT,
    raw_pos_z          TEXT,
    raw_angulo_vision  TEXT,
    raw_momentum_dx    TEXT,
    raw_momentum_dy    TEXT,
    raw_velocidad      TEXT,
    raw_salud          TEXT,
    raw_armadura       TEXT,
    raw_municion_balas TEXT,
    cargado_en         TIMESTAMP DEFAULT NOW(),
    error_flag         BOOLEAN   DEFAULT FALSE,
    error_detalle      TEXT
);


-- TABLA: registros_auditoria

CREATE TABLE registros_auditoria (
    auditoria_id  INTEGER      NOT NULL,
    accedido_por  VARCHAR(100) NOT NULL,
    nombre_tabla  VARCHAR(100) NOT NULL,
    accion        VARCHAR(50)  NOT NULL,
    accedido_en   TIMESTAMP    NOT NULL DEFAULT NOW(),
    detalles      VARCHAR(1000),

    CONSTRAINT pk_registros_auditoria PRIMARY KEY (auditoria_id)
);


-- DATOS INICIALES: instrumentos_ux (BANGS)

INSERT INTO instrumentos_ux (
    instrumento_id, nombre_instrumento, versionn, nombre_episodio,
    descripcion, escala_max, escala_min, usuariosuser_id)
VALUES (1, 'BANGS', '1.0', 'Todos',
    'Basic Needs in Games Scale. Mide satisfaccion y frustracion de necesidades psicologicas basicas al jugar Chocolate Doom. Escala 1=Totalmente en desacuerdo, 7=Totalmente de acuerdo.',
    7, 1, 1);


-- DATOS INICIALES: items_ux (18 items BANGS)

INSERT INTO items_ux (item_id, numero_item, texto_item, dimension, puntaje_invertido, instrumentos_uxinstrumento_id) VALUES
(1,  1,  'Pude tomar decisiones sobre como jugar Chocolate Doom.',                                        'Autonomy Satisfaction',    FALSE, 1),
(2,  2,  'Pude jugar Chocolate Doom a mi manera.',                                                        'Autonomy Satisfaction',    FALSE, 1),
(3,  3,  'Pude dirigir mi propia experiencia de juego en Chocolate Doom.',                                'Autonomy Satisfaction',    FALSE, 1),
(4,  4,  'Me senti forzado a realizar ciertas acciones en Chocolate Doom.',                               'Autonomy Frustration',     TRUE,  1),
(5,  5,  'Muchas acciones en Chocolate Doom eran aburridas.',                                             'Autonomy Frustration',     TRUE,  1),
(6,  6,  'Con frecuencia deseaba poder hacer algo diferente dentro de Chocolate Doom.',                   'Autonomy Frustration',     TRUE,  1),
(7,  7,  'Senti que estaba mejorando jugando Chocolate Doom.',                                            'Competence Satisfaction',  FALSE, 1),
(8,  8,  'Senti que progrese mientras jugaba Chocolate Doom.',                                            'Competence Satisfaction',  FALSE, 1),
(9,  9,  'Senti un sentido de logro mientras jugaba Chocolate Doom.',                                     'Competence Satisfaction',  FALSE, 1),
(10, 10, 'Con frecuencia senti que me faltaban las habilidades necesarias para Chocolate Doom.',          'Competence Frustration',   TRUE,  1),
(11, 11, 'Segui fallando en lograr lo que queria mientras jugaba Chocolate Doom.',                        'Competence Frustration',   TRUE,  1),
(12, 12, 'Me senti decepcionado con mi desempeno en Chocolate Doom.',                                     'Competence Frustration',   TRUE,  1),
(13, 13, 'Senti que forme relaciones con otros jugadores y/o personajes en Chocolate Doom.',              'Relatedness Satisfaction', FALSE, 1),
(14, 14, 'Al jugar Chocolate Doom, senti una conexion con otros, virtuales o reales.',                    'Relatedness Satisfaction', FALSE, 1),
(15, 15, 'Senti que otros jugadores y/o personajes en Chocolate Doom se preocupaban por mi.',             'Relatedness Satisfaction', FALSE, 1),
(16, 16, 'Las interacciones con otros jugadores y/o personajes en Chocolate Doom me parecieron toxicas.', 'Relatedness Frustration',  TRUE,  1),
(17, 17, 'La comunidad o el mundo virtual en Chocolate Doom me hizo sentir no bienvenido.',               'Relatedness Frustration',  TRUE,  1),
(18, 18, 'Los demas en Chocolate Doom fueron hostiles hacia mi.',                                         'Relatedness Frustration',  TRUE,  1);
