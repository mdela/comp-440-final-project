from flask import Flask, render_template, request, redirect, url_for, flash
import mysql.connector

app = Flask(__name__)

def get_db_connection():
    return mysql.connector.connect(
        host='127.0.0.1',
        user='root',
        password='professor',
        database='review_movies'
    )

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/movies')
def movies_list():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT movie_id, movie_title, movie_year, status_description FROM movies JOIN status ON movies.status_id = status.status_id")
    movies = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('movies_list.html', movies=movies)


# Route for viewing a single movie
@app.route('/movie/<int:movie_id>')
def view_movie(movie_id):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT movie_id, movie_title, movie_year FROM movies WHERE movie_id = %s", (movie_id,))
    movie = cur.fetchone()
    
    cur.execute("SELECT g.genre_description FROM genres g JOIN movie_genres mg ON g.genre_id = mg.genre_id WHERE mg.movie_id = %s", (movie_id,))
    genres = cur.fetchall()  # This will retrieve all genres associated with the movie.
    
    cur.close()
    conn.close()
    return render_template('view_movie.html', movie=movie, genres=genres)


# Route for adding a new movie
@app.route('/new_movie', methods=['GET', 'POST'])
def new_movie():
    conn = get_db_connection()
    cur = conn.cursor()
    
    if request.method == 'POST':
        movie_title = request.form['movie_title']
        movie_year = request.form['movie_year']
        status_id = request.form['status']  # Get the selected status
        genres = request.form.getlist('genres')  # Get all selected genres
        
        cur.execute("INSERT INTO movies (movie_title, movie_year, status_id) VALUES (%s, %s, %s)", 
                    (movie_title, movie_year, status_id))
        movie_id = cur.lastrowid
        
        for genre_id in genres:
            cur.execute("INSERT INTO movie_genres (movie_id, genre_id) VALUES (%s, %s)", 
                        (movie_id, genre_id))
        
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('movies_list'))
    else:
        # Fetch statuses and genres for the form dropdowns and checkboxes
        cur.execute("SELECT status_id, status_description FROM status")
        statuses = cur.fetchall()
        
        cur.execute("SELECT genre_id, genre_description FROM genres")
        genres = cur.fetchall()
        
        cur.close()
        conn.close()
        return render_template('new_movie.html', statuses=statuses, genres=genres)


# Route for editing an existing movie
@app.route('/edit_movie/<int:movie_id>', methods=['GET', 'POST'])
def edit_movie(movie_id):
    conn = get_db_connection()
    cur = conn.cursor()
    if request.method == 'POST':
        movie_year = request.form['movie_year']
        status_id = request.form['status_id']
        cur.execute("UPDATE movies SET movie_year = %s, status_id = %s WHERE movie_id = %s", (movie_year, status_id, movie_id))
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('movies_list'))
    else:
        cur.execute("SELECT movie_year, status_id FROM movies WHERE movie_id = %s", (movie_id,))
        movie = cur.fetchone()
        cur.execute("SELECT status_id, status_description FROM status")
        statuses = cur.fetchall()
        cur.close()
        conn.close()
        return render_template('edit_movie.html', movie=movie, movie_id=movie_id, statuses=statuses)



