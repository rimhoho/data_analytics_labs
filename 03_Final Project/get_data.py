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

import re, pymongo, time, pdb, itertools, requests, json
from pymongo import MongoClient

def init_browser():
    driver = webdriver.Chrome('/Users/hh/Documents/ECT/rimhoho.github.io/chromedriver') #download from here, https://chromedriver.chromium.org/downloads and use the path
    return driver

def searches_lists(driver, collections):
    # search_trend_urls = ['https://trends.google.com/trends/yis/' + year + '/GLOBAL/' for year in collections]
    search_trend_urls = ['https://trends.google.com/trends/yis/2011/GLOBAL/']
    
    for each_year in search_trend_urls:
        time.sleep(2)
        driver.get(each_year)
        
        WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.XPATH, '//*[@id="anchorName"]/div/div/div[2]/div[1]')))
        buttons = driver.find_elements_by_xpath('//*[@id="anchorName"]/div/div/div[2]/div[1]')
        
        for b in buttons:
            driver.execute_script("arguments[0].click();", b)
        
        collection = re.sub('(https:\/\/trends.google.com\/trends\/yis\/)', '', each_year[:-4])    
        each_lists = driver.find_elements_by_class_name('grid-cell')
        container = []

        for each in each_lists:
            each_category = {}
            each_list = []
            ranking = each.find_elements_by_class_name('fe-expandable-list-question-index')
            keyword = each.find_elements_by_class_name('fe-expandable-item-text')

            each_category['year'] = collection
            each_category['category'] = each.find_element_by_tag_name('span').text

            for i in range(len(ranking)):            
                each_keyword = {}       
                each_keyword['ranking'] = ranking[i].text
                each_keyword['keyword'] = keyword[i].text
                each_keyword['href'] = keyword[i].get_attribute('href')
                each_list.append(each_keyword)
            
            each_category['rank_keyword'] = each_list
            container.append(each_category)

        result = get_higher_search_by_region(driver, container)

        collections[collection].insert_many([
            { 'year' : each_key['year'],
              'category' : each_key['category'],
              'ranking' : each_infos['ranking'],
              'keyword' : each_infos['keyword'],
              'href' : each_infos['href'],
              'region' : each_searches['region'],
              'search_volume' : each_searches['search_volume']
        } for each_key in result for each_infos in each_key['rank_keyword'] for each_searches in each_infos['higher_search_volumes']])
        print('result: ', result)
    return

def get_higher_search_by_region(driver, container):
    for each_category in container:
            for each_keyword in each_category['rank_keyword']:
                driver.get(each_keyword['href'])     
                interest_lists = WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.XPATH, '/html/body/div[2]/div[2]/div/md-content/div/div/div[2]/trends-widget/ng-include/widget/div/div/ng-include/div/div/div[2]/widget/div')))
                each_list = []
                
                for item in interest_lists.find_elements_by_class_name('progress-label'):
                    search_volume = item.find_element_by_class_name('progress-value').text
                    if int(search_volume) > 49:
                        each_dict = {}
                        region = item.find_element_by_class_name('label-text').find_element_by_tag_name('span').text
                        each_dict['region'] = region
                        each_dict['search_volume'] = search_volume
                        each_list.append(each_dict)
                each_keyword['higher_search_volumes'] = each_list
    return container

def access_db(dbname, collectionnames):
    cluster = MongoClient('mongodb+srv://rimho:0000@cluster0-yehww.mongodb.net/test?retryWrites=true&w=majority')
    db = cluster[dbname]
    collections = {c:db[c] for c in collectionnames}
    return db, collections

def main():
    db, collections = access_db('Google_search_trends_global_db', ['2001', '2002','2003','2004','2005','2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018'])
    driver = init_browser()
    time.sleep(3)
    searches_lists(driver, collections)
    print('Go To MongoDB')
    return 

main()




