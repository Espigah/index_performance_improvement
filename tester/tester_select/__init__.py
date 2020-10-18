from tqdm import tqdm


def run(session, MAX):
    for i in tqdm(range(MAX), desc="normalized::active_clients_last_year"):
        session.execute("SELECT * FROM normalized.active_clients_last_year;")
    for i in tqdm(range(MAX), desc="normalized::brand_purchase_count"):
        session.execute("SELECT * FROM normalized.brand_purchase_count;")
    for i in tqdm(range(MAX), desc="normalized::purchase_count"):
        session.execute("SELECT * FROM normalized.purchase_count;")
    for i in tqdm(range(MAX), desc="normalized::customer_purchase_detail"):
        session.execute("SELECT * FROM normalized.customer_purchase_detail;")

        ##########################################
    for i in tqdm(range(MAX), desc="denormalized::active_clients_last_year"):
        session.execute("SELECT * FROM denormalized.active_clients_last_year;")
    for i in tqdm(range(MAX), desc="denormalized::brand_purchase_count"):
        session.execute("SELECT * FROM denormalized.brand_purchase_count;")
    for i in tqdm(range(MAX), desc="denormalized::purchase_count"):
        session.execute("SELECT * FROM denormalized.purchase_count;")
    for i in tqdm(range(MAX), desc="denormalized::customer_purchase_detail"):
        session.execute("SELECT * FROM denormalized.customer_purchase_detail;")
