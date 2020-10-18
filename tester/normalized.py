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


# _______________________________________________________________________________________
#
# _______________________________________________________________________________________
def create_customer(session):
    customerAddres = CustomerAddres()
    customerAddres.customer_address_zipcode = "zipcode"
    customerAddres.customer_address_street = "street"
    session.add(customerAddres)
    session.flush()
    customer = Customer()
    customer.customer_cpf = "cpf"
    customer.customer_email = "email"
    customer.customer_name = "name"
    customer.customer_address = customerAddres
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
    product.product_name = "product_name"
    session.add(product)
    session.commit()
    session.flush()
    return brand, product_size, weight_unit, weight, product


def create_brand(session):
    brand = Brand()
    brand.brand_name = "brand_name"
    session.add(brand)
    session.commit()
    return brand


def create_product_size(session):
    product_size = ProductSize()
    product_size.product_size_description = "product_size_description"
    session.add(product_size)
    session.commit()
    return product_size


def create_weight_unit(session):
    weight_unit = WeightUnit()
    weight_unit.weight_unit = "1234"
    session.add(weight_unit)
    session.commit()
    return weight_unit


def create_weight(session, weight_unit):
    weight = Weight()
    weight.weight_unit = weight_unit
    weight.weight_value = utils.get_random_string(10)
    session.add(weight)
    session.commit()
    return weight


# _______________________________________________________________________________________
#
# _______________________________________________________________________________________
def create_purchase(session):
    purchase = Purchase()
    session.add(purchase)
    purchase_detail_status = create_purchase_detail_status(session)
    purchase_detail = create_purchase_detail(session, purchase, purchase_detail_status)
    session.commit()
    session.flush()
    return purchase, purchase_detail, purchase_detail_status


def create_purchase_detail(session, purchase, purchase_detail_status):

    purchase_detail = PurchaseDetail()
    purchase_detail.customer_id = 1
    purchase_detail.purchase_id = 1
    purchase_detail.product_id = 1
    purchase_detail.purchase_detail_status = purchase_detail_status
    purchase_detail.purchase = purchase
    purchase_detail.purchase_detail_product_quantity = 1
    session.add(purchase_detail)
    session.commit()
    return purchase_detail


def create_purchase_detail_status(session):
    purchase_detail_status = PurchaseDetailStatu()
    purchase_detail_status.purchase_detail_status = "123456789"
    session.add(purchase_detail_status)
    session.commit()
    # session.flush()
    return purchase_detail_status

