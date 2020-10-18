# coding: utf-8
from sqlalchemy import BigInteger, Column, DateTime, ForeignKey, Integer, String, Table, text
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
metadata = Base.metadata


t_active_clients_last_year = Table(
    'active_clients_last_year', metadata,
    Column('customer_email', String(60)),
    Column('customer_zipcode', String(12)),
    Column('purchase_updated', DateTime),
    Column('product_name', String(100)),
    schema='denormalized'
)


t_brand_purchase_count = Table(
    'brand_purchase_count', metadata,
    Column('product_brand_name', String(80)),
    Column('count', BigInteger),
    schema='denormalized'
)


class Customer(Base):
    __tablename__ = 'customer'
    __table_args__ = {'schema': 'denormalized'}

    customer_id = Column(Integer, primary_key=True, server_default=text("nextval('denormalized.customer_customer_id_seq'::regclass)"))
    customer_cpf = Column(String(13))
    customer_email = Column(String(60))
    customer_name = Column(String(80))
    customer_zipcode = Column(String(12))
    customer_street = Column(String(80))
    customer_created = Column(DateTime, server_default=text("now()"))


t_customer_purchase_detail = Table(
    'customer_purchase_detail', metadata,
    Column('customer_id', Integer),
    Column('customer_name', String(80)),
    Column('product_brand_name', String(80)),
    Column('product_name', String(100)),
    Column('product_size_description', String(200)),
    Column('product_weight', String),
    Column('purchase_detail_status', String(13)),
    schema='denormalized'
)


class Product(Base):
    __tablename__ = 'product'
    __table_args__ = {'schema': 'denormalized'}

    product_id = Column(Integer, primary_key=True, server_default=text("nextval('denormalized.product_product_id_seq'::regclass)"))
    product_name = Column(String(100), nullable=False)
    product_brand_name = Column(String(80), nullable=False)
    product_weight = Column(String, nullable=False)
    product_size_description = Column(String(200), nullable=False)


t_purchase_count = Table(
    'purchase_count', metadata,
    Column('purchase_detail_status', String(13)),
    Column('count', BigInteger),
    schema='denormalized'
)


class Purchase(Base):
    __tablename__ = 'purchase'
    __table_args__ = {'schema': 'denormalized'}

    purchase_id = Column(Integer, primary_key=True, server_default=text("nextval('denormalized.purchase_purchase_id_seq'::regclass)"))
    product_id = Column(ForeignKey('denormalized.product.product_id'), nullable=False)
    customer_id = Column(ForeignKey('denormalized.customer.customer_id'), nullable=False)
    purchase_detail_status = Column(String(13))
    purchase_product_quantity = Column(Integer, server_default=text("1"))
    purchase_created = Column(DateTime, server_default=text("now()"))
    purchase_updated = Column(DateTime, server_default=text("now()"))

    customer = relationship('Customer')
    product = relationship('Product')
