# README

This README would normally document whatever steps are necessary to get the
application up and running.
Counter Cache

# https://blog.appsignal.com/2018/06/19/activerecords-counter-cache.html
La ligne de code `belongs_to :article, counter_cache: true` que vous trouvez dans le modèle `Like` indique l'utilisation d'une fonctionnalité appelée "counter cache" avec l'association `belongs_to`.

Lorsque vous utilisez `counter_cache: true` dans une association `belongs_to`, Rails automatise la gestion d'un compteur associé à l'association. Dans ce cas particulier, le modèle `Like` appartient à la fois à l'utilisateur (`user`) et à l'article (`article`). Le `counter_cache` est associé à l'association avec `:article`.

En utilisant cette fonctionnalité, Rails met à jour automatiquement un attribut `likes_count` sur l'objet `Article` chaque fois qu'un nouveau `Like` est créé ou supprimé pour cet article. Cela élimine la nécessité de compter manuellement les likes associés à un article à chaque fois qu'un like est ajouté ou retiré.

Par exemple, si vous avez une colonne `likes_count` dans votre table d'articles, chaque article maintiendra automatiquement le nombre actuel de likes associés. Cela est utile lorsqu'il s'agit de récupérer rapidement le nombre de likes sans avoir à parcourir toutes les entrées de la table `Like` liées à un article.

En résumé, `belongs_to :article, counter_cache: true` est une option pratique pour maintenir automatiquement un compteur de likes associés à un article, améliorant les performances en évitant de devoir compter manuellement les likes à chaque requête.


Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# ======================================
Crée un Blog de Post
Model Post, name 
Qu'est ce qu'un slug

Model Comment name
La gestion des user
Model User name email password 
Un commentaire peut référencé un article ou un autre commentaire 

# =====================================
