1. Quelle est la différence entre un enregistrement A et un CNAME ?

Réponse : L’enregistrement A associe un nom de domaine à une adresse IP, tandis que le CNAME crée un alias pointant vers un autre nom déjà défini par un A.

2. Quelle commande permet de vérifier la liste des zones DNS existantes ?

Réponse : Get-DnsServerZone

3. Pourquoi utiliser un redirecteur dans un DNS d’entreprise ?

Réponse : Pour envoyer les requêtes non résolues en interne vers un serveur DNS externe, améliorant les performances et le contrôle.

4. Quelle est la différence entre une adresse IP dynamique et une réservation DHCP ?

Réponse : Une IP dynamique peut changer à chaque connexion, alors qu’une réservation DHCP attribue toujours la même IP à un poste précis.

5. Que se passe-t-il si deux serveurs DHCP répondent sur le même réseau ?

Réponse : Le client peut recevoir un bail du premier serveur, ce qui peut provoquer des conflits d’IP et des problèmes réseau.

6. Quelle commande PowerShell permet de visualiser les baux DHCP actifs ?

Réponse : Get-DhcpServerv4Lease