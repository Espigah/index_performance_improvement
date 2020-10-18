from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import logging
import normalized
import denormalized
import tester_select
import tester_create
import tester_delete
import tester_update
from tqdm import tqdm

MAX = 3000

logging.basicConfig(filename="info.log", level=logging.INFO)
logging.basicConfig(filename="error.log", level=logging.ERROR)
engine = create_engine("postgresql://postgres:postgres@localhost:5432/postgres")
engine.connect()
Session = sessionmaker(bind=engine)
session = Session()



# print(session.execute("SELECT * FROM denormalized.active_clients_last_year;"))

def print_size(schema):
    print(schema,session.execute(f"select pg_size_pretty(pg_schema_size('{schema}'));").first())
    pass

def print_size_denormalized():
    print_size('denormalized')

def print_size_normalized():
    print_size('normalized')
print("-----------------------------------------------------------------------------------")
print_size_denormalized()
print_size_normalized()
tester_select.run(session, MAX)
tester_update.run(session, int(8448))
###tester_delete.run(session, 1) @TODO
tester_create.run(session, int(8448))
print_size_denormalized()
print_size_normalized()
session.close()
print("_______________________________________________________________________________________")