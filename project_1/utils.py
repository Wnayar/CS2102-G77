import csv

def read_csv(csvfilename, limit=None):
    """
    Read .csv file.
    - file: the .csv file with the full path
    - limit: maximum number of data rows to read (excluding header). None = all rows
    """
    rows = []
    with open(csvfilename, encoding='utf-8') as csvfile:
        file_reader = csv.reader(csvfile)
        count = -1 #account of header row

        for row in file_reader:
            if limit is not None and count >= limit:
                break
            rows.append(row)
            count += 1
    return rows

def generate_insert_statements(table_name, TABLE_MAP_STAGING, limit=None):
  for row in read_csv(table_name, limit)[1:]:
    # map table name to staging table name
    # stg_menu to 'menu.csv'        
    # stg_registration to 'registration.csv'
    # stg_staff to 'staff.csv'    
    # stg_order to 'order.csv'  
    staging_table_name =  TABLE_MAP_STAGING.get(table_name)
    print(f"""INSERT INTO {staging_table_name} VALUES ('{"', '".join(row)}');""")
