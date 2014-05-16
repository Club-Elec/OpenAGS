# Administration Borne d'arcade 
## club élec ISEN Brest

### Partie électronique
La borne se compose d'un PC, d'une TV cathodique, et d'un vieux clavier PS/2 sur lequel ont été soudés les boutons et les joysticks. Le problème d'utiliser une matrice de clavier est sue le nombre d'inputs simultanées est limitées, ce qui fait que si il y a trop de boutons appuyés en même temps les contrôles se bloquent, ce type de problème peut apparaître pour des jeux comme SuperTuxKart. De plus les soudures ne sont pas particulièrement propres, ce qui peut entraîner des courtcircuits de temps à autre.

Le PC communique avec la TV grâce à l'ajout d'une arte graphique comportant une sortie S-vidéo. Le problème est que si le pc lâche on est obligé de retrouver ue carte graphique avec une sortie S-vidéo. Pour contrer ce problème il faudrait investir dans un adaptateur vga- vers S-video ou péritel.

 Au démarrage de la borne la TV est sur la mauvaise chaîne, il faut donc avec un fil de fer ou un trombone appuyer sur le bouton de changement de chaine grâce au trou en façade juste en dessous de l'écran. De plus des fois , lors d'une longue période d'inactivité, la TV se met en veille, il faut alors tirer la borne et appuyer sur un de ces bouutons (non désolé le bouton
de changement de chaîne ne permet pas de réveiller la TV , on est obligé de tirer la borne pour accéder aux autres boutons)

A l'intérieur de la borne se trouve aussi les enceintes, hors ce systeme comprend un transformateur 220V qui est signalé mais n'est que partielement isolé. Il faut donc être particulièrement vigilant quand on est à l'intérieur de la borne et que celle-ci est en marche.
 Enfin interrupteur à été rajouté sur le côté pour rendre son allumage et son extinction plus aisée. Ce dernier est relié à une multiprise sur laquelle sont branché la TV, le PC et les enceintes, il est donc préférable de ne pas brancher la borne sur une multiprise en cascade.

### Le meuble
Le meuble en lui-même a été fabriqué à partir de planches d'aggloméré de 19 mm assemblés avec des tasseaux de 45mm et des vis. Les coins sont protégés par des cornières cloutées et collés car l'aggloméré a tendance à s'effritter sur les bord avec le temps. La TV pesant 40 kg, elle repose sur une poutre de 50*50 mm et des tasseaux. 
Le fond a été surrelevé pour pouvoir installer des roulettes en dessous afin de rendre son transport plus facile. De plus, à l'intérieur de la borne se trouve une planche avec des roulettes, cette dernière est à glisser en dessous de la borne pour pouvoir la transporter encore plus facilement (pour la glisser en dessous il faut incliner légèrement la borne veers l'avant). Pour finir sur le transport de la borne, une corde à été prévue, il suffit de l'insérer dans les trous en bas de la face avant, cela permet de tirer la borne plus facilement.

### Partie informatique
Le PC tourne sous Arch Linux 32 bits car il est relativement vieux et cette distribution est suffisament légère et modulable. Comme aucun sélecteur de jeux ne parraissait satisfaisant, un programme à été spécialemet créer pour la borne, il s'agit d'OpenAGS (Open Arcade Game Selector), Ce dernier à été développé par Thibaut et Thomas en langage D avec la SFML, pour plus d'information vous pouvez consulter les source sur [github](https://github.com/CromFr/OpenAGS).

Le mapping des touches a été effectué grâce à la commande xmodmap et la configuration de l'écran avec xrandr. Les jeux proposés sont tous en open-source ou au moins disponibles gratuitements.	
La borne est accessible en ssh à l'adresse 172.18.5.157 avec le login et password comme le pc du club élec.

### Utilisation de OpenAGS
Chaque jeux disponible sur la borne est dans de dossier `/home/clubelec/OpenAGS/games/ `. Les jeux non disponibles qui ne fonctionnent pas se trouvent dans de dossier `/home/clubelec/OpenAGS/games_disabled/`.

### Tuto: installer et linker un jeu avec OpenAGS

attention: certaines commandes ci-dssous demande d'être root ou au moins sudoer, il faudra donc des fois se mettre en root (`su` + mot de passe) ou mettre `sudo` devant la commande à effectuer.

#### 1 - installer le jeu sur ArchLinux
Pour cela on peut installer grâce au packet manager Pacman ou Yaourt. Premièrement il faut vérifier que le jeux est présent dans les dépôts officiels (avec Pacman) ou dans ceux de la communautée (avec Yaourt), pour cela on fait: 
```bash
pacman -Ss nom_jeu
```
ou
```bash
yaourt -Ss nom_jeu
```

une fois le nom exact du jeu rouvé on peut l'installer en faisant:
```bash
pacman -S nom_jeu
```
ou
```bash
yaourt -S nom_jeu
```
il ne reste plus qu'à trouver l'éxecutable qui souvent est dans le dossier `/sbin/`


