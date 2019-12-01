
under_mean_by_internet_penetration = [{'region' : 'Oceania', 'under_mean_country': {'American Samoa': '43.1%', 'Chrismas Island': '45.4%', 'Cocos Is.': '13.4%', 'Cook Islands': '65.2%', 'Fiji': '54.5%', 'Kiribati': '27.4%', 'Mashall Islands': '38.7%', 'Micronesia': '52.5%', 'Nauru': '57%', 'Norfolk Island': '45.5%', 'Palau': '35.4%', 'Papau New Guines': '11.2%', 'Solomon Island': '11.9%', 'Samoa': '50.3%', 'Tokelau': '59.7%', 'Tonga': '52.5%', 'Tuvalu': '49.3%', 'Wallis & Futuna': '33.6%'}, 'mean': '68.4%'},
                                      {'region' : 'Africa', 'under_mean_country': {'Angola': '22.3%', 'Benin': '32.2%', 'Burkina Faso': '18.2%', 'Angola': '22.3%', 'Benin': '32.2%', 'Burkina Faso':'18.2%', 'Burundi': '5.3%', 'Cameroon': '24.2%', 'Central African Rep.': '5.3%', 'Chad': '6.5%', 'Comoros':'15.3%', 'Congo': '11.7%', 'Congo, Dem. Rep.' : '8.6%', 'Equatorial Guinea' :'26.2%', 'Eritrea' : '1.3%', 'Ethiopia': '18.6%', 'Gambia': '19.8%', 'Ghana' : '39.0%', 'Guinea' : '18.0%', 'Guinea-Bissau' : '7.7%', 'Lesotho': '29.8%', 'Madagascar' : '9.8%', 'Malawi' : '13.8%', 'Mauritania' : '19,290%', 'Mozambique' : '20.8%', 'Niger' : '10.2%', 'Sao Tome & Principe' : '29.9%', 'Sierra Leone': '13.2%', 'Somalia': '9.6%', 'South Sudan': '16.8%', 'Sudan': '30.9%', 'Tanzania': '38.0%', 'Togo': '12.4%', 'Western Sahara': '4.8%'}, 'mean': '39.6%'},
                                      {'region' : 'Middle East', 'under_mean_country': {'Yemen':'26.6%', 'Iraq':'49.4%', 'Palestine (State of)':'65.2%', 'Syria':'34.2%'}, 'mean':'67.9%'},
                                      {'region' : 'Asia', 'under_mean_country': {'Afganistan': '19.7%', 'Bhutan': '48.1%', 'Cambodia': '48.6%', 'India' : '40.9%','Korea, North' : '0.1%', 'Kyrgystan': '40.1%', 'Laos': '35.4%', 'Myanmar' : '33.1%', 'Pakistan' : '35.0%', 'Philippines': '3.4%', 'Sri Lanka' : '34.1%', 'Tajikistan' :'32.4%', 'Timor-Leste': '30.3%', 'Turkmenistan': '21.2%', 'Uzbekistan': '52.3%'}, 'mean': '54.2%'}]

country_google = ['Argentina','Australia','Austria','Bangladesh','Belarus','Belgium','Brazil','Bulgaria','Canada',
                  'Chile','Colombia','Costa Rica','Croatia','Czechia','Denmark','Egypt','Estonia','Finland','France',
                  'Germany','Greece','Guatemala','Hong Kong','Hungary','India','Indonesia','Ireland','Israel','Italy',
                  'Japan','Kazakhstan','Kenya','Latvia','Lithuania','Malaysia','Mexico','Netherlands','New Zealand',
                  'Nigeria','Norway','Pakistan','Panama','Peru','Philippines','Poland','Portugal','Puerto Rico','Romania',
                  'Russia','Saudi Arabia','Serbia','Singapore','Slovakia','Slovenia','South Africa','South Korea','Spain',
                  'Sweden','Switzerland','Taiwan','Thailand','Turkey','Ukraine','United Arab Emirates','United Kingdom','United States','Uruguay','Vietnam','Zimbabwe'
]

for region in under_mean_by_internet_penetration:
    lists = []
    
    for country in country_google:
        dicts ={}
        if country in region['under_mean_country'].keys():
            dicts['region'] = region['region']
            dicts['under_mean_country'] = country
            dicts['Penetration_Population'] = region['under_mean_country'][country]
            dicts['mean_of_the region'] = region['mean']
            lists.append(dicts)
print(lists)

[{'region': 'Asia', 'under_mean_country': 'India'}, {'region': 'Asia', 'under_mean_country': 'Pakistan'}, {'region': 'Asia', 'under_mean_country': 'Philippines'}]