import base64
import smtplib
sender_email = "ticericeira47@gmail.com"
password_base64 = "eWIlbVZAJSVSJU1pNl5oNjRUZkJleE03bw=="
password = base64.b64decode(password_base64).decode("utf-8")
rec_email = "rodrigo.m.t.maia@gmail.com"

subject = "WARNING!"
body = "Mem_server >= 75 %"
msg = f"Subject: {subject}\n\n{body}"

server = smtplib.SMTP("smtp.gmail.com", 587)
server.starttls()
server.login(sender_email, password)
server.sendmail(sender_email, rec_email, msg)
email_session.quit()
