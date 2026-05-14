CREATE TABLE episodios (
    episodio_id INTEGER NOT NULL,
    numero_episodio INTEGER NOT NULL,
    nombre_episodio VARCHAR(100) NOT NULL,

    CONSTRAINT pk_episodios PRIMARY KEY (episodio_id)

);

CREATE TABLE intrumentos_ux(
    instrumento_id INTEGER NOT NULL,
    nombre_instrumento VARCHAR(20) NOT NULL,
    versionn VARCHAR(10) NOT NULL,
    nombre_episodio VARCHAR(100) NOT NULL,
    descripcion VARCHAR(1000) NOT NULL,
    escala_max INTEGER NOT NULL,
    escala_min INTEGER NOT NULL,

    CONSTRAINT pk_instrumentos_ux PRIMARY KEY (instrumento_id)
);


CREATE TABLE usuarios (
    user_id                  INTEGER        NOT NULL,
    nombre_usuario           VARCHAR(50)    NOT NULL,
    email                    VARCHAR(100)   NOT NULL,
    edad                     INTEGER        NOT NULL,
    genero                   VARCHAR(20)    NOT NULL,
    nivel_experiencia        VARCHAR(20)    NOT NULL,
    creado_en                TIMESTAMP      NOT NULL,
    esta_activo              BOOLEAN        NOT NULL,
    firma_consentimiento_en  TIMESTAMP      NOT NULL,
    consentimiento           VARCHAR(1000)  NOT NULL,

    CONSTRAINT pk_usuarios PRIMARY KEY (user_id)
);


CREATE TABLE mapas (
    mapa_id              INTEGER       NOT NULL,
    codigo_mapa          VARCHAR(10)   NOT NULL,
    nombre_mapa          VARCHAR(100)  NOT NULL,
    ancho_unidades       FLOAT         NOT NULL,
    alto_unidades        FLOAT         NOT NULL,
    episodiosepisodio_id INTEGER       NOT NULL,

    CONSTRAINT pk_mapas PRIMARY KEY (mapa_id),
    CONSTRAINT fk_mapas_episodios FOREIGN KEY (episodiosepisodio_id)
        REFERENCES episodios (episodio_id)
);


CREATE TABLE items_ux (
    item_id                      INTEGER        NOT NULL,
    numero_item                  INTEGER        NOT NULL,
    texto_item                   VARCHAR(1000)  NOT NULL,
    dimension                    VARCHAR(50)    NOT NULL,
    puntaje_invertido            BOOLEAN        NOT NULL,
    instrumentos_uxinstrumento_id INTEGER       NOT NULL,

    CONSTRAINT pk_items_ux PRIMARY KEY (item_id),
    CONSTRAINT fk_items_ux_instrumentos FOREIGN KEY (instrumentos_uxinstrumento_id)
        REFERENCES instrumentos_ux (instrumento_id)
);


CREATE TABLE jugadores (
    jugador_id      INTEGER      NOT NULL,
    alias           VARCHAR(50)  NOT NULL,
    creado_en       TIMESTAMP    NOT NULL,
    usuariosuser_id INTEGER      NOT NULL,

    CONSTRAINT pk_jugadores PRIMARY KEY (jugador_id),
    CONSTRAINT fk_jugadores_usuarios FOREIGN KEY (usuariosuser_id)
        REFERENCES usuarios (user_id)
);


CREATE TABLE sectores (
    sector_id    INTEGER      NOT NULL,
    nombre_sector VARCHAR(50) NOT NULL,
    bbox_x_min   FLOAT        NOT NULL,
    bbox_x_max   FLOAT        NOT NULL,
    bbox_y_min   FLOAT        NOT NULL,
    bbox_y_max   FLOAT        NOT NULL,
    mapasmapa_id INTEGER      NOT NULL,

    CONSTRAINT pk_sectores PRIMARY KEY (sector_id),
    CONSTRAINT fk_sectores_mapas FOREIGN KEY (mapasmapa_id)
        REFERENCES mapas (mapa_id)
);


CREATE TABLE sesiones_juego (
    sesion_id    INTEGER      NOT NULL,
    modo_juego   VARCHAR(20)  NOT NULL,
    dificultad   VARCHAR(20)  NOT NULL,
    iniciado_en  TIMESTAMP    NOT NULL,
    terminado_en TIMESTAMP    NOT NULL,
    mapasmapa_id INTEGER      NOT NULL,

    CONSTRAINT pk_sesiones_juego PRIMARY KEY (sesion_id),
    CONSTRAINT fk_sesiones_mapas FOREIGN KEY (mapasmapa_id)
        REFERENCES mapas (mapa_id)
);


