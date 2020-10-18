from denormalized_models import Customer, Product, Purchase


def create_customer(session, _customer, _customer_addres):
    customer = Customer()
    customer.customer_id = _customer.customer_id
    customer.customer_cpf = _customer.customer_cpf
    customer.customer_email = _customer.customer_email
    customer.customer_name = _customer.customer_name
    customer.customer_zipcode = _customer_addres.customer_address_zipcode
    customer.customer_street = _customer_addres.customer_address_street
    customer.customer_created = _customer.customer_created
    session.add(customer)
    session.commit()
    session.flush()
    return customer


def create_product(session, _brand, _product_size, _weight_unit, _weight, _product):
    product = Product()
    product.product_id = _product.product_id
    product.product_name = _product.product_name
    product.product_brand_name = _brand.brand_name
    product.product_weight = _weight.weight_value + " " + _weight_unit.weight_unit
    product.product_size_description = _product_size.product_size_description
    session.add(product)
    session.commit()
    session.flush()
    return product


def create_purchase(session, _purchase, _purchase_detail, _purchase_detail_status):
    purchase = Purchase()
    purchase.purchase_id = _purchase.purchase_id
    purchase.purchase_created = _purchase.purchase_created
    purchase.purchase_updated = _purchase.purchase_updated
    purchase.product_id = _purchase_detail.product_id
    purchase.customer_id = _purchase_detail.customer_id
    purchase.purchase_detail_status = _purchase_detail_status.purchase_detail_status
    purchase.purchase_product_quantity = _purchase_detail.purchase_detail_product_quantity
    session.add(purchase)
    session.commit()
    session.flush()
    return purchase
