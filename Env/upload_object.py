
#This script is to upload report objects to target enviroment from Git repository
import requests
from requests.auth import HTTPBasicAuth

import sys
import argparse
import re
import base64
import os

def process_upload_objects(paramDict,reportBaseStr):

    username = paramDict['username']
    password = paramDict['password']

    #generate base64 authorization code 
    auth = HTTPBasicAuth(username, password)

    headers = {'Accept':'*/*','Content-Type':'text/xml','soapAction':''}
    baseurl = paramDict['surl']
    url = baseurl+'/xmlpserver/services/v2/CatalogService'
    reportPath = os.path.join(paramDict['rtpath'],paramDict['otname'])
    oType = paramDict['otype']+'z'

    payload="""<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v2="http://xmlns.oracle.com/oxp/service/v2">
                <soapenv:Header/>
                <soapenv:Body>
                    <v2:uploadObject>
                        <v2:reportObjectAbsolutePathURL>{reportPath}</v2:reportObjectAbsolutePathURL>
                        <v2:objectType>{otype}</v2:objectType>
                        <v2:objectZippedData>{bdata}</v2:objectZippedData>
                        <v2:userID>{user}</v2:userID>
                        <v2:password>{pwd}</v2:password>
                    </v2:uploadObject>
                </soapenv:Body>
                </soapenv:Envelope>""".format(reportPath=reportPath,otype=oType,user=username,pwd=password,bdata=reportBaseStr)
    
    print('sending request to : ' + url)
    print('payload getting submitted : ' + payload)
    r=requests.post(url,auth=auth,data=payload,headers=headers)
    
    print(r.status_code)
    print(r.text)

def getFileBase64(filename):
    
    with open(filename, "rb") as sfile:
        encoded_string = base64.b64encode(sfile.read())

    return encoded_string.decode()


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--username", "-u", help="set bi username")
    parser.add_argument("--password", "-p", help="set bi password")
    parser.add_argument("--surl", "-s", help="set source application URL")
    parser.add_argument("--rpath", "-r", help="source report absolute path")
    parser.add_argument("--rtpath", "-rt", help="target report absolute path")
    parser.add_argument("--oname", "-on", help="source object name")
    parser.add_argument("--otname", "-ot", help="target object name")
    parser.add_argument("--otype", "-t", help="source object type")
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
    if args.otype:
        print("object type : %s" % args.otype)
        paramDict['otype'] = args.otype
    if args.otname:
        print("object name : %s" % args.otname)
        paramDict['otname'] = args.otname

    filename = paramDict['oname']
    repPath = paramDict['rpath']
    
    reportBaseStr = getFileBase64(os.path.join(repPath,filename))

    if reportBaseStr != None:
        process_upload_objects(paramDict,reportBaseStr)