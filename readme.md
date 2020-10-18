sqlacodegen para gerar as entidades


sqlacodegen postgresql://postgres:postgres@localhost:5432/postgres  --outfile denormalized_models.py --schema denormalized
sqlacodegen postgresql://postgres:postgres@localhost:5432/postgres  --outfile normalized_models.py --schema normalized