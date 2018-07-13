import glob
import pandas as pd


# enter file pathing location, * selects all files with .xlsx
excel_files = glob.glob('C:/Users/thuang/FY17a/*.xlsx')
date_var = []
t_df = []
for excel in excel_files:
    out = excel.split('.')[0]+'.csv'
    df = pd.read_excel(excel, skiprows=5, parse_cols= 'A:B')
    df.fillna(0, inplace=True)
    date_var = df.ix[0,0].date()
    t_df = df[df['For the Week Ending'].str.contains('Canadian', na=False)]
    #if len(t_df) < 1:
    #    t_df = df[df['Unnamed: 2'].str.contains('Canadian', na=False)]
    #    t_df.drop(t_df.columns[0:2], axis=1, inplace=True)
    #    t_df.columns = ['Product Line', df.ix[0, 0].date()]
    #else:
    #   t_df.drop(t_df.columns[2:4], axis=1, inplace=True)
    #    t_df.columns = ['Product Line', df.ix[0, 0].date()]
    t_df.columns = ['Product Line', df.ix[0,0].date()]
    t_df.to_csv(out, index=False)



