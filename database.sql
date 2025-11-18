-- ============================================
-- BASE DE DATOS PARA BUSCADOR DE PELÍCULAS
-- Archivo: database.sql (CORREGIDO)
-- ============================================

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS opinion_movies;
USE opinion_movies;

-- Tabla de géneros
CREATE TABLE genres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla principal de películas (SIMPLIFICADA)
CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    user VARCHAR(50) NOT NULL,
    rating DECIMAL(3,1),
    synopsis TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar géneros
INSERT INTO genres (name) VALUES 
('Acción'), ('Aventura'), ('Comedia'), ('Drama'), ('Terror'), 
('Ciencia Ficción'), ('Romance'), ('Thriller'), ('Animación'), 
('Documental'), ('Musical'), ('Crimen'), ('Fantasía'), ('Guerra'), ('Western');

-- ============================================
-- INSERTAR PELÍCULAS (CORREGIDO)
-- ============================================

INSERT INTO movies (title, user, rating, synopsis) VALUES
-- Películas de ejemplo
('Los Vengadores', 'PapuAnashei33', 8.0, 'Los superhéroes más poderosos de la Tierra deben unirse para derrotar a Loki y su ejército alienígena.'),
('Mad Max: Furia en la Carretera', 'ActionFan', 8.1, 'En un mundo post-apocalíptico, Max se ve envuelto en una guerra entre un tirano y un grupo de mujeres rebeldes.'),
('John Wick', 'MovieLover', 7.4, 'Un ex-asesino a sueldo sale de su retiro para rastrear a los gángsters que mataron a su perro.'),

('Inception', 'DreamerX', 8.8, 'Un ladrón que se infiltra en los sueños de otros debe realizar el trabajo imposible: la inception.'),
('Blade Runner 2049', 'SciFiFan', 8.0, 'Un joven blade runner descubre un secreto que lo lleva a buscar a Rick Deckard.'),
('Matrix', 'Topacio33', 8.7, 'Un programador descubre que la realidad que conoce es una simulación controlada por máquinas.'),
('Interestelar', 'SpaceGeek', 8.6, 'Un grupo de exploradores viaja a través de un agujero de gusano para salvar a la humanidad.'),

('El Padrino', 'ClassicFilm', 9.2, 'La saga de una familia de mafiosos italoamericanos en Nueva York.'),
('Cadena Perpetua', 'DramaKing', 9.3, 'Dos hombres encarcelados forjan una amistad a lo largo de los años en prisión.'),
('Forrest Gump', 'HeartWarmer', 8.8, 'La historia de un hombre con discapacidad intelectual que vive eventos históricos extraordinarios.'),

('El Gran Lebowski', 'ComedyFan', 8.1, 'Un vago de Los Ángeles se ve envuelto en un caso de secuestro por error de identidad.'),
('Superbad', 'TeenComedy', 7.6, 'Dos amigos intentan conseguir alcohol para una fiesta antes de graduarse.'),
('Mi Pobre Angelito', 'FamilyFun', 7.7, 'Un niño de 8 años debe defender su casa de dos ladrones torpes.'),

('Toy Story', 'PixarLover', 8.3, 'Los juguetes de un niño cobran vida cuando él no está presente.'),
('El Rey León', 'DisneyFan', 8.5, 'Un joven león debe reclamar su lugar como rey de la selva.'),
('Coco', 'MexicanCulture', 8.4, 'Un niño viaja a la Tierra de los Muertos para descubrir su historia familiar.'),
('Spider-Man: Un Nuevo Universo', 'MarvelFan', 8.4, 'Miles Morales se convierte en Spider-Man y conoce a otros Spider-People de dimensiones alternativas.'),

('El Exorcista', 'HorrorFan', 8.1, 'Una niña es poseída por un demonio y sus madres buscan ayuda de dos sacerdotes.'),
('Halloween', 'SlasherLover', 7.7, 'Un asesino en serie escapa de un hospital psiquiátrico y regresa a su ciudad natal.'),
('Eso', 'StephenKing', 7.3, 'Un grupo de niños se enfrenta a una entidad maléfica que aterroriza su pueblo.'),

('Titanic', 'RomanticSoul', 7.9, 'Una historia de amor a bordo del famoso barco condenado.'),
('El Diario de Noah', 'LoveStory', 7.8, 'Un hombre lee a su esposa con demencia la historia de su amor juvenil.'),
('Eterno Resplandor de una Mente sin Recuerdos', 'IndieFilm', 8.3, 'Una pareja decide borrar sus recuerdos el uno del otro después de una ruptura dolorosa.'),

('El Silencio de los Corderos', 'ThrillerFan', 8.6, 'Una agente del FBI busca la ayuda de Hannibal Lecter para capturar a otro asesino en serie.'),
('Seven', 'DarkCinema', 8.6, 'Dos detectives investigan una serie de asesinatos basados en los siete pecados capitales.'),
('El Sexto Sentido', 'TwistEnding', 8.2, 'Un psicólogo infantil trata a un niño que afirma poder ver personas muertas.'),

('Casablanca', 'GoldenAge', 8.5, 'Durante la Segunda Guerra Mundial, un estadounidense debe elegir entre el amor y la virtud.'),
('Ciudadano Kane', 'FilmHistory', 8.3, 'La vida de un magnate de los medios contada a través de las investigaciones sobre su última palabra.'),
('Psicosis', 'HitchcockFan', 8.5, 'Una mujer que huye con dinero robado se hospeda en un motel aislado.'),

('Parasitos', 'KoreanCinema', 8.5, 'Una familia pobre se infiltra en la vida de una familia rica con consecuencias inesperadas.'),
('Joker', 'DCFan', 8.4, 'La transformación de Arthur Fleck en el icónico villano de Gotham City.'),
('1917', 'WarFilm', 8.2, 'Dos soldados británicos deben entregar un mensaje crucial durante la Primera Guerra Mundial.');

-- ============================================
-- ÍNDICES PARA BÚSQUEDAS RÁPIDAS
-- ============================================

CREATE INDEX idx_movie_title ON movies(title);
CREATE INDEX idx_movie_user ON movies(user);