from denormalized_models import Customer, Product, Purchase


def create_customer(session):
    customer = Customer()
    customer.customer_cpf = "cpf"
    customer.customer_email = "email"
    customer.customer_name = "name"
    customer.customer_zipcode = "zipcode"
    customer.customer_street = "street"
    session.add(customer)
    session.commit()
    session.flush()
    return customer


def create_product(session):
    product = Product()
    product.product_name = "product_name"
    product.product_brand_name = "product_brand_name"
    product.product_weight = "product_weight"
    product.product_size_description = "product_size_description"
    session.add(product)
    session.commit()
    session.flush()
    return product


def create_purchase(session):
    purchase = Purchase()
    purchase.product_id = 1
    purchase.customer_id = 1
    purchase.purchase_detail_status = "TEST"
    purchase.purchase_product_quantity = 1
    session.add(purchase)
    session.commit()
    session.flush()
    return purchase