l'autre méthode consiste à télécharger le jeu sur son PC et le copier sur la borne en SSH avec la commande:
```bash
scp dossier_jeu clubelec@172.18.5.157:/home/clubelec/game_build/
```

Attention avant d'aller plus loin, il faut tester si le jeux fonctionne!

#### 2 - linker le jeux avec OpenAGS

Il faut se placer dans le dossier `/home/clubelec/OpenAGS/games/ ` grâce à la commande:
```bash
cd /home/clubelec/OpenAGS/games/
```
puis on doit créer le répertoire:
```bash
mkdir dossier_jeu
```
on se place dans ce dossier:
```bash
cd dossier_jeu
```
et on crée les 3 fichiers nécessaires à OpenAGS:

- start.sh
- description.txt
- game.ini

Pour créer ou éditer ces fichiers on peut utiliser l'éditeur de texte nano:
```bash
sudo nano fichier_a_éditer
```
ou vim 
```bash
sudo vim fichier_a_éditer
```

à noter que si on éxecute cette commande et que le fichier à éditer n'existe pas, il va se créer automatiquement.
Aussi nano est peut-être plus facile à utiliser pour les débutants car les commandes sont afficées en bas de l'écran mais si vous voulez utiliser vim, vous pouvez apprendre comment l'utiliser avec la commande ` vimtutor `

le premier (start.sh) est le script que lancera OpenAGS lors de l'appui sur le boutton "jouer" du jeux.
(exemple pour le jeux dink)

```bash
#!/bin/bash
echo "Game started..."

#on charge le mappage des touches pour le jeux (si besoin)
xmodmap xmodmap_dink

#on lance l'éxécutable du jeux
./gamedir/bin/dink

#quand le jeux est quitté on revient au
#mappage normal pour que OpenAGS s'y retrouve
xmodmap ~/xmodmaprc
```

le deuxième fichier (description.txt) contient les infos qui seront montrés sur l'écran de sélection

```bash
Un bon petit RPG comme on faisait plein avant !
```

Le dernier fichier (game.ini), contient le reste des infos sur le jeux (nb de joueurs, titre, genre)
à noter que savesenabled doit toujours être égal à false car on ne peut pas sauvegarder sur la borne.

```bash
[game]
name=Dink Smallwood
savesenabled=false
gametype=RPG
players=1
```

une fois finit, pour que les modifications soient prises en compte il faut redémarrer le serveur X.org (attention il faut être root ou faire un sudo):
```bash
kill X #+Tab
```
ou 
```bash
#obtenir le PID de X avec la commande top
top
#et tuer ce processus
kill numéro_processus_X
```

ou alors on peut redémarer la borne:
```bash
sudo reboot
```

#### 2 - mapper les touches avec la commande xmodmap
Comme vous l'avez peut-êre remarqué, dans le fichier start.sh se trouve la commande `xmodmap xmodmaprc_nom_du _jeu `, cela permet de définir les boutons d'action pour le jeu quand cela n'est pas possible directement dans celui-ci.
Pour faire cela, on crée le fichier xmodmaprc_nom_du_jeu  dans le dossier du jeu:
```bash 
cd ~/OpenAGS/games/dossier_jeu/
vim xmodmaprc_nom_du _jeu
```

ce fichier doit être remplit comme ci-dessous:
```bash 
keycode 56 = y

keycode 14 = Left
keycode 13 = Right
keycode 11 = Up
keycode 27 = Down

keycode 26 = a
keycode 54 = z
keycode 53 = e
keycode 52 = q
keycode 39 = s
keycode 25 = d

keycode 24 = Return
keycode 49 = Escape

keycode 55 = i
keycode 42 = j
keycode 57 = k
keycode 29 = l

keycode 38 = f
keycode 10 = g
keycode 40 = h
keycode 94 = v
keycode 65 = b
keycode 28 = n
```
le keycode est fixe mais la touche qui lui est attribué peut être changée.
L'exemple ci-dessus est le mappage de base qui est `~/xmodmaprc`.

le keycode 56 est le bouton vert à gauche sur le côté de la borne

14, 13, 11 et 27 sont ceux assigné au joystick gauche (joueur 1)

26, 54, 58, 52, 39, 25 sont les 6 boutons à gauche (joueur 1)

55, 42, 57, 29 correpondent au joystick droit (joueur 2)

38, 10, 40, 94, 65, 28 sont les 6 boutons de droite (joueur 2)

enfin les keycodes 24 et 49 correspondest aux boutons rouges au centre du panel.

à noter que le bouton vert à droite à le même keycode (42) qu'un axe du joystick droit (erreur de conception, désolé).
On ne peut donc pas utiliser le joystick droit en même temps que le bouton vert de droite






##Conclusion 

En ésperant que ce document vous soit utile
bon courage!

pour tout problème ne pas hésiter contacter Corentin Raoult (promo 2015 ou 2016), 

ou sinon [Thibaut Charles](https://github.com/CromFr/) et [Thomas Abot](https://github.com/triskell) (promo 2015) et Victor Dorez (promo 2016)
