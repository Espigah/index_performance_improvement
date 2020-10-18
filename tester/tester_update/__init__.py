from tqdm import tqdm
from sqlalchemy import update
from datetime import datetime


def denormalized(session, MAX):
    from denormalized_models import (
        Customer,
        Product,
        Purchase,
    )

    update(session, MAX, "denormalized", Customer, Product, Purchase)


def normalized(session, MAX):
    from normalized_models import (
        Customer,
        Product,
        Purchase,
    )

    update(session, MAX, "normalized", Customer, Product, Purchase)


def update(session, MAX, title, Customer, Product, Purchase):
    for i in tqdm(range(MAX), desc=f"{title}::update"):
        id = i + 1
        try:
            customer = session.query(Customer).get(id)
            customer.customer_name = f"customer_name #{id}"
            product = session.query(Product).get(id)
            product.product_name = f"product_name #{id}"
            purchase = session.query(Purchase).get(id)
            purchase.purchase_updated = datetime.now()
            session.commit()
        except Exception as identifier:
            pass


def run(session, MAX):
    normalized(session, MAX)
    denormalized(session, MAX)


