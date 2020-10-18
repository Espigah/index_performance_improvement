import normalized
import denormalized
from tqdm import tqdm


def denormalized_run(session, MAX):
    for i in tqdm(range(MAX), desc=f"denormalized::create"):
        denormalized.create_purchase(session)
        denormalized.create_product(session)
        denormalized.create_customer(session)
    pass


def normalized_run(session, MAX):
    for i in tqdm(range(MAX), desc=f"normalized::create"):
        normalized.create_purchase(session)
        normalized.create_product(session)
        normalized.create_customer(session)
    pass


def run(session, MAX):
    normalized_run(session, MAX)
    denormalized_run(session, MAX)
    pass
