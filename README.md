# Sakila-Yesod

This is an example web application example that uses the [MySQL Sakila sample database](https://dev.mysql.com/doc/sakila/en/) and the Haskell web framework [Yesod](http://www.yesodweb.com/).

It is a classic CRUD application, meaning that it does Create, Update and Delete records from the database.

To run it, you need to have [stack](https://docs.haskellstack.org/en/stable/README/) installed.
Also, you need to have a running MySQL instance and the Sakila database in it.
You have to put the usual database settings (hostname, port, database name, user, password) in the `config/settings.yml` file.

You can run it by typing:

     stack exec -- yesod devel
