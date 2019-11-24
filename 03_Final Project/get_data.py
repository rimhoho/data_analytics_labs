from selenium import webdriver
# 1st import: Allows you to launch/initiate a browser
from selenium.webdriver.common.by import By
# 2nd import: Allows you to search for things using specific parameters.
from selenium.webdriver.support.ui import WebDriverWait
# 3rd import: Allows you to wait for a page to load.
from selenium.webdriver.support import expected_conditions as EC
# 4th import: Specify what you are looking for on a specific page in order to determine that the webpage has loaded.
from selenium.common.exceptions import TimeoutException
# 5th import: Handling a timeout situation
from selenium.common.exceptions import WebDriverException
# from selenium.webdriver.common.proxy import Proxy, ProxyType
from selenium.webdriver.common.action_chains import ActionChains

import re, pymongo, time, pdb, itertools
from pymongo import MongoClient

def init_browser():
    driver = webdriver.Chrome('/Users/hh/Documents/ECT/rimhoho.github.io/chromedriver')
    return driver

def product_lists(driver, collections):
    search_trend_urls = ['https://trends.google.com/trends/yis/' + year + '/US/' for year in collections]
    
    for each_year in search_trend_urls:
        time.sleep(2)
        driver.get(each_year)
        
        WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.XPATH, '//*[@id="anchorName"]/div/div/div[2]/div[1]')))
        buttons = driver.find_elements_by_xpath('//*[@id="anchorName"]/div/div/div[2]/div[1]')
#         pdb.set_trace()
        
        for b in buttons:
            driver.execute_script("arguments[0].click();", b)
        
        collection = re.sub('(https:\/\/trends.google.com\/trends\/yis\/)', '', each_year[:-4])
        
        category = [category.text for category in driver.find_elements_by_xpath('//*[@id="anchorName"]/div/div/div[1]/div/span')]
        ranking = driver.find_elements_by_class_name('fe-expandable-list-question-index')
        keyword = driver.find_elements_by_class_name('fe-expandable-item-text')

        collections[collection].insert_many([
            { '-id' : i,
#               'category' : ''.join([category[j] range(len(category)) if i > 11]),
              'ranking' : ranking[i].text,
              'keyword' : keyword[i].text,
              'href' : keyword[i].get_attribute('href')
        } for i in range(len(ranking))])
        
    return 

def access_db(dbname, collectionnames):
    cluster = MongoClient('mongodb+srv://rimho:0000@cluster0-yehww.mongodb.net/test?retryWrites=true&w=majority')
    db = cluster[dbname]
    collections = {c:db[c] for c in collectionnames}
    return db, collections

def main():
    db, collections = access_db('google_search_trend_db', ['2006', '2007', '2008', '2009', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018'])
    driver = init_browser()
    time.sleep(3)
    product_lists(driver, collections)
    print('Go To MongoDB')
    return 

main()