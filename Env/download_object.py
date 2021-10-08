
#This script is to download report objects from one instance and upload to target enviroment.
import requests
from requests.auth import HTTPBasicAuth

import sys
import argparse
import re
import base64


def process_download_objects(paramDict):

    username = paramDict['username']
    password = paramDict['password']

    #generate base64 authorization code 
    auth = HTTPBasicAuth(username, password)

    #/Custom/Docusign/Reports/Reports/DS_AR_RPT_CECL_AR_Bad_Debt.xdo

    headers = {'Accept':'*/*','Content-Type':'text/xml','soapAction':''}
    baseurl = paramDict['surl']
    url = baseurl+'/xmlpserver/services/v2/CatalogService'
    reportPath = paramDict['rpath']+'/'+paramDict['oname']

    payload="""<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v2="http://xmlns.oracle.com/oxp/service/v2">
            <soapenv:Header/>
            <soapenv:Body>
                <v2:downloadObject>
                    <v2:reportAbsolutePath>{reportPath}</v2:reportAbsolutePath>
                    <v2:userID>{user}</v2:userID>
                    <v2:password>{pwd}</v2:password>
                </v2:downloadObject>
            </soapenv:Body>
            </soapenv:Envelope>""".format(reportPath=reportPath,user=username,pwd=password)
    
    print('sending request to : ' + url)
    print('payload getting submitted : ' + payload)
    r=requests.post(url,auth=auth,data=payload,headers=headers)
    
    #print(r.request.headers['Authorization'])
    print(r.status_code)

    if r.status_code == 200:
        btext = re.compile('<downloadObjectReturn>(.*?)</downloadObjectReturn>').search(r.text)
        return btext[1]
    else:
        return None

def process_upload_objects(paramDict,reportBaseStr):

    username = paramDict['username']
    password = paramDict['password']

    #generate base64 authorization code 
    auth = HTTPBasicAuth(username, password)

    #/Custom/Docusign/Reports/Reports/DS_AR_RPT_CECL_AR_Bad_Debt.xdo

    headers = {'Accept':'*/*','Content-Type':'text/xml','soapAction':''}
    baseurl = paramDict['surl']
    url = baseurl+'/xmlpserver/services/v2/CatalogService'
    reportPath = paramDict['rtpath']+'/'+paramDict['otname']

    payload="""<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v2="http://xmlns.oracle.com/oxp/service/v2">
                <soapenv:Header/>
                <soapenv:Body>
                    <v2:uploadObject>
                        <v2:reportObjectAbsolutePathURL>{reportPath}</v2:reportObjectAbsolutePathURL>
                        <v2:objectType>xdoz</v2:objectType>
                        <v2:objectZippedData>{bdata}</v2:objectZippedData>
                        <v2:userID>{user}</v2:userID>
                        <v2:password>{pwd}</v2:password>
                    </v2:uploadObject>
                </soapenv:Body>
                </soapenv:Envelope>""".format(reportPath=reportPath,user=username,pwd=password,bdata=reportBaseStr)
    
    print('sending request to : ' + url)
    print('payload getting submitted : ' + payload)
    r=requests.post(url,auth=auth,data=payload,headers=headers)
    
    #print(r.request.headers['Authorization'])
    print(r.status_code)

    print(r.text)

def getFileBase64(filename):
    
    with open(filename, "rb") as sfile:
        encoded_string = base64.b64encode(sfile.read())

    return encoded_string.decode()

def saveFile(baseStr,filename):
    with open(filename, "wb") as fh:
        fh.write(base64.b64decode(baseStr))

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--username", "-u", help="set bi username")
    parser.add_argument("--password", "-p", help="set bi password")
    parser.add_argument("--surl", "-t", help="set source application URL")
    parser.add_argument("--rpath", "-r", help="source report absolute path")
    parser.add_argument("--rtpath", "-rt", help="target report absolute path")
    parser.add_argument("--oname", "-on", help="source object name")
    parser.add_argument("--otname", "-ot", help="target object name")
    args = parser.parse_args()
    
    #dictionary with parameters
    paramDict = {}
    
    if args.username:
        print("Username is : %s" % args.username)
        paramDict['username'] = args.username
    if args.password:
        print("Password is : %s" % args.password)
        paramDict['password'] = args.password
    if args.surl:
        print("URL is : %s" % args.surl)
        paramDict['surl'] = args.surl
    if args.rpath:
        print("source report path is : %s" % args.rpath)
        paramDict['rpath'] = args.rpath
    if args.rtpath:
        print("target report path is : %s" % args.rtpath)
        paramDict['rtpath'] = args.rtpath
    if args.oname:
        print("object name : %s" % args.oname)
        paramDict['oname'] = args.oname
    if args.otname:
        print("object name : %s" % args.otname)
        paramDict['otname'] = args.otname

    #reportBaseStr = process_download_objects(paramDict)
    #saveFile(reportBaseStr,paramDict['oname'])

    filename = paramDict['oname']
    reportBaseStr = getFileBase64(filename)
    #print(reportBaseStr)

    

    if reportBaseStr != None:
        process_upload_objects(paramDict,reportBaseStr)