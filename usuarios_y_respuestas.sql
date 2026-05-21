-- 4 jugadores que respondieron la encuesta BANGS

INSERT INTO usuarios (user_id, nombre_usuario, email, edad, genero, nivel_experiencia, creado_en, esta_activo, firma_consentimiento_en, consentimiento) VALUES
(1, 'Davidg',    'davidg@uni.edu',    18, 'Masculino', 'Avanzado',     '2026-05-20 20:00:00', TRUE, '2026-05-20 20:01:00', 'Acepto participar en el estudio de telemetria de Chocolate Doom.'),
(2, 'gaby.12',   'gaby12@uni.edu',    20, 'Femenino',  'Principiante', '2026-05-20 20:00:00', TRUE, '2026-05-20 20:01:00', 'Acepto participar en el estudio de telemetria de Chocolate Doom.'),
(3, 'Nicolas',   'nicolas@uni.edu',   19, 'Masculino', 'Avanzado',     '2026-05-20 20:00:00', TRUE, '2026-05-20 20:01:00', 'Acepto participar en el estudio de telemetria de Chocolate Doom.'),
(4, 'andres123', 'andres123@uni.edu', 18, 'Masculino', 'Intermedio',   '2026-05-20 20:00:00', TRUE, '2026-05-20 20:01:00', 'Acepto participar en el estudio de telemetria de Chocolate Doom.');

 INSERT INTO jugadores (jugador_id, alias, creado_en, usuariosuser_id) VALUES
(1, 'Davidg',    '2026-05-20 20:05:00', 1),
(2, 'gaby.12',   '2026-05-20 20:05:00', 2),
(3, 'Nicolas',   '2026-05-20 20:05:00', 3),
(4, 'andres123', '2026-05-20 20:05:00', 4);

INSERT INTO episodios (episodio_id, numero_episodio, nombre_episodio) VALUES
(1, 1, 'Knee-Deep in the Dead'),
(2, 2, 'The Shores of Hell'),
(3, 3, 'Inferno');

INSERT INTO mapas (mapa_id, codigo_mapa, nombre_mapa, ancho_unidades, alto_unidades, episodiosepisodio_id) VALUES
(1, 'E1M1', 'Hangar',           3200, 3200, 1),
(2, 'E1M2', 'Nuclear Plant',    3200, 3200, 1),
(3, 'E2M1', 'Deimos Anomaly',   3200, 3200, 2),
(4, 'E2M2', 'Containment Area', 3200, 3200, 2);

INSERT INTO sesiones_juego (sesion_id, modo_juego, dificultad, iniciado_en, terminado_en, mapasmapa_id) VALUES
(1, 'single', 'medium', '2026-05-20 20:00:00', '2026-05-20 20:30:00', 1),
(2, 'single', 'medium', '2026-05-20 20:35:00', '2026-05-20 21:05:00', 2),
(3, 'single', 'medium', '2026-05-20 21:10:00', '2026-05-20 21:40:00', 3),
(4, 'single', 'medium', '2026-05-20 21:45:00', '2026-05-20 22:15:00', 4);

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
 
-- andres123 - sesion 4
INSERT INTO respuestas_ux (respuesta_id, respondido_en, puntaje_total, usuariosuser_id, sesiones_juegosesion_id, instrumentos_uxinstrumento_id, items_uxitem_id) VALUES
(55, '2026-05-20 23:46:59', 7, 4, 4, 1, 1),
(56, '2026-05-20 23:46:59', 3, 4, 4, 1, 2),
(57, '2026-05-20 23:46:59', 3, 4, 4, 1, 3),
(58, '2026-05-20 23:46:59', 5, 4, 4, 1, 4),
(59, '2026-05-20 23:46:59', 1, 4, 4, 1, 5),
(60, '2026-05-20 23:46:59', 3, 4, 4, 1, 6),
(61, '2026-05-20 23:46:59', 5, 4, 4, 1, 7),
(62, '2026-05-20 23:46:59', 4, 4, 4, 1, 8),
(63, '2026-05-20 23:46:59', 6, 4, 4, 1, 9),
(64, '2026-05-20 23:46:59', 7, 4, 4, 1, 10),
(65, '2026-05-20 23:46:59', 5, 4, 4, 1, 11),
(66, '2026-05-20 23:46:59', 4, 4, 4, 1, 12),
(67, '2026-05-20 23:46:59', 2, 4, 4, 1, 13),
(68, '2026-05-20 23:46:59', 2, 4, 4, 1, 14),
(69, '2026-05-20 23:46:59', 4, 4, 4, 1, 15),
(70, '2026-05-20 23:46:59', 4, 4, 4, 1, 16),
(71, '2026-05-20 23:46:59', 3, 4, 4, 1, 17),
(72, '2026-05-20 23:46:59', 7, 4, 4, 1, 18);




