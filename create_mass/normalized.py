from normalized_models import (
    Brand,
    CustomerAddres,
    ProductSize,
    WeightUnit,
    Customer,
    Product,
    Weight,
    Purchase,
    PurchaseDetailStatu,
    PurchaseDetail,
)
import utils


brand_pool = []
product_size_pool = []
weight_unit_pool = []
weight_pool = []
product_pool = []
customer_pool = []
purchase_detail_pool = []
purchase_detail_status_pool = []


def _get_value_from_pool(pool):
    new = len(pool) > 0 and utils.get_random_int(1) == 0
    if new is True:
        index = utils.get_random_index(pool)
        return pool[index]
    return None


# _______________________________________________________________________________________
#
# _______________________________________________________________________________________
def create_customer(session):
    customerAddres = CustomerAddres()
    customerAddres.customer_address_zipcode = utils.get_random_string(12)
    customerAddres.customer_address_street = utils.get_random_string(80)
    session.add(customerAddres)
    session.flush()
    customer = Customer()
    customer.customer_created = utils.get_random_date_create()
    customer.customer_cpf = utils.get_random_string(13)
    customer.customer_email = utils.get_random_string(60)
    customer.customer_name = utils.get_random_string(80)
    customer.customer_address = customerAddres
    customer_pool.append(customer)
    session.add(customer)
    session.commit()
    session.flush()
    return customer, customerAddres


# _______________________________________________________________________________________
#
# _______________________________________________________________________________________
def create_product(session):
    weight_unit = create_weight_unit(session)
    weight = create_weight(session, weight_unit)
    brand = create_brand(session)
    product_size = create_product_size(session)
    product = Product()
    product.brand = brand
    product.weight = weight
    product.product_size = product_size
    product.product_name = utils.get_random_string(100)
    product_pool.append(product)
    session.add(product)
    session.commit()
    session.flush()
    return brand, product_size, weight_unit, weight, product


def create_brand(session):
    global brand_pool
    new = _get_value_from_pool(brand_pool)
    if new is not None:
        return new
    brand = Brand()
    brand.brand_name = utils.get_random_string(80)
    brand_pool.append(brand)
    session.add(brand)
    session.commit()
    return brand


def create_product_size(session):
    global product_size_pool
    new = _get_value_from_pool(product_size_pool)
    if new is not None:
        return new
    product_size = ProductSize()
    product_size.product_size_description = utils.get_random_string(150)
    product_size_pool.append(product_size)
    session.add(product_size)
    session.commit()
    return product_size


def create_weight_unit(session):
    global weight_unit_pool
    new = _get_value_from_pool(weight_unit_pool)
    if new is not None:
        return new
    weight_unit = WeightUnit()
    weight_unit.weight_unit = utils.get_random_string(5)
    weight_unit_pool.append(weight_unit)
    session.add(weight_unit)
    session.commit()
    return weight_unit


def create_weight(session, weight_unit):
    global weight_pool
    new = _get_value_from_pool(weight_pool)
    if new is not None:
        return new
    weight = Weight()
    weight.weight_unit = weight_unit
    weight.weight_value = utils.get_random_string(10)
    session.add(weight)
    weight_pool.append(weight)
    session.commit()
    return weight


# _______________________________________________________________________________________
#
# _______________________________________________________________________________________
def create_purchase(session):
    customer = utils.get_random_item(customer_pool)
    product = utils.get_random_item(product_pool)
    purchase = Purchase()
    purchase.purchase_created = utils.get_random_date_update()
    purchase.purchase_updated = utils.get_random_date_create()
    session.add(purchase)

    purchase_detail_status = create_purchase_detail_status(session)
    purchase_detail = create_purchase_detail(
        session, customer, product, purchase, purchase_detail_status
    )
    session.commit()
    session.flush()
    return purchase, purchase_detail, purchase_detail_status


def create_purchase_detail(
    session, customer, product, purchase, purchase_detail_status
):
    global purchase_detail_pool
    new = _get_value_from_pool(purchase_detail_pool)
    if new is not None:
        return new
    purchase_detail = PurchaseDetail()
    purchase_detail.customer = customer
    purchase_detail.product = product
    purchase_detail.purchase_detail_status = purchase_detail_status
    purchase_detail.purchase = purchase
    purchase_detail.purchase_detail_product_quantity = utils.get_random_int(10)
    purchase_detail_pool.append(purchase_detail)
    session.add(purchase_detail)
    session.commit()
    return purchase_detail


def create_purchase_detail_status(session):
    global purchase_detail_status_pool
    new = _get_value_from_pool(purchase_detail_status_pool)
    if new is not None:
        return new    
    purchase_detail_status = PurchaseDetailStatu()
    purchase_detail_status.purchase_detail_status = utils.get_random_status()
    purchase_detail_status_pool.append(purchase_detail_status)
    session.add(purchase_detail_status)
    session.commit()
    #session.flush()
    return purchase_detail_status

