# ============================================
# APP.PY - Flask simple con MySQL
# ============================================

from flask import Flask, render_template, request, jsonify
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)

# ============================================
# CONFIGURACIÓN DE BASE DE DATOS
# ============================================
DB_CONFIG = {
    'host': 'localhost',
    'database': 'opinion_movies',
    'user': 'root',              # CAMBIAR si tu usuario es diferente
    'password': 'root',              # CAMBIAR si tienes contraseña
    'charset': 'utf8mb4'
}

# ============================================
# FUNCIÓN PARA CONECTAR A LA BASE DE DATOS
# ============================================
def conectar_db():
    """Conecta con MySQL y retorna la conexión"""
    try:
        conexion = mysql.connector.connect(**DB_CONFIG)
        if conexion.is_connected():
            print("✅ Conectado a MySQL")
            return conexion
    except Error as e:
        print(f"❌ Error de conexión: {e}")
        return None

# ============================================
# FUNCIÓN PARA BUSCAR PELÍCULAS
# ============================================
def buscar_peliculas(termino_busqueda):
    """
    Busca películas en la base de datos por título o usuario
    Retorna una lista de películas
    """
    conexion = conectar_db()
    if not conexion:
        return []
    
    try:
        cursor = conexion.cursor(dictionary=True)
        
        # SQL para buscar por título o usuario
        sql = """
            SELECT id, title, user, rating, synopsis 
            FROM movies 
            WHERE title LIKE %s OR user LIKE %s
            ORDER BY rating DESC
        """
        
        # Agregar % para buscar cualquier coincidencia
        patron_busqueda = f"%{termino_busqueda}%"
        cursor.execute(sql, (patron_busqueda, patron_busqueda))
        
        # Obtener resultados
        peliculas = cursor.fetchall()
        
        cursor.close()
        conexion.close()
        
        print(f"✅ Encontradas {len(peliculas)} películas")
        return peliculas
        
    except Error as e:
        print(f"❌ Error en búsqueda: {e}")
        return []

# ============================================
# RUTAS DE LA APLICACIÓN
# ============================================

@app.route('/')
def home():
    """Página principal"""
    return render_template('index.html')

@app.route('/usuarios')
def usuarios():
    """Página de búsqueda de usuarios"""
    return render_template('buscador_usuarios.html')

@app.route('/peliculas')
def peliculas():
    """Página de búsqueda de películas"""
    return render_template('connected_buscador.html')

@app.route('/perfil')
def perfil():
    """Página de perfil"""
    return render_template('perfil.html')

# ============================================
# RUTA PARA BUSCAR PELÍCULAS (API)
# ============================================
@app.route('/buscar', methods=['POST'])
def buscar():
    """
    Recibe la búsqueda del formulario y retorna películas en JSON
    """
    try:
        # Obtener el término de búsqueda del formulario
        data = request.get_json()
        termino = data.get('query', '').strip()
        
        print(f"🔍 Buscando: '{termino}'")
        
        if not termino:
            return jsonify({
                'success': False,
                'message': 'Debes ingresar un término de búsqueda',
                'peliculas': []
            })
        
        # Buscar en la base de datos
        peliculas = buscar_peliculas(termino)
        
        # Convertir a formato para el frontend
        peliculas_formateadas = []
        colores = ['blue', 'yellow', 'green']  # Colores para los iconos
        
        for i, pelicula in enumerate(peliculas):
            peliculas_formateadas.append({
                'id': pelicula['id'],
                'title': pelicula['title'],
                'author': pelicula['user'],
                'rating': float(pelicula['rating']) if pelicula['rating'] else 0,
                'description': pelicula['synopsis'],
                'iconColor': colores[i % 3],  # Rotar entre los 3 colores
                'comments': []  # Por ahora sin comentarios
            })
        
        return jsonify({
            'success': True,
            'message': f'Se encontraron {len(peliculas)} películas',
            'peliculas': peliculas_formateadas
        })
        
    except Exception as e:
        print(f"❌ Error: {e}")
        return jsonify({
            'success': False,
            'message': 'Error en el servidor',
            'peliculas': []
        })

# ============================================
# RUTA PARA MOSTRAR LISTA DE PELÍCULAS
# ============================================
@app.route('/peliculas/lista')
def peliculas_lista():
    """Muestra la lista expandible de películas"""
    return render_template('connected_expandable_list.html')

# ============================================
# EJECUTAR APLICACIÓN
# ============================================
if __name__ == '__main__':
    print("\n" + "="*50)
    print("🎬 INICIANDO SERVIDOR OPINION")
    print("🌐 http://localhost:5000")
    print("="*50 + "\n")
    app.run(debug=True)