import csv

# def read_csv(csvfilename):
#   """
#   Read .csv file.
#   - file: the .csv file with the full path
#   """
#   rows = []
#   with open(csvfilename, encoding='utf-8') as csvfile:
#     file_reader = csv.reader(csvfile)
#     for row in file_reader:
#       rows.append(row)
#   return rows

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

def generate_insert_statements(table_name, limit=None):
  for row in read_csv(table_name, limit)[1:]:
    print(f"""INSERT INTO table VALUE ('{"', '".join(row)}');""")
