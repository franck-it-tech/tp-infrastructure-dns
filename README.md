# TP infrastructure DNS
#TP insfrastructure Réseau & DNS local (BIND9)
Architecture d'administration système déployée avc debian sous AWS EC2. l'objectif est de supprimer les adresses IP codées en dur pour faire communiquer les services via le domaine local 'neracomult.local'.

## 1. Plan d'adressage

| Machine | IP Privée | FQDN | Rôle |
| :--- | :--- | :--- | :--- |
| 'srv-dns' | '172.31.46.155' | 'dns.neracomult.local' | Serveur de noms principal BIND9 |
| 'srv-web' | '172.31.28.232' | 'portail.neracomult.local' | Serveur Web + client NFS / SFTP | 
| 'srv-nfs' | '172.31.17.126' | 'archives.neracomult.local' | Serveur de partage de fichiers NFS |
| 'srv-samba' | '172.31.31.18' | 'fichiers.neracomult.local' | Serveur de partage SMB/CIFS |
| 'srv-ftp' | '172.31.30.159' | 'backup.neracomult.local' | Serveur de stockage des sauvegardes SFTP |

## 2. Commandes de validation
* **Résolution directe :**
'''bash
dig backup.neracomult.local +short
#resultat attendu : 172.31.30.159

  **résolution dns inverse :**
dig -x 172.31.30.159 +short
# Resultat attendu : backup.neracomult.local.
  **Montage réseau NFS automatique :**
df -h /var/www/html/archives
# Résultat attendu : archives.neracomult.local:/srv/export/archives monté
  **Sauvegarde automatique :**
sudo /usr/local/bin/backup_web.sh
# Résultat attendu : Archivage et transfert SFTP sans erreur 
  **Résolution externe :**
dig google.com +short
# Résultat attendu : Résolution des IP publiques d'internet
* 