CREATE TABLE tic (
    tic_id                  INTEGER  NOT NULL,
    numero_tic              INTEGER  NOT NULL,
    timestamp_ms            INTEGER  NOT NULL,
    sesiones_juegosesion_id INTEGER  NOT NULL,

    CONSTRAINT pk_tic PRIMARY KEY (tic_id),
    CONSTRAINT fk_tic_sesiones FOREIGN KEY (sesiones_juegosesion_id)
        REFERENCES sesiones_juego (sesion_id)
);


CREATE TABLE respuestas_ux (
    respuesta_id                  INTEGER  NOT NULL,
    respondido_en                 TIMESTAMP NOT NULL,
    puntaje_total                 FLOAT    NOT NULL,
    usuariosuser_id               INTEGER  NOT NULL,
    sesiones_juegosesion_id       INTEGER  NOT NULL,
    instrumentos_uxinstrumento_id INTEGER  NOT NULL,
    items_uxitem_id               INTEGER  NOT NULL,

    CONSTRAINT pk_respuestas_ux PRIMARY KEY (respuesta_id),
    CONSTRAINT fk_respuestas_usuarios FOREIGN KEY (usuariosuser_id)
        REFERENCES usuarios (user_id),
    CONSTRAINT fk_respuestas_sesiones FOREIGN KEY (sesiones_juegosesion_id)
        REFERENCES sesiones_juego (sesion_id),
    CONSTRAINT fk_respuestas_instrumentos FOREIGN KEY (instrumentos_uxinstrumento_id)
        REFERENCES instrumentos_ux (instrumento_id),
    CONSTRAINT fk_respuestas_items FOREIGN KEY (items_uxitem_id)
        REFERENCES items_ux (item_id)
);


CREATE TABLE eventos_telemetria (
    evento_id               INTEGER  NOT NULL,
    momentum_dx             FLOAT    NOT NULL,
    pos_x                   FLOAT    NOT NULL,
    pos_y                   FLOAT    NOT NULL,
    pos_z                   FLOAT    NOT NULL,
    angulo_vision           FLOAT    NOT NULL,
    momentum_dy             FLOAT    NOT NULL,
    velocidad_momentum      FLOAT    NOT NULL,
    salud                   INTEGER  NOT NULL,
    armadura                INTEGER  NOT NULL,
    municion_balas          INTEGER  NOT NULL,
    municion_escopeta       INTEGER  NOT NULL,
    municion_cohetes        INTEGER  NOT NULL,
    municion_celulas        INTEGER  NOT NULL,
    episodiosepisodio_id    INTEGER  NOT NULL,
    mapasmapa_id            INTEGER  NOT NULL,
    sectoressector_id       INTEGER  NOT NULL,
    jugadoresjugador_id     INTEGER  NOT NULL,
    sesiones_juegosesion_id INTEGER  NOT NULL,
    tictic_id               INTEGER  NOT NULL,

    CONSTRAINT pk_eventos_telemetria PRIMARY KEY (evento_id),
    CONSTRAINT fk_eventos_episodios FOREIGN KEY (episodiosepisodio_id)
        REFERENCES episodios (episodio_id),
    CONSTRAINT fk_eventos_mapas FOREIGN KEY (mapasmapa_id)
        REFERENCES mapas (mapa_id),
    CONSTRAINT fk_eventos_sectores FOREIGN KEY (sectoressector_id)
        REFERENCES sectores (sector_id),
    CONSTRAINT fk_eventos_jugadores FOREIGN KEY (jugadoresjugador_id)
        REFERENCES jugadores (jugador_id),
    CONSTRAINT fk_eventos_sesiones FOREIGN KEY (sesiones_juegosesion_id)
        REFERENCES sesiones_juego (sesion_id),
    CONSTRAINT fk_eventos_tic FOREIGN KEY (tictic_id)
        REFERENCES tic (tic_id)
);


CREATE TABLE registros_auditoria (
    auditoria_id  INTEGER        NOT NULL,
    accedido_por  VARCHAR(50)    NOT NULL,
    nombre_tabla  VARCHAR(50)    NOT NULL,
    accion        VARCHAR(10)    NOT NULL,
    accedido_en   TIMESTAMP      NOT NULL,
    detalles      VARCHAR(1000)  NOT NULL,

    CONSTRAINT pk_registros_auditoria PRIMARY KEY (auditoria_id)
);
