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
    original_title VARCHAR(255),
    year INT NOT NULL,
    duration INT, -- duración en minutos
    genre_id INT,
    director VARCHAR(100),
    rating DECIMAL(3,1), -- calificación del 1.0 al 10.0
    synopsis TEXT,
    poster_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (genre_id) REFERENCES genres(id)
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
('Los Vengadores', 'The Avengers', 2012, 143, 1, 'Joss Whedon', 8.0, 'Los superhéroes más poderosos de la Tierra deben unirse para derrotar a Loki y su ejército alienígena.', 'https://example.com/avengers.jpg'),
('Mad Max: Furia en la Carretera', 'Mad Max: Fury Road', 2015, 120, 1, 'George Miller', 8.1, 'En un mundo post-apocalíptico, Max se ve envuelto en una guerra entre un tirano y un grupo de mujeres rebeldes.', 'https://example.com/madmax.jpg'),
('John Wick', 'John Wick', 2014, 101, 1, 'Chad Stahelski', 7.4, 'Un ex-asesino a sueldo sale de su retiro para rastrear a los gángsters que mataron a su perro.', 'https://example.com/johnwick.jpg'),

-- Películas de Ciencia Ficción
('Inception', 'Inception', 2010, 148, 6, 'Christopher Nolan', 8.8, 'Un ladrón que se infiltra en los sueños de otros debe realizar el trabajo imposible: la inception.', 'https://example.com/inception.jpg'),
('Blade Runner 2049', 'Blade Runner 2049', 2017, 164, 6, 'Denis Villeneuve', 8.0, 'Un joven blade runner descubre un secreto que lo lleva a buscar a Rick Deckard.', 'https://example.com/bladerunner2049.jpg'),
('Matrix', 'The Matrix', 1999, 136, 6, 'Lana Wachowski', 8.7, 'Un programador descubre que la realidad que conoce es una simulación controlada por máquinas.', 'https://example.com/matrix.jpg'),
('Interestelar', 'Interstellar', 2014, 169, 6, 'Christopher Nolan', 8.6, 'Un grupo de exploradores viaja a través de un agujero de gusano para salvar a la humanidad.', 'https://example.com/interstellar.jpg'),

-- Películas de Drama
('El Padrino', 'The Godfather', 1972, 175, 4, 'Francis Ford Coppola', 9.2, 'La saga de una familia de mafiosos italoamericanos en Nueva York.', 'https://example.com/godfather.jpg'),
('Cadena Perpetua', 'The Shawshank Redemption', 1994, 142, 4, 'Frank Darabont', 9.3, 'Dos hombres encarcelados forjan una amistad a lo largo de los años en prisión.', 'https://example.com/shawshank.jpg'),
('Forrest Gump', 'Forrest Gump', 1994, 142, 4, 'Robert Zemeckis', 8.8, 'La historia de un hombre con discapacidad intelectual que vive eventos históricos extraordinarios.', 'https://example.com/forrestgump.jpg'),

-- Películas de Comedia
('El Gran Lebowski', 'The Big Lebowski', 1998, 117, 3, 'Joel Coen', 8.1, 'Un vago de Los Ángeles se ve envuelto en un caso de secuestro por error de identidad.', 'https://example.com/lebowski.jpg'),
('Superbad', 'Superbad', 2007, 113, 3, 'Greg Mottola', 7.6, 'Dos amigos intentan conseguir alcohol para una fiesta antes de graduarse.', 'https://example.com/superbad.jpg'),
('Mi Pobre Angelito', 'Home Alone', 1990, 103, 3, 'Chris Columbus', 7.7, 'Un niño de 8 años debe defender su casa de dos ladrones torpes.', 'https://example.com/homealone.jpg'),

-- Películas de Animación
('Toy Story', 'Toy Story', 1995, 81, 9, 'John Lasseter', 8.3, 'Los juguetes de un niño cobran vida cuando él no está presente.', 'https://example.com/toystory.jpg'),
('El Rey León', 'The Lion King', 1994, 88, 9, 'Roger Allers', 8.5, 'Un joven león debe reclamar su lugar como rey de la selva.', 'https://example.com/lionking.jpg'),
('Coco', 'Coco', 2017, 105, 9, 'Lee Unkrich', 8.4, 'Un niño viaja a la Tierra de los Muertos para descubrir su historia familiar.', 'https://example.com/coco.jpg'),
('Spider-Man: Un Nuevo Universo', 'Spider-Man: Into the Spider-Verse', 2018, 117, 9, 'Bob Persichetti', 8.4, 'Miles Morales se convierte en Spider-Man y conoce a otros Spider-People de dimensiones alternativas.', 'https://example.com/spiderverse.jpg'),

