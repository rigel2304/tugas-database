CREATE DATABASE penjualan_buku;
USE penjualan_buku;

CREATE TABLE authors (
    id INT(11) PRIMARY KEY,
    name VARCHAR(255),
    photo VARCHAR(255),
    bio TEXT
);

CREATE TABLE genres (
    id INT(11) PRIMARY KEY,
    name VARCHAR(255),
    description TEXT
);

CREATE TABLE users (
    id INT(11) PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    role VARCHAR(50),
    last_access TIMESTAMP
);

CREATE TABLE books (
    id INT(11) PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    price DECIMAL(10,2),
    stock INT(11),
    cover_photo VARCHAR(255),
    genre_id INT(11),
    author_id INT(11),
    FOREIGN KEY (genre_id) REFERENCES genres(id),
    FOREIGN KEY (author_id) REFERENCES authors(id)
);

CREATE TABLE transactions (
    id INT(11) PRIMARY KEY,
    order_number VARCHAR(255),
    customer_id INT(11),
    book_id INT(11),
    total_amount DECIMAL(10,2),
    created_at date,
    updated_at date,
    FOREIGN KEY (customer_id) REFERENCES users(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

INSERT INTO authors (id, name, photo, bio) VALUES
(1, 'Andrea Hirata', 'andrea.jpg', 'Penulis novel Laskar Pelangi.'),
(2, 'Tere Liye', 'tereliye.jpg', 'Penulis novel serial Bumi dan aksi.'),
(3, 'Dee Lestari', 'dee.jpg', 'Penulis serial Supernova dan Perahu Kertas.'),
(4, 'Pramoedya Ananta Toer', 'pram.jpg', 'Sastrawan legendaris Indonesia.'),
(5, 'Ahmad Fuadi', 'afuadi.jpg', 'Penulis novel Negeri 5 Menara.');


UPDATE authors 
SET bio = 'Penulis novel laris Laskar Pelangi dan Sang Pemimpi.' 
WHERE id = 1;


DELETE FROM authors 
WHERE id = 5;


INSERT INTO genres (id, name, description) VALUES
(1, 'Fiksi', 'Buku-buku fiksi dan novel naratif.'),
(2, 'Pengembangan Diri', 'Buku panduan motivasi dan motivasi hidup.'),
(3, 'Sejarah', 'Buku dokumen dan rekam jejak sejarah.'),
(4, 'Sains & Teknologi', 'Buku pengetahuan sains dan pemograman.'),
(5, 'Komik', 'Buku cerita bergambar.');


UPDATE genres 
SET description = 'Buku panduan motivasi, bisnis, dan pengembangan diri.' 
WHERE id = 2;


DELETE FROM genres 
WHERE id = 5;


INSERT INTO books (id, title, description, price, stock, cover_photo, genre_id, author_id) VALUES
(1, 'Laskar Pelangi', 'Novel tentang perjuangan anak Belitung.', 85000.00, 20, 'laskar.jpg', 1, 1),
(2, 'Bumi', 'Novel fiksi petualangan dunia paralel.', 95000.00, 15, 'bumi.jpg', 1, 2),
(3, 'Perahu Kertas', 'Kisah cinta dan impian dua sejoli.', 78000.00, 12, 'perahu.jpg', 1, 3),
(4, 'Bumi Manusia', 'Novel sejarah pergerakan nasional.', 120000.00, 10, 'bumimanusia.jpg', 3, 4),
(5, 'Bumi dan Moon', 'Serial petualangan lanjutan.', 90000.00, 8, 'moon.jpg', 1, 2);


UPDATE books 
SET price = 88000.00, stock = 25 
WHERE id = 1;


DELETE FROM books 
WHERE id = 5;


INSERT INTO users (id, name, email, password, role, last_access) VALUES
(1, 'Budi Santoso', 'budi@example.com', 'password123', 'customer', NOW()),
(2, 'Siti Aminah', 'siti@example.com', 'password123', 'customer', NOW()),
(3, 'Admin Utama', 'admin@example.com', 'adminpass', 'admin', NOW()),
(4, 'Rudi Hermawan', 'rudi@example.com', 'password123', 'customer', NOW()),
(5, 'Dewi Lestari', 'dewi@example.com', 'password123', 'customer', NOW());


UPDATE users 
SET email = 'budi_baru@example.com' 
WHERE id = 1;


DELETE FROM users 
WHERE id = 5;


INSERT INTO transactions (id, order_number, customer_id, book_id, total_amount, created_at, updated_at) VALUES
(1, 'TRX001', 1, 1, 88000.00, NOW(), NOW()),
(2, 'TRX002', 2, 2, 95000.00, NOW(), NOW()),
(3, 'TRX003', 1, 3, 78000.00, NOW(), NOW()),
(4, 'TRX004', 4, 4, 120000.00, NOW(), NOW()),
(5, 'TRX005', 2, 1, 88000.00, NOW(), NOW());


UPDATE transactions 
SET total_amount = 90000.00, updated_at = NOW() 
WHERE id = 1;


DELETE FROM transactions 
WHERE id = 5;

SELECT title, price 
FROM books 
WHERE price > (SELECT AVG(price) FROM books);

SELECT DISTINCT price 
FROM books;

SELECT title, stock,
    CASE 
        WHEN stock < 15 THEN 'Stok Menipis'
        ELSE 'Stok Aman'
    END AS status_stok
FROM books;

SELECT genre_id, COUNT(*) AS total_buku
FROM books
GROUP BY genre_id;

SELECT genre_id, COUNT(*) AS total_buku
FROM books
GROUP BY genre_id
HAVING COUNT(*) > 1;

SELECT books.title, authors.name AS author_name, books.price
FROM books
LEFT JOIN authors ON books.author_id = authors.id;

SELECT transactions.order_number, transactions.total_amount, users.name AS customer_name
FROM transactions
LEFT JOIN users ON transactions.customer_id = users.id;

SELECT genres.name AS genre_name, books.title
FROM books
RIGHT JOIN genres ON books.genre_id = genres.id;

SELECT books.title, transactions.order_number, transactions.total_amount
FROM transactions
RIGHT JOIN books ON transactions.book_id = books.id;

CREATE VIEW vw_buku_author AS
SELECT books.title, authors.name AS author_name, books.price
FROM books
LEFT JOIN authors ON books.author_id = authors.id;
SELECT * FROM vw_buku_author;

CREATE VIEW vw_genre_buku AS
SELECT genres.name AS genre_name, books.title
FROM books
RIGHT JOIN genres ON books.genre_id = genres.id;
SELECT * FROM vw_genre_buku;