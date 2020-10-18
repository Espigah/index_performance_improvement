# coding: utf-8
from sqlalchemy import BigInteger, Column, DateTime, ForeignKey, Integer, String, Table, Text, text
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
metadata = Base.metadata


t_active_clients_last_year = Table(
    'active_clients_last_year', metadata,
    Column('customer_email', String(60)),
    Column('customer_address_zipcode', String(12)),
    Column('purchase_updated', DateTime),
    Column('product_name', String(100)),
    schema='normalized'
)


class Brand(Base):
    __tablename__ = 'brand'
    __table_args__ = {'schema': 'normalized'}

    brand_id = Column(Integer, primary_key=True, server_default=text("nextval('normalized.brand_brand_id_seq'::regclass)"))
    brand_name = Column(String(80), nullable=False)


t_brand_purchase_count = Table(
    'brand_purchase_count', metadata,
    Column('brand_name', String(80)),
    Column('count', BigInteger),
    schema='normalized'
)


class CustomerAddres(Base):
    __tablename__ = 'customer_address'
    __table_args__ = {'schema': 'normalized'}

    customer_address_id = Column(Integer, primary_key=True, server_default=text("nextval('normalized.customer_address_customer_address_id_seq'::regclass)"))
    customer_address_zipcode = Column(String(12))
    customer_address_street = Column(String(80))


t_customer_purchase_detail = Table(
    'customer_purchase_detail', metadata,
    Column('customer_id', Integer),
    Column('customer_name', String(80)),
    Column('brand_name', String(80)),
    Column('product_name', String(100)),
    Column('product_size_description', String(200)),
    Column('weight', Text),
    Column('purchase_detail_status', String(13)),
    schema='normalized'
)


class ProductSize(Base):
    __tablename__ = 'product_size'
    __table_args__ = {'schema': 'normalized'}

    product_size_id = Column(Integer, primary_key=True, server_default=text("nextval('normalized.product_size_product_size_id_seq'::regclass)"))
    product_size_description = Column(String(200), nullable=False)


class Purchase(Base):
    __tablename__ = 'purchase'
    __table_args__ = {'schema': 'normalized'}

    purchase_id = Column(Integer, primary_key=True, server_default=text("nextval('normalized.purchase_purchase_id_seq'::regclass)"))
    purchase_created = Column(DateTime, server_default=text("now()"))
    purchase_updated = Column(DateTime, server_default=text("now()"))


t_purchase_count = Table(
    'purchase_count', metadata,
    Column('purchase_detail_status', String(13)),
    Column('count', BigInteger),
    schema='normalized'
)


class PurchaseDetailStatu(Base):
    __tablename__ = 'purchase_detail_status'
    __table_args__ = {'schema': 'normalized'}

    purchase_detail_status_id = Column(Integer, primary_key=True, server_default=text("nextval('normalized.purchase_detail_status_purchase_detail_status_id_seq'::regclass)"))
    purchase_detail_status = Column(String(13))


class WeightUnit(Base):
    __tablename__ = 'weight_unit'
    __table_args__ = {'schema': 'normalized'}

    weight_unit_id = Column(Integer, primary_key=True, server_default=text("nextval('normalized.weight_unit_weight_unit_id_seq'::regclass)"))
    weight_unit = Column(String(5), nullable=False)


class Customer(Base):
    __tablename__ = 'customer'
    __table_args__ = {'schema': 'normalized'}

    customer_id = Column(Integer, primary_key=True, server_default=text("nextval('normalized.customer_customer_id_seq'::regclass)"))
    customer_address_id = Column(ForeignKey('normalized.customer_address.customer_address_id'), nullable=False)
    customer_cpf = Column(String(13))
    customer_email = Column(String(60))
    customer_name = Column(String(80))
    customer_created = Column(DateTime, server_default=text("now()"))

    customer_address = relationship('CustomerAddres')


class Weight(Base):
    __tablename__ = 'weight'
    __table_args__ = {'schema': 'normalized'}

    weight_id = Column(Integer, primary_key=True, server_default=text("nextval('normalized.weight_weight_id_seq'::regclass)"))
    weight_unit_id = Column(ForeignKey('normalized.weight_unit.weight_unit_id'), nullable=False)
    weight_value = Column(String(10), nullable=False)

    weight_unit = relationship('WeightUnit')


class Product(Base):
    __tablename__ = 'product'
    __table_args__ = {'schema': 'normalized'}

    product_id = Column(Integer, primary_key=True, server_default=text("nextval('normalized.product_product_id_seq'::regclass)"))
    product_name = Column(String(100), nullable=False)
    brand_id = Column(ForeignKey('normalized.brand.brand_id'), nullable=False)
    weight_id = Column(ForeignKey('normalized.weight.weight_id'), nullable=False)
    product_size_id = Column(ForeignKey('normalized.product_size.product_size_id'), nullable=False)

    brand = relationship('Brand')
    product_size = relationship('ProductSize')
    weight = relationship('Weight')


class PurchaseDetail(Base):
    __tablename__ = 'purchase_detail'
    __table_args__ = {'schema': 'normalized'}

    purchase_detail_id = Column(Integer, primary_key=True, server_default=text("nextval('normalized.purchase_detail_purchase_detail_id_seq'::regclass)"))
    purchase_id = Column(ForeignKey('normalized.purchase.purchase_id'), nullable=False)
    purchase_detail_status_id = Column(ForeignKey('normalized.purchase_detail_status.purchase_detail_status_id'), nullable=False)
    product_id = Column(ForeignKey('normalized.product.product_id'), nullable=False)
    customer_id = Column(ForeignKey('normalized.customer.customer_id'), nullable=False)
    purchase_detail_product_quantity = Column(Integer, server_default=text("1"))

    customer = relationship('Customer')
    product = relationship('Product')
    purchase_detail_status = relationship('PurchaseDetailStatu')
    purchase = relationship('Purchase')
