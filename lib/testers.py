import csv
email1 = "i19ma"
email2="@amhd.svnit.ac.in"

with open('testers.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    for i in range(1,100):
        if(i<10):
            num=f'00{i}'
        elif(i>9 and i<100):
            num=f'0{i}'
        else:
            num=''
        email = email1+num+email2
        writer.writerow([email])