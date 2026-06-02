-- 3 jugadores que respondieron la encuesta BANGS

INSERT INTO usuarios (user_id, nombre_usuario, email, edad, genero, nivel_experiencia, creado_en, esta_activo, firma_consentimiento_en, consentimiento) VALUES
(1, 'Davidg',    'davidg@uni.edu',    18, 'Masculino', 'Avanzado',     '2026-05-20 20:00:00', TRUE, '2026-05-20 20:01:00', 'Acepto participar en el estudio de telemetria de Chocolate Doom.'),
(2, 'gaby.12',   'gaby12@uni.edu',    20, 'Femenino',  'Principiante', '2026-05-20 20:00:00', TRUE, '2026-05-20 20:01:00', 'Acepto participar en el estudio de telemetria de Chocolate Doom.'),
(3, 'Nicolas',   'nicolas@uni.edu',   19, 'Masculino', 'Avanzado',     '2026-05-20 20:00:00', TRUE, '2026-05-20 20:01:00', 'Acepto participar en el estudio de telemetria de Chocolate Doom.'),

INSERT INTO jugadores (jugador_id, alias, creado_en, usuariosuser_id) VALUES
(1, 'Davidg',  '2026-05-20 20:05:00', 1),
(2, 'gaby.12', '2026-05-20 20:05:00', 2),
(3, 'Nicolas', '2026-05-20 20:05:00', 3);

INSERT INTO episodios (episodio_id, numero_episodio, nombre_episodio) VALUES
(1, 1, 'THE CITY OF THE DAMNED'),
(2, 2, 'HELL''S MAW'),
(3, 3, 'THE DOME OF D''SPARIL'),
(4, 4, 'THE OSSUARY'),
(5, 5, 'THE STAGNANT DEMESNE'),
(6, 6, 'UNNAMED EPISODE');

