import psycopg2

with psycopg2.connect(database='org_mipt_atp_db', user='postgres', password='postgres', host='docker', port=49154) as conn:
    cur = conn.cursor()