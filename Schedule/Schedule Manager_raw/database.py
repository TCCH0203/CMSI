import pandas as pd
import sqlite3
import os
import sys

# =========================
# FIXED BASE DIRECTORY
# =========================
if getattr(sys, 'frozen', False):
    BASE_DIR = os.path.dirname(sys.executable)
else:
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# =========================
# PATHS
# =========================
EXCEL_PATH = os.path.join(BASE_DIR, "asset", "database.xlsx")
DB_PATH = os.path.join(BASE_DIR, "database.db")

# =========================
# IMPORT DATABASE
# =========================
def import_database():
    print("🔥 START database import")

    try:
        print("EXCEL:", EXCEL_PATH)
        print("DB:", DB_PATH)

        if not os.path.exists(EXCEL_PATH):
            print("❌ database.xlsx NOT FOUND")
            return

        df = pd.read_excel(EXCEL_PATH)

        print("Rows:", len(df))

        conn = sqlite3.connect(DB_PATH)
        df.to_sql("database", conn, if_exists="replace", index=False)
        conn.commit()
        conn.close()

        print("✅ DATABASE DONE")

    except Exception as e:
        print("❌ DATABASE FAILED:", e)
        import traceback
        traceback.print_exc()