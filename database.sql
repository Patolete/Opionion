-- ============================================
-- BASE DE DATOS PARA BUSCADOR DE PELÍCULAS
-- Archivo: movies_database.sql
-- ============================================

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS opinion_movies;
USE opinion_movies;

-- Tabla de géneros
CREATE TABLE genres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla principal de películas
CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    user VARCHAR(50),
    rating INT(1,4), -- calificación del 1.0 al 10.0
    synopsis TEXT
);

-- Insertar géneros
INSERT INTO genres (name) VALUES 
('Acción'), ('Aventura'), ('Comedia'), ('Drama'), ('Terror'), 
('Ciencia Ficción'), ('Romance'), ('Thriller'), ('Animación'), 
('Documental'), ('Musical'), ('Crimen'), ('Fantasía'), ('Guerra'), ('Western');

-- ============================================
-- INSERTAR PELÍCULAS POPULARES PRE-CARGADAS
-- ============================================

INSERT INTO movies (title, original_title, year, duration, genre_id, director, rating, synopsis, poster_url) VALUES

-- Películas de Acción
('Los Vengadores', "PapuAnashei33",'Los superhéroes más poderosos de la Tierra deben unirse para derrotar a Loki y su ejército alienígena.'),
('Mad Max: Furia en la Carretera', "PAPU" ,'En un mundo post-apocalíptico, Max se ve envuelto en una guerra entre un tirano y un grupo de mujeres rebeldes.'),
('John Wick', "PAPU" ,'Un ex-asesino a sueldo sale de su retiro para rastrear a los gángsters que mataron a su perro.'),

-- Películas de Ciencia Ficción
('Inception', "PAPU" ,'Un ladrón que se infiltra en los sueños de otros debe realizar el trabajo imposible: la inception.'),
('Blade Runner 2049', "PAPU" ,'Un joven blade runner descubre un secreto que lo lleva a buscar a Rick Deckard.'),
('Matrix', "PAPU" ,'Un programador descubre que la realidad que conoce es una simulación controlada por máquinas.'),
('Interestelar', "PAPU" ,'Un grupo de exploradores viaja a través de un agujero de gusano para salvar a la humanidad.'),

-- Películas de Drama
('El Padrino', "PAPU" ,'La saga de una familia de mafiosos italoamericanos en Nueva York.'),
('Cadena Perpetua', "PAPU" ,'Dos hombres encarcelados forjan una amistad a lo largo de los años en prisión.'),
('Forrest Gump', "PAPU" ,'La historia de un hombre con discapacidad intelectual que vive eventos históricos extraordinarios.'),

-- Películas de Comedia
('El Gran Lebowski', "PAPU" ,'Un vago de Los Ángeles se ve envuelto en un caso de secuestro por error de identidad.'),
('Superbad', "PAPU" ,'Dos amigos intentan conseguir alcohol para una fiesta antes de graduarse.'),
('Mi Pobre Angelito', "PAPU" ,'Un niño de 8 años debe defender su casa de dos ladrones torpes.'),

-- Películas de Animación
('Toy Story', "PAPU" ,'Los juguetes de un niño cobran vida cuando él no está presente.'),
('El Rey León', "PAPU" ,'Un joven león debe reclamar su lugar como rey de la selva.'),
('Coco', "PAPU" ,'Un niño viaja a la Tierra de los Muertos para descubrir su historia familiar.'),
('Spider-Man: Un Nuevo Universo', "PAPU" ,'Miles Morales se convierte en Spider-Man y conoce a otros Spider-People de dimensiones alternativas.'),

-- Películas de Terror
('El Exorcista', "PAPU" ,'Una niña es poseída por un demonio y sus madres buscan ayuda de dos sacerdotes.'),
('Halloween', "PAPU" ,'Un asesino en serie escapa de un hospital psiquiátrico y regresa a su ciudad natal.'),
('Eso', "PAPU" ,'Un grupo de niños se enfrenta a una entidad malévola que aterroriza su pueblo.'),

