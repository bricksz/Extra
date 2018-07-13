import glob
import csv
from collections import defaultdict

data = defaultdict(dict)
metrics = []

for csv_filename in glob.glob('C:/Users/thuang/FY17a/*.csv'):
    with open(csv_filename, 'r', newline='') as f_input:
        csv_input = csv.reader(f_input)
        key_header, *header = next(csv_input)
        metrics.extend(header)

        for row in csv_input:
            key = data[row[0]]

            for metric, value in zip(header, row[1:]):
                key[metric] = value

metrics = sorted(metrics)

with open('output.csv', 'w', newline='') as f_output:
    csv_output = csv.writer(f_output)
    csv_output.writerow([key_header] + metrics)

    for key in sorted(data.keys()):
        csv_output.writerow([key] + [data[key].get(metric, 'null') for metric in metrics])