.PHONY : run_test_0 run_test_1 run_test_2 run_test_3 run_test_4 run docker-rm

docker-rm:
	docker container ls -aq | xargs --no-run-if-empty docker container rm -f
	sleep 10s

generate_models:
	sqlacodegen postgresql://postgres:postgres@localhost:5432/postgres  --outfile create_mass/denormalized_models.py --schema denormalized
	sqlacodegen postgresql://postgres:postgres@localhost:5432/postgres  --outfile create_mass/normalized_models.py --schema normalized
	cp create_mass/normalized_models.py tester/
	cp create_mass/denormalized_models.py tester/

up:
	cd database && 	docker-compose up -d  && cd -

dump:
	docker exec -t 541a13442a08 pg_dumpall -c -U postgres > dump.sql
	##docker cp 66422fe2861d:/dump.sql ./


run_test_0: 
	$(MAKE) docker-rm
	cd database && 	docker-compose up -d postgres && cd -
	sleep 1m
	cd tester &&  python main.py  && cd -

run_test_1: 
	$(MAKE) docker-rm
	echo run_test_1
	cd database && 	docker-compose up -d  postgres_1 && cd -
	sleep 2m
	cd tester &&  python main.py  && cd -

run_test_2: 
	$(MAKE) docker-rm
	echo run_test_2
	cd database && 	docker-compose up -d postgres_2  && cd -
	sleep 2m
	cd tester &&  python main.py  && cd -

run_test_3: 
	$(MAKE) docker-rm
	echo run_test_3
	cd database && 	docker-compose up -d postgres_3  && cd -
	sleep 2m
	cd tester &&  python main.py  && cd -

run_test_4: 
	$(MAKE) docker-rm
	echo run_test_4
	cd database && 	docker-compose up -d postgres_4  && cd -
	sleep 2m
	cd tester &&  python main.py  && cd -

run: run_test_0 run_test_1 run_test_2 run_test_3 run_test_4
	$(MAKE) docker-rm