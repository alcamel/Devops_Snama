#!/usr/bin/env bash

# ===========================
# == MariaDB Backup Script ==
# ===========================

# === Global Variables ===
backup_dir="${BACKUP_DIR:-/home/devops/backup}"
log_file="${LOG_FILE:-/home/devops/backup_logs/backup.log}"
date="$(date +%y%m%d)"
keep_days="${KEEP_DAYS:-7}"

mysql_user="${MYSQL_USER:-}"
mysql_pass="${MYSQL_PASS:-}"
database_name="${DATABASE_NAME:-}"

# === Validate Required Variables ===
validate_variables() {
	if [[ -z "$mysql_user" || -z "$mysql_pass" || -z "$database_name" ]]; then
		echo "[$(date)] Error: Required environment variables (MYSQL_USER, MYSQL_PASS, DATABASE_NAME) are not set." | tee -a "$log_file"
		exit 1
	fi
}

# === Ensure Required Directories Exist ===
init_directories() {
	mkdir -p "$backup_dir"
	mkdir -p "$(dirname "$log_file")"
}

# === Check if `mariadb-dump` is Installed ===
check_mariadb_dump() {
	if ! command -v mariadb-dump &>/dev/null; then
		echo "[$(date)] Error: mariadb-dump command not found." | tee -a "$log_file"
		exit 1
	fi
}

# === Perform the Backup ===
perform_backup() {
	local backup_file="$backup_dir/${database_name}-${date}.sql.gz"
	mariadb-dump --user="$mysql_user" --password="$mysql_pass" --host=localhost --databases "$database_name" | gzip > "$backup_file"
	return $?
}

# === Log Backup Status ===
log_backup_status() {
	local status=$1
	if [[ "$status" -ne 0 ]]; then
		echo "[$(date)]  Backup failed for database: $database_name" | tee -a "$log_file"
	else
		echo "[$(date)]  Backup successful for database: $database_name" | tee -a "$log_file"
	fi
}

# === Cleanup Old Backups ===
cleanup_old_backups() {
	echo "[$(date)]  Deleting backups older than $keep_days days..." | tee -a "$log_file"
	find "$backup_dir" -type f -name "${database_name}-*.sql.gz" -mtime +"$keep_days" -exec rm -v {} \; >> "$log_file" 2>&1
}

# === Backup Routine ===
backup_mariadb() {
	echo "=====================================================================" | tee -a "$log_file"
	echo "[$(date)]  Starting backup for: $database_name" | tee -a "$log_file"
	
	validate_variables
	init_directories
	check_mariadb_dump
	perform_backup
	local status=$?
	log_backup_status "$status"
	cleanup_old_backups

	echo "[$(date)]  Backup process completed." | tee -a "$log_file"
	echo "=====================================================================" | tee -a "$log_file"
}

# === Main Entry Point ===
backup_mariadb
