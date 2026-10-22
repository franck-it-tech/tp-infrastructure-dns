#!!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="/tmp/backup_nginx_$DATE.tar.gz"

#archivage configuration et logs
tar -czf "$BACKUP_FILE" /etc/nginx /var/log/nginx

#transfert SFTP vers le serveur de backup via FODN
sftp -b - backup-user@backup.neracomult.local << EOF
cd srv-web
put $BACKUP_FILE 
bye
EOF

#nettoyage temporaire
rm -f "$BACKUP_FILE"
