import base64
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
sender_email = "ticericeira47@gmail.com"
receiver_email = "rodrigo.m.t.maia@gmail.com"
password_base64 = "eWIlbVZAJSVSJU1pNl5oNjRUZkJleE03bw=="
password = base64.b64decode(password_base64).decode("utf-8")
message = MIMEMultipart()
message["From"] = sender_email
message['To'] = receiver_email
message['Subject'] = 'StatsGraph 2022-02-12'
file = "graph_2022-02-12.png"
attachment = open(file,'rb')
obj = MIMEBase('application','octet-stream')
obj.set_payload((attachment).read())
encoders.encode_base64(obj)
obj.add_header('Content-Disposition',"attachment; filename= "+file)
message.attach(obj)
my_message = message.as_string()
email_session = smtplib.SMTP('smtp.gmail.com',587)
email_session.starttls()
email_session.login(sender_email, password)
email_session.sendmail(sender_email,receiver_email,my_message)
email_session.quit()
