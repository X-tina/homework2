[
  ["Star Wars", "PG", "1977-05-02 00:00:00 UTC", "Star Wars is an American epic space opera franchise consisting of a film series created by George Lucas."],
  ["Aladdin", "G", "1992-11-25 00:00:00 UTC", "Legend has it that only a person who is a 'diamond in the rough' can retrieve the lamp from the Cave of Wonders"],
  ["The Terminator", "R", "1984-10-26 00:00:00 UTC", "In the Terminator film series, a terminator is an autonomous robot, typically humanoid, originally conceived as a virtually indestructible soldier"],
  ["When Harry Met Sally", "R", "1989-07-21 00:00:00 UTC"],
  ["The Help", "PG-13", "2011-08-10 00:00:00 UTC"],
  ["Chocolat", "PG-13", "2001-01-05 00:00:00 UTC"],
  ["Amelie", "R", "2001-04-25 00:00:00 UTC"],
  ["2001: A Space Odyssey", "G", "1968-04-06 00:00:00 UTC"],
  ["The Incredibles", "PG", "2004-11-05 00:00:00 UTC"],
  ["Raiders of the Lost Ark", "PG", "1981-06-12 00:00:00"],
  ["Chicken Run", "G", "2000-06-21 00:00:00"]
].each do |(title, rating, date)|
  Movie.create! title: title, rating: rating, release_date: DateTime.parse(date), description: description
end

[
  ["123@mail.ru", "12345678", false]
  ["user@mail.ru", "12345678", false]
  ["admin", "12345678", true]
].each do |email, password, admin|
 User.create! email: email, password: password, admin: admin
end
