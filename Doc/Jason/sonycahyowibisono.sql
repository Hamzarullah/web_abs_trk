INSERT INTO EVENT
(NAME, DATE, TYPE, remark)
VALUE
('Fluffy', '1995-05-15', 'litter', '4 kittens, 3 female, 1 male'),
('Buffy', '1995-05-15', 'litter', '5 puppies, 2 female, 3 male'),
('Buffy', '1995-05-15', 'litter', '3 puppies, 3 female'),
('Chirpy', '1995-05-15', 'litter', 'needed beak straightened')

LOAD DATA LOCAL INFILE 'E://Book1.txt'
INTO TABLE EVENT