INSERT INTO mapas (mapa_id, codigo_mapa, nombre_mapa, ancho_unidades, alto_unidades, episodiosepisodio_id) VALUES
(1,  'E1M1', 'THE DOCKS', 0.0, 0.0, 1),
(2,  'E1M2', 'THE DUNGEONS', 0.0, 0.0, 1),
(3,  'E1M3', 'THE GATEHOUSE', 0.0, 0.0, 1),
(4,  'E1M4', 'THE GUARD TOWER', 0.0, 0.0, 1),
(5,  'E1M5', 'THE CITADEL', 0.0, 0.0, 1),
(6,  'E1M6', 'THE CATHEDRAL', 0.0, 0.0, 1),
(7,  'E1M7', 'THE CRYPTS', 0.0, 0.0, 1),
(8,  'E1M8', 'HELL''S MAW', 0.0, 0.0, 1),
(9,  'E1M9', 'THE GRAVEYARD', 0.0, 0.0, 1),
(10, 'E2M1', 'THE CRATER', 0.0, 0.0, 2),
(11, 'E2M2', 'THE LAVA PITS', 0.0, 0.0, 2),
(12, 'E2M3', 'THE RIVER OF FIRE', 0.0, 0.0, 2),
(13, 'E2M4', 'THE ICE GROTTO', 0.0, 0.0, 2),
(14, 'E2M5', 'THE CATACOMBS', 0.0, 0.0, 2),
(15, 'E2M6', 'THE LABYRINTH', 0.0, 0.0, 2),
(16, 'E2M7', 'THE GREAT HALL', 0.0, 0.0, 2),
(17, 'E2M8', 'THE PORTALS OF CHAOS', 0.0, 0.0, 2),
(18, 'E2M9', 'THE GLACIER', 0.0, 0.0, 2),
(19, 'E3M1', 'THE STOREHOUSE', 0.0, 0.0, 3),
(20, 'E3M2', 'THE CESSPOOL', 0.0, 0.0, 3),
(21, 'E3M3', 'THE CONFLUENCE', 0.0, 0.0, 3),
(22, 'E3M4', 'THE AZURE FORTRESS', 0.0, 0.0, 3),
(23, 'E3M5', 'THE OPHIDIAN LAIR', 0.0, 0.0, 3),
(24, 'E3M6', 'THE HALLS OF FEAR', 0.0, 0.0, 3),
(25, 'E3M7', 'THE CHASM', 0.0, 0.0, 3),
(26, 'E3M8', 'D''SPARIL''S KEEP', 0.0, 0.0, 3),
(27, 'E3M9', 'THE AQUIFER', 0.0, 0.0, 3),
(28, 'E4M1', 'CATAFALQUE', 0.0, 0.0, 4),
(29, 'E4M2', 'BLOCKHOUSE', 0.0, 0.0, 4),
(30, 'E4M3', 'AMBULATORY', 0.0, 0.0, 4),
(31, 'E4M4', 'SEPULCHER', 0.0, 0.0, 4),
(32, 'E4M5', 'GREAT STAIR', 0.0, 0.0, 4),
(33, 'E4M6', 'HALLS OF THE APOSTATE', 0.0, 0.0, 4),
(34, 'E4M7', 'RAMPARTS OF PERDITION', 0.0, 0.0, 4),
(35, 'E4M8', 'SHATTERED BRIDGE', 0.0, 0.0, 4),
(36, 'E4M9', 'MAUSOLEUM', 0.0, 0.0, 4),
(37, 'E5M1', 'OCHRE CLIFFS', 0.0, 0.0, 5),
(38, 'E5M2', 'RAPIDS', 0.0, 0.0, 5),
(39, 'E5M3', 'QUAY', 0.0, 0.0, 5),
(40, 'E5M4', 'COURTYARD', 0.0, 0.0, 5),
(41, 'E5M5', 'HYDRATYR', 0.0, 0.0, 5),
(42, 'E5M6', 'COLONNADE', 0.0, 0.0, 5),
(43, 'E5M7', 'FOETID MANSE', 0.0, 0.0, 5),
(44, 'E5M8', 'FIELD OF JUDGEMENT', 0.0, 0.0, 5),
(45, 'E5M9', 'SKEIN OF D''SPARIL', 0.0, 0.0, 5),
(46, 'E6M1', 'UNNAMED MAP 1', 0.0, 0.0, 6),
(47, 'E6M2', 'UNNAMED MAP 2', 0.0, 0.0, 6),
(48, 'E6M3', 'UNNAMED MAP 3', 0.0, 0.0, 6);

INSERT INTO sesiones_juego (sesion_id, modo_juego, dificultad, iniciado_en, terminado_en, mapasmapa_id) VALUES
(1, 'single', 'medium', '2026-05-20 20:00:00', '2026-05-20 20:30:00', 1),
(2, 'single', 'medium', '2026-05-20 20:35:00', '2026-05-20 21:05:00', 2),
(3, 'single', 'medium', '2026-05-20 21:10:00', '2026-05-20 21:40:00', 3);

--Davidg - sesion 3
INSERT INTO respuestas_ux (respuesta_id, respondido_en, puntaje_total, usuariosuser_id, sesiones_juegosesion_id, instrumentos_uxinstrumento_id, items_uxitem_id) VALUES
(1,  '2026-05-20 23:41:32', 7, 1, 3, 1, 1),
(2,  '2026-05-20 23:41:32', 6, 1, 3, 1, 2),
(3,  '2026-05-20 23:41:32', 6, 1, 3, 1, 3),
(4,  '2026-05-20 23:41:32', 3, 1, 3, 1, 4),
(5,  '2026-05-20 23:41:32', 2, 1, 3, 1, 5),
(6,  '2026-05-20 23:41:32', 4, 1, 3, 1, 6),
(7,  '2026-05-20 23:41:32', 6, 1, 3, 1, 7),
(8,  '2026-05-20 23:41:32', 6, 1, 3, 1, 8),
(9,  '2026-05-20 23:41:32', 7, 1, 3, 1, 9),
(10, '2026-05-20 23:41:32', 5, 1, 3, 1, 10),
(11, '2026-05-20 23:41:32', 6, 1, 3, 1, 11),
(12, '2026-05-20 23:41:32', 6, 1, 3, 1, 12),
(13, '2026-05-20 23:41:32', 6, 1, 3, 1, 13),
(14, '2026-05-20 23:41:32', 5, 1, 3, 1, 14),
(15, '2026-05-20 23:41:32', 2, 1, 3, 1, 15),
(16, '2026-05-20 23:41:32', 3, 1, 3, 1, 16),
(17, '2026-05-20 23:41:32', 7, 1, 3, 1, 17),
(18, '2026-05-20 23:41:32', 6, 1, 3, 1, 18);
 
