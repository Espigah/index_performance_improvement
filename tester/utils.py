import random
import string

# mport nump


status_list = ["COMPLETED", "CANCELED", "PENDING", "PENDING", "PENDING"]
create_list = ["2010-01-01 00:00:00", "2011-01-01 00:00:00", "2012-01-01 00:00:00", "2013-01-01 00:00:00", "2014-01-01 00:00:00"]
update_list = ["2017-01-01 00:00:00", "2016-01-01 00:00:00", "2018-01-01 00:00:00", "2019-01-01 00:00:00", "2020-01-01 00:00:00"]


def get_random_string(length):
    # Random string with the combination of lower and upper case
    letters = string.ascii_letters
    result_str = "".join(random.choice(letters) for i in range(length))
    return result_str


def get_random_index(list_len):
    return get_random_int(max(len(list_len) - 1, 0))


def get_random_int(max):
    return random.randint(0, max)


def get_random_item(list):
    index = get_random_index(list)
    return list[index]

def get_random_status():
    return get_random_item(status_list)

def get_random_date_create():
    return get_random_item(create_list)

def get_random_date_update():
    return get_random_item(update_list)