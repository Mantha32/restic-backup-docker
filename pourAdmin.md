# AIT presentation sur Backpblade et Cashplane

### Introduction
[quick overview pour backblaze](https://bit.ly/2DugU5Y)
[comparaison rapide](https://bit.ly/2D89JzA)

### 1. Prix

### 2.La facilité d'utilisation: Rapidité de la sauvegarde
  
#### 2.1 Rapidité de la restauration 
#### 2.2 Charge de la sauvegarde sur le client
### 3. Automatisation
#### 3.1 Integration dans backblaze
Backplabe offre un API en CLI pour adminsitrer les comptes et les stockages. Mais il permet aussi d'integrer une solution tiers pour admnistrer les backup des utilisateurs. Backblaze ne fournit pas d'application d'integration. Concernant l'automatisation du backup, le tier [restic](https://bit.ly/2ASaATh) est une application de backup open source qui permet  de creer de script d'automatisation. Le script ci-dessous est une exemple pour faire une backup et restaurer celle-ci.
``` script
export B2_ACCOUNT_ID=<MY_ACCOUNT_ID>
export B2_ACCOUNT_KEY=<MY_SECRET_ACCOUNT_KEY>

#nom unique de bucket dans backblaze
export RESTIC_REPOSITORY="b2:my-restic-backup"

#restic password!
export RESTIC_PASSWORD_FILE="restic-pw.txt"

restic -r b2:bucketname:path/to/repo init

# backup par exemple $HOME
restic -r b2:my-restic-backup backup ~

#list des snapshot
restic -r b2:my-restic-backup snapshots

# creation d'un nouveau backup 
restic -r b2:my-restic-backup backup ~

#restore backup with specifique snapsho id backup 
restic -r b2:my-restic-backup restore  9a83a611 -t /tmp/restic-restore 
```
On peut aussi deployer ce script sur chaque machine dans l'infrastructure. 
``` script
# utilsation Perl and Net::OpenSSH dans un UNIX, ou putty pour Windows
my $ssh = Net::OpenSSH->new($host, user => $user, password => $password);
my $sftp = $ssh->sftp;
$sftp->put("/local/path/to/script", "bin/back_up.sh"); # => ~/bin/back_up
$sftp->chmod("bin/back_up.sh", 0755);
$ssh->system({stdout_file => '/tmp/notification.out'}, "bin/back_up.sh");
```
Pour les tiers graphiques, on peut citer [cloudBerry Lab](https://www.cloudberrylab.com/) qui gère backblaze.De plus, cette application offre une API CLI couplé avec son GUI. Cette solution d'integration est bien entendu payant comme la plus part des tiers d'inegration qui figurent dans le site de backblaze.

#### 3.1 Integration dans crashplan
Crashplan n'as pas besoins de la couche d'integration. Il offre ces services de base via une [application](https://bit.ly/2AVsSmP) dediée. Tout les operations liées au backup sont disponible sur l'application. L'application est multiplateforme. La restaration peut se faire sur n'importe autre ordinateur. L'automatisation du backup est en continu et intégré dans le service de base.

### 4. Documentation

|                          Backblaze                       			| source | Payant |
| ------------------------------------------------------------ | --------------------------- | ------ |
| La document officiel assez basique sur le backblaze et sur l'API d'oprations   | document officiel sur du site de [backblaze](https://bit.ly/2woRAa8)                       | non |
| help desk fournit un pléthore d'information sur l'exploitation du backblaze suivant la solution d'integration choisit par exemple le choix de [restic](https://bit.ly/2DtuI0x) |  [help desk](https://bit.ly/2D7mMkN)                  | non |
| le blog offre une documentation complémentaire au help desk en ligne | document                      | non |


|                          Crashplan                     			| source | Payant |
| ------------------------------------------------------------ | --------------------------- | ------ |
| La document officiel claire  et bien organisé.                  | [support](https://support.code42.com/) | non


### 5. Le support technique
Le support technique est gratuit pour le service [B2](https://www.backblaze.com/b2/b2-support.html) de base de backblaze.
Le support de crashplan est gratuit pour l'offre "crashplan for small business". [source](https://bit.ly/2yXptT4) 


### 6. Le scalabilité
#### 6.1 Backblaze
Pour le type d'offre personnel, le stockage est illimité dont le prix est fixe. L'offre businesse et B2 sont aussi illimité mais le prix mensuel , annuel ou biannuel est au prorata de la taille des données stocker. 
### 6.2 Crashplan
Le prix mensuel ou annuelest en fonction du volume de données stocker.

### 7.le déploiement —> facilité d'installation, compatibilité avec le système qu'on doit sauvegarder, monitoring (besoins pour  admin)
### 8. Securité : confidentialité, fiabilité


### 9. Facilité d'administration