@app.route('/watchlists_list')
def watchlists_list():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
        SELECT w.watchlist_id, w.watchlist_name, GROUP_CONCAT(m.movie_title SEPARATOR ', ') AS movies
        FROM watchlist w
        LEFT JOIN movie_watchlists mw ON w.watchlist_id = mw.watchlist_id
        LEFT JOIN movies m ON mw.movie_id = m.movie_id
        GROUP BY w.watchlist_id
    """)
    watchlists = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('watchlists_list.html', watchlists=watchlists)

@app.route('/new_watchlist', methods=['GET', 'POST'])
def new_watchlist():
    conn = get_db_connection()
    cur = conn.cursor()
    if request.method == 'POST':
        watchlist_name = request.form['watchlist_name']
        selected_movies = request.form.getlist('movies')
        
        cur.execute("INSERT INTO watchlist (watchlist_name) VALUES (%s)", (watchlist_name,))
        watchlist_id = cur.lastrowid
        
        for movie_id in selected_movies:
            cur.execute("INSERT INTO movie_watchlists (watchlist_id, movie_id) VALUES (%s, %s)", (watchlist_id, movie_id))
        
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('watchlists_list'))
    else:
        cur.execute("SELECT movie_id, movie_title FROM movies")
        movies = cur.fetchall()
        cur.close()
        conn.close()
        return render_template('new_watchlist.html', movies=movies)
    

@app.route('/watchlist/<int:watchlist_id>')
def view_watchlist(watchlist_id):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT watchlist_name FROM watchlist WHERE watchlist_id = %s", (watchlist_id,))
    watchlist_name = cur.fetchone()[0]

    cur.execute("""
        SELECT m.movie_id, m.movie_title, m.movie_year 
        FROM movies m
        JOIN movie_watchlists mw ON m.movie_id = mw.movie_id
        WHERE mw.watchlist_id = %s
    """, (watchlist_id,))
    movies = [{'id': row[0], 'title': row[1], 'year': row[2]} for row in cur.fetchall()]

    cur.close()
    conn.close()
    return render_template('view_watchlist.html', watchlist_id=watchlist_id, watchlist_name=watchlist_name, movies=movies)


@app.route('/edit_watchlist/<int:watchlist_id>', methods=['GET', 'POST'])
def edit_watchlist(watchlist_id):
    conn = get_db_connection()
    cur = conn.cursor()
    if request.method == 'POST':
        watchlist_name = request.form['watchlist_name']
        selected_movies = request.form.getlist('movies')
        
        cur.execute("UPDATE watchlist SET watchlist_name = %s WHERE watchlist_id = %s", (watchlist_name, watchlist_id))
        cur.execute("DELETE FROM movie_watchlists WHERE watchlist_id = %s", (watchlist_id,))
        
        for movie_id in selected_movies:
            cur.execute("INSERT INTO movie_watchlists (watchlist_id, movie_id) VALUES (%s, %s)", (watchlist_id, movie_id))
        
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('watchlists_list'))
    else:
        cur.execute("SELECT watchlist_name FROM watchlist WHERE watchlist_id = %s", (watchlist_id,))
        watchlist_name = cur.fetchone()[0]

        cur.execute("SELECT movie_id, movie_title FROM movies")
        all_movies = cur.fetchall()

        cur.execute("SELECT movie_id FROM movie_watchlists WHERE watchlist_id = %s", (watchlist_id,))
        current_movies = [movie_id[0] for movie_id in cur.fetchall()]

        cur.close()
        conn.close()
        return render_template('edit_watchlist.html', watchlist_id=watchlist_id, watchlist_name=watchlist_name, all_movies=all_movies, current_movies=current_movies)

@app.route('/delete_watchlist/<int:watchlist_id>', methods=['POST'])
def delete_watchlist(watchlist_id):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("DELETE FROM watchlist WHERE watchlist_id = %s", (watchlist_id,))
    cur.execute("DELETE FROM movie_watchlists WHERE watchlist_id = %s", (watchlist_id,))
    conn.commit()
    cur.close()
    conn.close()
    return redirect(url_for('watchlists_list'))


# reviews
@app.route('/new_review', methods=['GET', 'POST'])
def new_review():
    conn = get_db_connection()
    cur = conn.cursor()
    if request.method == 'POST':
        movie_id = request.form['movie_id']
        location_id = request.form['location_id']  # This assumes you want to track where it was watched at the time of the review
        review_title = request.form['review_title']
        review_rating = request.form['review_rating']
        review_description = request.form['review_description']
        
        # Here you might want to update the movie's location, if that's part of your logic:
        cur.execute("UPDATE movies SET location_id = %s WHERE movie_id = %s", (location_id, movie_id))
        
        # Automatically set the movie's status to "Reviewed" (status_id = 4)
        cur.execute("UPDATE movies SET status_id = 4 WHERE movie_id = %s", (movie_id,))
        
        cur.execute("INSERT INTO reviews (movie_id, review_title, review_rating, review_description) VALUES (%s, %s, %s, %s)",
                    (movie_id, review_title, review_rating, review_description))
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('reviews_list'))
    else:
        cur.execute("SELECT movie_id, movie_title FROM movies")
        movies = cur.fetchall()
        cur.execute("SELECT location_id, location_name FROM location")
        locations = cur.fetchall()
        cur.close()
        conn.close()
        return render_template('new_review.html', movies=movies, locations=locations)



@app.route('/view_review/<int:review_id>')
def view_review(review_id):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
        SELECT r.review_id, r.review_title, r.review_rating, r.review_description, m.movie_title, m.movie_year
        FROM reviews r
        JOIN movies m ON r.movie_id = m.movie_id
        WHERE r.review_id = %s
    """, (review_id,))
    review = cur.fetchone()
    cur.close()
    conn.close()
    return render_template('view_review.html', review=review)

@app.route('/reviews_list')
def reviews_list():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
        SELECT r.review_id, r.review_title, r.review_rating, r.review_description, m.movie_title, m.movie_year, r.review_date
        FROM reviews r
        JOIN movies m ON r.movie_id = m.movie_id
        ORDER BY r.review_date DESC
    """)
    reviews = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('reviews_list.html', reviews=reviews)

@app.route('/edit_review/<int:review_id>', methods=['GET', 'POST'])
def edit_review(review_id):
    conn = get_db_connection()
    cur = conn.cursor()
    if request.method == 'POST':
        # Assuming form fields for the review details are provided.
        review_title = request.form['review_title']
        review_rating = request.form['review_rating']
        review_description = request.form['review_description']
        
        # Update the review in the database.
        cur.execute("""
            UPDATE reviews
            SET review_title = %s, review_rating = %s, review_description = %s
            WHERE review_id = %s
        """, (review_title, review_rating, review_description, review_id))
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('view_review', review_id=review_id))
    else:
        # Get the current review details to populate the form for editing.
        cur.execute("SELECT review_title, review_rating, review_description FROM reviews WHERE review_id = %s", (review_id,))
        review = cur.fetchone()
        cur.close()
        conn.close()
        return render_template('edit_review.html', review=review, review_id=review_id)

@app.route('/delete_review/<int:review_id>', methods=['POST'])
def delete_review(review_id):
    conn = get_db_connection()
    cur = conn.cursor()
    try:
        # Delete the review from the database
        cur.execute("DELETE FROM reviews WHERE review_id = %s", (review_id,))
        conn.commit()
        cur.close()
        conn.close()
        flash('Review successfully deleted!', 'success')
    except Exception as e:
        # In case of any error, flash a message to the user
        flash('Error deleting review: ' + str(e), 'error')
    return redirect(url_for('reviews_list'))


if __name__ == '__main__':
    app.run(debug=True)