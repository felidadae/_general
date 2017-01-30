import codecs
import datetime
import re
from datetime import datetime as datetime2

fref = codecs.open("/home/s.bugaj/momentusjob.txt", 'r', 'utf-8')
fref = open("/home/s.bugaj/momentusjob.txt", 'r')
today = datetime.date.today()
shell_date_format='%a %b %d %H:%M:%S %Z %Y'

sumOfHours=0.0
prev_datetime_object = 0 
for line in fref:
	line = line.rstrip()
	line = line.encode("ascii","ignore")

	if re.match("^\s*$", line):
		continue

	line = re.sub("\s(\d)\s", r" 0\1 ", line)
	print line
	
	datetime_object = datetime2.strptime(line, shell_date_format)
	if datetime_object.month == today.month and datetime_object.year == today.year:
		if prev_datetime_object != 0:
			if datetime_object.day != prev_datetime_object.day:
				print ("Not matching date event")
				print ("Current sum:" + str(sumOfHours))
				exit(1)
			delta_ = (datetime_object - prev_datetime_object)
			delta_ = float (delta_.seconds) / 60.0 / 60.0
			sumOfHours += delta_
			prev_datetime_object = 0
		else:
			prev_datetime_object = datetime_object

print "Result:"
print sumOfHours
fref.close()
