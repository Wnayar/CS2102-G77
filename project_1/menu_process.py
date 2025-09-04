from utils import generate_insert_statements

# from command line run
#python menu_process.py >> insert_statements.txt

ORDER_LIMIT_ROWS = 100
GIVEN_TABLES = ['menu.csv', 'registration.csv', 'staff.csv', 'order.csv']
TABLE_MAP_STAGING = {
    "menu.csv": "stg_menu",
    "registration.csv": "stg_registration",
    "staff.csv": "stg_staff",
    "order.csv": "stg_order"
}

for table_name in GIVEN_TABLES:
    if table_name =='order.csv':
        generate_insert_statements(table_name, TABLE_MAP_STAGING, ORDER_LIMIT_ROWS)
    else:    
        generate_insert_statements(table_name, TABLE_MAP_STAGING)
