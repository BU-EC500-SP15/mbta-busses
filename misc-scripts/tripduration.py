import csv

with open('../ProcessedData/tripDurations-2014-03-01.txt', 'rt') as tsvinput, open('data-28-Inbound-2014-03-01.tsv', 'wt') as tsvoutput:
    tsvin = csv.reader(tsvinput, delimiter='\t')
    tsvout = csv.writer(tsvoutput)

    # for line in tsvin:
    #    print(line[1:])
        
    for row in tsvin:
        tsvout.writerows([row[4:6]])
    
