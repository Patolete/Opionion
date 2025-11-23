# ============================================
# APP.PY - Flask + MySQL (CORREGIDO)
# ============================================

from flask import Flask, render_template, request, jsonify, redirect
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)

# ============================================
# CONFIGURACIÓN DE BASE DE DATOS
# ============================================
DB_CONFIG = {
    'host': 'localhost',
    'database': 'opinion_movies',
    'user': 'root',
    'password': '2009',
    'charset': 'utf8mb4'
}

# ============================================
# FUNCIÓN PARA CONECTAR A LA DB
# ============================================
def conectar_db():
    try:
        return mysql.connector.connect(**DB_CONFIG)
    except Error as e:
        print("❌ Error al conectar:", e)
        return None

# ============================================
# FUNCIÓN PARA BUSCAR PELÍCULAS
# ============================================
def buscar_peliculas(termino):
    conexion = conectar_db()
    if not conexion:
        return []

    try:
        cursor = conexion.cursor(dictionary=True)

        sql = """
            SELECT id, title, user, rating, synopsis
            FROM movies
            WHERE title LIKE %s OR user LIKE %s
            ORDER BY rating DESC
        """

        patron = f"%{termino}%"
        cursor.execute(sql, (patron, patron))

        peliculas = cursor.fetchall()

        cursor.close()
        conexion.close()

        return peliculas

    except Error as e:
        print("❌ Error en búsqueda:", e)
        return []

# ============================================
# RUTAS NORMALES (HTML)
# ============================================
@app.route('/')
def home():
    return render_template('index.html')

@app.route('/buscador')
def peliculas():
    return render_template('connected_buscador.html')

@app.route('/buscar_p')
def buscar_perfil():
    return render_template('buscar_perfil.html')

# ============================================
# PERFIL (CORREGIDO)
# ============================================
@app.route('/perfil')
def perfil():
    username = request.args.get("user", "")

    # NO BORRO NADA: solo agrego obtener reseñas del usuario
    conexion = conectar_db()
    if not conexion:
        return render_template('perfil.html', user=username, reseñas=[])

    cursor = conexion.cursor()

    # Obtener ID del usuario
    cursor.execute("SELECT id FROM users WHERE username = %s", (username,))
    row = cursor.fetchone()

    if not row:
        return render_template('perfil.html', user=username, reseñas=[])

    user_id = row[0]

    # Obtener reseñas
    cursor.execute("""
        SELECT movies.title, reviews.rating, reviews.comment, reviews.id
        FROM reviews
        JOIN movies ON movies.id = reviews.movie_id
        WHERE reviews.user_id = %s
    """, (user_id,))

    reseñas = cursor.fetchall()

    cursor.close()
    conexion.close()

    return render_template('perfil.html', user=username, reseñas=reseñas)

@app.route('/peliculas/lista')
def peliculas_lista():
    return render_template('connected_expandable_list.html')

# ============================================
# API BUSCAR PELÍCULAS
# ============================================
@app.route('/buscar', methods=['POST'])
def buscar():
    try:
        data = request.get_json()
        termino = data.get('query', '').strip()

        if not termino:
            return jsonify({'success': False, 'message': 'Debes escribir algo', 'peliculas': []})

        peliculas = buscar_peliculas(termino)

        colores = ['blue', 'yellow', 'green']
        peliculas_formateadas = []

        for i, p in enumerate(peliculas):
            peliculas_formateadas.append({
                'id': p['id'],
                'title': p['title'],
                'author': p['user'],
                'rating': float(p['rating']) if p['rating'] else 0,
                'description': p['synopsis'],
                'iconColor': colores[i % len(colores)]
            })

        return jsonify({
            'success': True,
            'message': f'Se encontraron {len(peliculas)} películas',
            'peliculas': peliculas_formateadas
        })

    except Exception as e:
        print("❌ Error:", e)
        return jsonify({'success': False, 'message': 'Error en el servidor', 'peliculas': []})

# ============================================
# VER RESEÑAS DEL USUARIO (SIN CAMBIOS)
# ============================================
@app.route('/usuarios/reseñas')
def usuarios_resenas():
    username = request.args.get("username")

    if not username:
        return "Falta el parámetro ?username=usuario"

    conexion = conectar_db()
    if not conexion:
        return "❌ Error de conexión"

    try:
        cursor = conexion.cursor()

        # Obtener ID del usuario
        cursor.execute("SELECT id FROM users WHERE username = %s", (username,))
        row = cursor.fetchone()

        if not row:
            return f"No existe el usuario: {username}"

        user_id = row[0]

        cursor.execute("""
            SELECT movies.title, reviews.rating, reviews.comment, reviews.id
            FROM reviews
            JOIN movies ON movies.id = reviews.movie_id
            WHERE reviews.user_id = %s
        """, (user_id,))

        reseñas = cursor.fetchall()

        cursor.close()
        conexion.close()

        return render_template(
            "connected_expandable_list.html",
            reseñas=reseñas,
            username=username
        )

    except Error as e:
        return f"❌ Error en la consulta: {e}"

# ============================================
# ElIMINAR RESEÑA
# ============================================
@app.route("/eliminar_resena/<id>")
def eliminar_resena(id):
    conexion = conectar_db()
    if not conexion:
        return "❌ Error de conexión"

    cursor = conexion.cursor()
    cursor.execute("DELETE FROM reviews WHERE id = %s", (id,))
    conexion.commit()
    cursor.close()
    conexion.close()

    return redirect(request.referrer or "/")

# ============================================
# INICIAR SERVIDOR
# ============================================
if __name__ == '__main__':
    print("\n==============================")
    print("🎬 Servidor OPINION iniciado")
    print("🌐 http://localhost:5000")
    print("==============================\n")
    app.run(debug=True)