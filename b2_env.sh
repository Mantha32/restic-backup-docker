# B2 credentials.
# Extracted settings so both systemd timers and user can just source this when want to work on my B2 backup.
# See https://restic.readthedocs.io/en/latest/030_preparing_a_new_repo.html
# "<b2-account-id>"
#"<b2-account-key>"

export RESTIC_REPOSITORY="b2:testBucketAIT"
export RESTIC_PASSWORD_FILE="/etc/restic/b2_passwd.txt"
export B2_ACCOUNT_ID=""
export B2_ACCOUNT_KEY=""
