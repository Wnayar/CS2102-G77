from utils import generate_insert_statements

# from command line run
#python menu_process.py >> insert_statements.txt
ORDER_LIMIT_ROWS = 100

for table_name in ['menu.csv', 'registration.csv', 'staff.csv', 'order.csv']:
    if table_name =='order.csv':
        generate_insert_statements(table_name, ORDER_LIMIT_ROWS)
    else:    
        generate_insert_statements(table_name)
