from flask import Flask, escape, render_template, request, redirect
from werkzeug.utils import secure_filename
import PyPDF2
import subprocess

app = Flask(__name__)

def pdf_check(file):
    try:
        pdf = PyPDF2.PdfFileReader(open(file, "rb"))
    except:
        return False
    else:
        return True

def size_check(file):
    pdf = PyPDF2.PdfFileReader(open(file, "rb"))
    print(pdf.getDocumentInfo())
    ptSqr = pdf.getPage(0).mediaBox[2] * pdf.getPage(0).mediaBox[3]
    if ptSqr > 400000:
        print("A4  " + str(ptSqr))
        return "A4"
    elif ptSqr < 150000:
        print("Label  " + str(ptSqr))
        return "label"
    else:
        print("Unknown paper size")
        return "unknown"

def label_print(file,printer):
    print("calling lpr command")
    subprocess.call(['/app/printer.sh', printer, file])

@app.route('/')
def root():
    return redirect("/upload", code=302)

@app.route('/upload')
def upload_page():
   return render_template('upload.html')

@app.route('/devicename')
def device_page():   
    args = request.args
    snmpgetcommand = 'snmpget -v1 -cpublic -Ov '+args.get("ip")+' 1.3.6.1.2.1.25.3.2.1.3.1'  
    response = subprocess.run(snmpgetcommand, shell=True, check=True, timeout=15, capture_output=True)
    return response.stdout
    
@app.route('/printer')
def printer_xml():
   return render_template('printer.xml'),200,{'Content-Type':'application/xml'}
	
@app.route('/uploader', methods = ['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        args = request.args
        f = request.files['file']
        file = "uploads/" + secure_filename(f.filename)
        f.save(file)
        if pdf_check(file):
            if size_check(file) == "A4":
                label_print(file,args.get("printer"))
            return "great pdf but size is not A4"
        else:
            return "file is not a usable pdf"
    else:
        return redirect("/upload", code=302)
 