-- gaby.12 - sesion 3
INSERT INTO respuestas_ux (respuesta_id, respondido_en, puntaje_total, usuariosuser_id, sesiones_juegosesion_id, instrumentos_uxinstrumento_id, items_uxitem_id) VALUES
(19, '2026-05-20 23:44:29', 6, 2, 3, 1, 1),
(20, '2026-05-20 23:44:29', 7, 2, 3, 1, 2),
(21, '2026-05-20 23:44:29', 2, 2, 3, 1, 3),
(22, '2026-05-20 23:44:29', 4, 2, 3, 1, 4),
(23, '2026-05-20 23:44:29', 2, 2, 3, 1, 5),
(24, '2026-05-20 23:44:29', 1, 2, 3, 1, 6),
(25, '2026-05-20 23:44:29', 7, 2, 3, 1, 7),
(26, '2026-05-20 23:44:29', 7, 2, 3, 1, 8),
(27, '2026-05-20 23:44:29', 6, 2, 3, 1, 9),
(28, '2026-05-20 23:44:29', 5, 2, 3, 1, 10),
(29, '2026-05-20 23:44:29', 1, 2, 3, 1, 11),
(30, '2026-05-20 23:44:29', 1, 2, 3, 1, 12),
(31, '2026-05-20 23:44:29', 1, 2, 3, 1, 13),
(32, '2026-05-20 23:44:29', 2, 2, 3, 1, 14),
(33, '2026-05-20 23:44:29', 1, 2, 3, 1, 15),
(34, '2026-05-20 23:44:29', 1, 2, 3, 1, 16),
(35, '2026-05-20 23:44:29', 1, 2, 3, 1, 17),
(36, '2026-05-20 23:44:29', 1, 2, 3, 1, 18);
 
-- Nicolas - sesion 1
INSERT INTO respuestas_ux (respuesta_id, respondido_en, puntaje_total, usuariosuser_id, sesiones_juegosesion_id, instrumentos_uxinstrumento_id, items_uxitem_id) VALUES
(37, '2026-05-20 23:46:05', 6, 3, 1, 1, 1),
(38, '2026-05-20 23:46:05', 5, 3, 1, 1, 2),
(39, '2026-05-20 23:46:05', 7, 3, 1, 1, 3),
(40, '2026-05-20 23:46:05', 2, 3, 1, 1, 4),
(41, '2026-05-20 23:46:05', 1, 3, 1, 1, 5),
(42, '2026-05-20 23:46:05', 2, 3, 1, 1, 6),
(43, '2026-05-20 23:46:05', 7, 3, 1, 1, 7),
(44, '2026-05-20 23:46:05', 7, 3, 1, 1, 8),
(45, '2026-05-20 23:46:05', 7, 3, 1, 1, 9),
(46, '2026-05-20 23:46:05', 6, 3, 1, 1, 10),
(47, '2026-05-20 23:46:05', 3, 3, 1, 1, 11),
(48, '2026-05-20 23:46:05', 4, 3, 1, 1, 12),
(49, '2026-05-20 23:46:05', 1, 3, 1, 1, 13),
(50, '2026-05-20 23:46:05', 1, 3, 1, 1, 14),
(51, '2026-05-20 23:46:05', 1, 3, 1, 1, 15),
(52, '2026-05-20 23:46:05', 1, 3, 1, 1, 16),
(53, '2026-05-20 23:46:05', 1, 3, 1, 1, 17),
(54, '2026-05-20 23:46:05', 1, 3, 1, 1, 18);
 





