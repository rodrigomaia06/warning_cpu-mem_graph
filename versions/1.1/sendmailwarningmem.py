import base64
import smtplib
sender_email = "###sender_email###"
password_base64 = "###password_base64###"
password = base64.b64decode(password_base64).decode("utf-8")
rec_email = "###rec_email###"

subject = "WARNING MEM!"
body = "Mem_server >= ###ram_percentage_warning### %"
msg = f"Subject: {subject}\n\n{body}"

server = smtplib.SMTP("smtp.gmail.com", 587)
server.starttls()
server.login(sender_email, password)
server.sendmail(sender_email, rec_email, msg)
email_session.quit()
