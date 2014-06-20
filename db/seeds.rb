[
  ["Star Wars", "PG", "1977-05-02 00:00:00 UTC", "Star Wars is an American epic space opera franchise consisting of a film series created by George Lucas.", "1", "true"],
  ["Aladdin", "G", "1992-11-25 00:00:00 UTC", "Legend has it that only a person who is a 'diamond in the rough' can retrieve the lamp from the Cave of Wonders", "1", "false"],
  ["The Terminator", "R", "1984-10-26 00:00:00 UTC", "In the Terminator film series, a terminator is an autonomous robot, typically humanoid, originally conceived as a virtually indestructible soldier", "2", "false"],
  ["When Harry Met Sally", "R", "1989-07-21 00:00:00 UTC", "111111", "1", "true"],
  ["The Help", "PG-13", "2011-08-10 00:00:00 UTC", "222222", "1", "false"],
  ["Chocolat", "PG-13", "2001-01-05 00:00:00 UTC","333333", "2", "true"],
  ["Amelie", "R", "2001-04-25 00:00:00 UTC", "1", "4444", "1", "false"],
  ["2001: A Space Odyssey", "G", "1968-04-06 00:00:00 UTC", "121", "2", "true"],
  ["The Incredibles", "PG", "2004-11-05 00:00:00 UTC", "644", "3", "true"],
  ["Raiders of the Lost Ark", "PG", "1981-06-12 00:00:00", "5965", "1", "false"],
  ["Chicken Run", "G", "2000-06-21 00:00:00", "4695", "2", "false"]
].each do |(title, rating, date, description, user_id, published)|
  Movie.create! title: title, rating: rating, release_date: DateTime.parse(date), description: description, user_id: user_id, published: published
end

[
  ["123@mail.ru", "12345678", false],
  ["user@mail.ru", "12345678", false],
  ["admin@mail.ru", "12345678", true]
].each do |(email, password, admin)|
 User.create! email: email, password: password, admin: admin
end
