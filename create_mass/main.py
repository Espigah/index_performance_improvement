from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import logging
import normalized
import denormalized
from tqdm import tqdm

CUSTOMERS = 1000 * 1
PRODUCTS = 1000 * 1
PURCHASES = 1000 * 1

logging.basicConfig(filename="info.log", level=logging.INFO)
logging.basicConfig(filename="error.log", level=logging.ERROR)
engine = create_engine("postgresql://postgres:postgres@localhost:5432/postgres")
engine.connect()
Session = sessionmaker(bind=engine)
session = Session()


def create_customer(session):
    Customer, CustomerAddres = normalized.create_customer(session)
    denormalized.create_customer(session, Customer, CustomerAddres)


def create_product(session):
    (Brand, ProductSize, WeightUnit, Weight, Product) = normalized.create_product(
        session
    )
    denormalized.create_product(
        session, Brand, ProductSize, WeightUnit, Weight, Product
    )


def create_purchase(session):
    purchase, purchase_detail, purchase_detail_status = normalized.create_purchase(
        session
    )
    denormalized.create_purchase(
        session, purchase, purchase_detail, purchase_detail_status
    )


for i in tqdm(range(CUSTOMERS)):
    try:
        create_customer(session)
    except Exception as e:
        logging.info(f"[ create_customer ] {i} / {CUSTOMERS}")
        logging.error(e)
        pass

for i in tqdm(range(PRODUCTS)):
    try:
        create_product(session)
    except Exception as e:
        logging.info(f"[ create_product ] {i} / {PRODUCTS}")
        logging.error(e)
        pass

for i in tqdm(range(PURCHASES)):
    try:
        create_purchase(session)
    except Exception as e:
        logging.info(f"[ create_purchase ] {i} / {PURCHASES}")
        logging.error(e)
        pass
