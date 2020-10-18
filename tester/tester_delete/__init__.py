from tqdm import tqdm
from sqlalchemy import update
from datetime import datetime


def denormalized(session, MAX):
    from denormalized_models import (
        Customer,
        Product,
        Purchase,
    )

    for i in tqdm(range(MAX), desc=f"denormalized::delete"):
        id = i + 1
        try:
            customer = session.query(Customer).get(id)
            session.delete(customer)
        except:
            pass
        try:
            product = session.query(Product).get(id)
            session.delete(product)
        except:
            pass
        try:
            purchase = session.query(Purchase).get(id)
            session.delete(purchase)
        except:
            pass
        # session.commit()


def normalized(session, MAX):
    from normalized_models import (
        Customer,
        Product,
        Purchase,
    )

    update(session, MAX, "normalized", Customer, Product, Purchase)


def update(session, MAX, title, Customer, Product, Purchase):
    for i in tqdm(range(MAX), desc=f"{title}::delete"):
        id = i + 1
        id = 6
        customer = session.query(Customer).get(id)
        session.delete(customer)
        product = session.query(Product).get(id)
        session.delete(product)
        purchase = session.query(Purchase).get(id)
        session.delete(purchase)
        session.commit()


def run(session, MAX):
    # normalized(session, 1)
    denormalized(session, 1)