-- Películas de Romance
('Titanic', "PAPU" ,'Una historia de amor a bordo del famoso barco condenado.'),
('El Diario de Noah', "PAPU" ,'Un hombre lee a su esposa con demencia la historia de su amor juvenil.'),
('Eterno Resplandor de una Mente sin Recuerdos', "PAPU" ,'Una pareja decide borrar sus recuerdos el uno del otro después de una ruptura dolorosa.'),

-- Películas de Thriller
('El Silencio de los Corderos', "PAPU" ,'Una agente del FBI busca la ayuda de Hannibal Lecter para capturar a otro asesino en serie.'),
('Seven', "PAPU" ,'Dos detectives investigan una serie de asesinatos basados en los siete pecados capitales.'),
('El Sexto Sentido', "PAPU" ,'Un psicólogo infantil trata a un niño que afirma poder ver personas muertas.'),

-- Películas Clásicas
('Casablanca', "PAPU" ,'Durante la Segunda Guerra Mundial, un estadounidense debe elegir entre el amor y la virtud.'),
('Ciudadano Kane', "PAPU" ,'La vida de un magnate de los medios contada a través de las investigaciones sobre su última palabra.'),
('Psicosis', "PAPU" ,'Una mujer que huye con dinero robado se hospeda en un motel aislado.'),

-- Películas Recientes
('Parasitos', "PAPU" ,'Una familia pobre se infiltra en la vida de una familia rica con consecuencias inesperadas.'),
('Joker', "PAPU" ,'La transformación de Arthur Fleck en el icónico villano de Gotham City.'),
('1917', "PAPU" ,'Dos soldados británicos deben entregar un mensaje crucial durante la Primera Guerra Mundial.' );

-- ============================================
-- ÍNDICES PARA OPTIMIZAR BÚSQUEDAS
-- ============================================

-- Índice para búsquedas por título
CREATE INDEX idx_movie_title ON movies(title);
CREATE INDEX idx_movie_original_title ON movies(user);


-- ============================================
-- VISTAS ÚTILES PARA CONSULTAS COMPLEJAS
-- ============================================

-- Vista para películas con información del género
CREATE VIEW movies_with_genre AS
SELECT 
    m.id,
    m.title,
    m.user,
    m.rating,
    m.synopsis,
FROM movies m
LEFT JOIN genres g ON m.genre_id = g.id;

-- ============================================
-- PROCEDIMIENTOS ALMACENADOS PARA BÚSQUEDAS
-- ============================================

DELIMITER //

-- Procedimiento para buscar películas por nombre
CREATE PROCEDURE SearchMoviesByName(IN search_term VARCHAR(255))
BEGIN
    SELECT 
        m.id,
        m.title,
        m.user
        m.synopsis,
        m.poster_url
    FROM movies m
    LEFT JOIN genres g ON m.genre_id = g.id
    WHERE m.title LIKE CONCAT('%', search_term, '%')
       OR m.original_title LIKE CONCAT('%', search_term, '%')
    ORDER BY m.rating DESC, m.year DESC;
END //

-- Procedimiento para buscar por género
CREATE PROCEDURE SearchMoviesByGenre(IN genre_name VARCHAR(50))
BEGIN
    SELECT 
        m.id,
        m.title,
        m.user,
        m.rating,
        m.synopsis,
    FROM movies m
    LEFT JOIN genres g ON m.genre_id = g.id
    WHERE g.name = genre_name
    ORDER BY m.rating DESC, m.year DESC;
END //

DELIMITER ;

-- ============================================
-- CONSULTAS DE EJEMPLO PARA TESTING
-- ============================================

-- Buscar todas las películas
-- SELECT * FROM movies_with_genre ORDER BY rating DESC;

-- Buscar películas por nombre (ejemplo)
-- CALL SearchMoviesByName('Matrix');

-- Buscar películas de un género específico
-- CALL SearchMoviesByGenre('Ciencia Ficción');

-- Buscar películas por año
-- SELECT * FROM movies_with_genre WHERE year = 2019;

-- Top 10 películas mejor calificadas
-- SELECT * FROM movies_with_genre ORDER BY rating DESC LIMIT 10;