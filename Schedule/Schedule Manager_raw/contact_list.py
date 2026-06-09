import pandas as pd
import sqlite3
import os
import sys
import traceback

# =========================
# BASE DIRECTORY
# =========================
if getattr(sys, 'frozen', False):
    BASE_DIR = os.path.dirname(sys.executable)
else:
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# =========================
# PATHS
# =========================
EXCEL_PATH = os.path.join(BASE_DIR, "contact_list.xlsx")
DB_PATH = os.path.join(BASE_DIR, "database.db")

# =========================
# IMPORT CONTACT LIST
# =========================
def import_contact_list():
    print("🔥 START contact_list import")

    try:
        print("EXCEL:", EXCEL_PATH)
        print("DB:", DB_PATH)

        if not os.path.exists(EXCEL_PATH):
            print("❌ Excel NOT FOUND")
            return

        df = pd.read_excel(EXCEL_PATH)

        print("Rows:", len(df))

        conn = sqlite3.connect(DB_PATH)
        df.to_sql("Contact_list", conn, if_exists="replace", index=False)
        conn.commit()
        conn.close()

        print("✅ Contact_list DONE")

    except Exception as e:
        print("❌ CONTACT LIST FAILED:", e)
        import traceback
        traceback.print_exc()