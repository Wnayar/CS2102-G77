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
    # replace single quotes in the data with doubled quotes, to escape single quotes in names etc from closing early
    safe_row = [col.replace("'", "''") for col in row] 
    staging_table_name =  TABLE_MAP_STAGING.get(table_name)
    print(f"""INSERT INTO {staging_table_name} VALUES ('{"', '".join(safe_row)}');""")
