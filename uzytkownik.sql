CREATE USER 'piabd_php'@'localhost' IDENTIFIED BY 'PHP_PIABD';
GRANT INSERT, SELECT, UPDATE ON piabd_php.* TO 'piabd_php'@'localhost';
FLUSH PRIVILEGES;
