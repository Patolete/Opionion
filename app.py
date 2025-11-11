from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/usuarios')
def usuarios():
    return render_template('buscador_usuarios.html')

@app.route('/peliculas')
def peliculas():
    return render_template('buscador_peliculas.html')

@app.route('/perfil')
def perfil():
    return render_template('perfil.html')

@app.route('/peliculas/buscador')
def buscador_peliculas():
    return render_template('expandable_movies_list.html')

if __name__ == '__main__':
    app.run(debug=True)

