import datetime
import glob
import multiprocessing
import pathlib
import pickle
import re
from datetime import datetime

import bs4
import numpy as np
import pandas as pd
import requests
from tqdm import tqdm


def get_url_paths(url, ext='', params: dict = None):
    if params is None:
        params = {}
    response = requests.get(url, params=params)
    if response.ok:
        response_text = response.text
    else:
        return response.raise_for_status()
    soup = bs4.BeautifulSoup(response_text, 'html.parser')
    parent = [url + node.get('href') for node in soup.find_all('a') if node.get('href').endswith(ext)]
    return parent


def p_debug(in_url, out_dir):
    print(f'{in_url}\n'
          f'{out_dir}')


def download_url(args) -> None:
    out_dir, in_url = args
    r = requests.get(in_url)
    pattern = re.compile(r'([A-Z]{2}_.*)(\.txt)')
    filename = re.search(pattern, in_url).group(1)
    pathlib.Path(out_dir).mkdir(parents=True, exist_ok=True)
    file = pathlib.Path(out_dir, f'{filename}.txt')
    file.touch(exist_ok=True)
    with open(file, mode='w') as f:
        f.write(r.text)


names = list(pd.read_csv('data/columns.txt', delim_whitespace=True).columns)


def parse_noaa(in_file) -> pd.DataFrame:
    colnames = ['WBANNO', 'UTC_DATE', 'UTC_TIME', 'LST_DATE', 'LST_TIME', 'CRX_VN',
                'LONGITUDE', 'LATITUDE', 'T_CALC', 'T_HR_AVG', 'T_MAX', 'T_MIN',
                'P_CALC', 'SOLARAD', 'SOLARAD_FLAG', 'SOLARAD_MAX', 'SOLARAD_MAX_FLAG',
                'SOLARAD_MIN', 'SOLARAD_MIN_FLAG', 'SUR_TEMP_TYPE', 'SUR_TEMP',
                'SUR_TEMP_FLAG', 'SUR_TEMP_MAX', 'SUR_TEMP_MAX_FLAG', 'SUR_TEMP_MIN',
                'SUR_TEMP_MIN_FLAG', 'RH_HR_AVG', 'RH_HR_AVG_FLAG', 'SOIL_MOISTURE_5',
                'SOIL_MOISTURE_10', 'SOIL_MOISTURE_20', 'SOIL_MOISTURE_50',
                'SOIL_MOISTURE_100', 'SOIL_TEMP_5', 'SOIL_TEMP_10', 'SOIL_TEMP_20',
                'SOIL_TEMP_50', 'SOIL_TEMP_100']

    data = pd.read_csv(in_file, delim_whitespace=True, names=colnames)
    data['datetime'] = data.apply(
        lambda row: datetime.strptime(f"{row['UTC_DATE']}{row['UTC_TIME']:04}", '%Y%m%d%H%M'),
        axis=1
    )
    data['T_HR_AVG'].mask(data['T_HR_AVG'] < -1000, np.nan, inplace=True)
    data['T_HR_AVG'].interpolate(inplace=True)

    return data


def year_to_url(year, out_dir):
    url = f'https://www.ncei.noaa.gov/pub/data/uscrn/products/hourly02/{year}/'
    result = get_url_paths(url, 'txt')
    out_dir = pathlib.Path(out_dir, f'{year}')
    t = (out_dir, result)
    return t


if __name__ == '__main__':
    years = list(range(2015, 2021))

    t_dir = 'data/temperature/cache'
    pathlib.Path(t_dir).mkdir(parents=True, exist_ok=True)

    path_url = [year_to_url(y, t_dir) for y in years]
    # paths = []
    # for p, ul in path_url:
    #     for u in ul:
    #         paths.append((p, u))

    paths = [f for y in [[(p, u) for u in ul] for p, ul in path_url] for f in y]

    # [download_url(t) for t in tqdm(paths)]
    file_ls = [file for file in glob.glob('data/temperature/cache/**/*.txt')]

    with multiprocessing.Pool() as pool:
        df_ls = [r for r in pool.imap_unordered(parse_noaa, tqdm(file_ls))]

    with open('data/temperature/temperature_df.pkl', 'wb') as handle:
        pickle.dump(df_ls, handle)
