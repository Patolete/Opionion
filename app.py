from flask import Flask, render_template

app = Flask(__name__)

if __name__ == '__main__':
    app.run(debug=True)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/usuarios')
def home():
    return render_template('buscador_usuarios.html')

@app.route('/peliculas')
def home():
    return render_template('buscador_peliculas.html')

@app.route('/perfil')
def home():
    return render_template('perfil.html')

@app.route('/peliculas/buscador')
def home():
    return render_template('expandable_movies_lis.html')