-- Películas de Terror
('El Exorcista', 'The Exorcist', 1973, 122, 5, 'William Friedkin', 8.1, 'Una niña es poseída por un demonio y sus madres buscan ayuda de dos sacerdotes.', 'https://example.com/exorcist.jpg'),
('Halloween', 'Halloween', 1978, 91, 5, 'John Carpenter', 7.7, 'Un asesino en serie escapa de un hospital psiquiátrico y regresa a su ciudad natal.', 'https://example.com/halloween.jpg'),
('Eso', 'It', 2017, 135, 5, 'Andy Muschietti', 7.3, 'Un grupo de niños se enfrenta a una entidad malévola que aterroriza su pueblo.', 'https://example.com/it.jpg'),

-- Películas de Romance
('Titanic', 'Titanic', 1997, 194, 7, 'James Cameron', 7.9, 'Una historia de amor a bordo del famoso barco condenado.', 'https://example.com/titanic.jpg'),
('El Diario de Noah', 'The Notebook', 2004, 123, 7, 'Nick Cassavetes', 7.8, 'Un hombre lee a su esposa con demencia la historia de su amor juvenil.', 'https://example.com/notebook.jpg'),
('Eterno Resplandor de una Mente sin Recuerdos', 'Eternal Sunshine of the Spotless Mind', 2004, 108, 7, 'Michel Gondry', 8.3, 'Una pareja decide borrar sus recuerdos el uno del otro después de una ruptura dolorosa.', 'https://example.com/eternal.jpg'),

-- Películas de Thriller
('El Silencio de los Corderos', 'The Silence of the Lambs', 1991, 118, 8, 'Jonathan Demme', 8.6, 'Una agente del FBI busca la ayuda de Hannibal Lecter para capturar a otro asesino en serie.', 'https://example.com/silence.jpg'),
('Seven', 'Se7en', 1995, 127, 8, 'David Fincher', 8.6, 'Dos detectives investigan una serie de asesinatos basados en los siete pecados capitales.', 'https://example.com/seven.jpg'),
('El Sexto Sentido', 'The Sixth Sense', 1999, 107, 8, 'M. Night Shyamalan', 8.2, 'Un psicólogo infantil trata a un niño que afirma poder ver personas muertas.', 'https://example.com/sixthsense.jpg'),

-- Películas Clásicas
('Casablanca', 'Casablanca', 1942, 102, 4, 'Michael Curtiz', 8.5, 'Durante la Segunda Guerra Mundial, un estadounidense debe elegir entre el amor y la virtud.', 'https://example.com/casablanca.jpg'),
('Ciudadano Kane', 'Citizen Kane', 1941, 119, 4, 'Orson Welles', 8.3, 'La vida de un magnate de los medios contada a través de las investigaciones sobre su última palabra.', 'https://example.com/kane.jpg'),
('Psicosis', 'Psycho', 1960, 109, 8, 'Alfred Hitchcock', 8.5, 'Una mujer que huye con dinero robado se hospeda en un motel aislado.', 'https://example.com/psycho.jpg'),

-- Películas Recientes
('Parasitos', 'Parasite', 2019, 132, 8, 'Bong Joon-ho', 8.5, 'Una familia pobre se infiltra en la vida de una familia rica con consecuencias inesperadas.', 'https://example.com/parasite.jpg'),
('Joker', 'Joker', 2019, 122, 8, 'Todd Phillips', 8.4, 'La transformación de Arthur Fleck en el icónico villano de Gotham City.', 'https://example.com/joker.jpg'),
('1917', '1917', 2019, 119, 14, 'Sam Mendes', 8.2, 'Dos soldados británicos deben entregar un mensaje crucial durante la Primera Guerra Mundial.', 'https://example.com/1917.jpg');

-- ============================================
-- ÍNDICES PARA OPTIMIZAR BÚSQUEDAS
-- ============================================

-- Índice para búsquedas por título
CREATE INDEX idx_movie_title ON movies(title);
CREATE INDEX idx_movie_original_title ON movies(original_title);
CREATE INDEX idx_movie_year ON movies(year);
CREATE INDEX idx_movie_genre ON movies(genre_id);

-- ============================================
-- VISTAS ÚTILES PARA CONSULTAS COMPLEJAS
-- ============================================

-- Vista para películas con información del género
CREATE VIEW movies_with_genre AS
SELECT 
    m.id,
    m.title,
    m.original_title,
    m.year,
    m.duration,
    g.name as genre,
    m.director,
    m.rating,
    m.synopsis,
    m.poster_url
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
        m.original_title,
        m.year,
        m.duration,
        g.name as genre,
        m.director,
        m.rating,
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
        m.original_title,
        m.year,
        m.duration,
        g.name as genre,
        m.director,
        m.rating,
        m.synopsis,
        m.poster_url
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