
#This script is to download report objects from any instance and save it to current directory.

import requests
from requests.auth import HTTPBasicAuth

import sys
import argparse
import re
import base64
import os


def process_download_objects(paramDict):

    username = paramDict['username']
    password = paramDict['password']

    #generate base64 authorization code 
    auth = HTTPBasicAuth(username, password)

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

def saveFile(baseStr,filename):
    with open(filename, "wb") as fh:
        fh.write(base64.b64decode(baseStr))

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--username", "-u", help="set bi username")
    parser.add_argument("--password", "-p", help="set bi password")
    parser.add_argument("--surl", "-s", help="source application URL")
    parser.add_argument("--rpath", "-r", help="source report absolute path")
    parser.add_argument("--oname", "-on", help="source object name")
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
    if args.oname:
        print("object name : %s" % args.oname)
        paramDict['oname'] = args.oname
    if args.otype:
        print("object type : %s" % args.otype)
        paramDict['otype'] = args.otype

    reportBaseStr = process_download_objects(paramDict)

    if reportBaseStr!=None:
        saveFile(reportBaseStr,paramDict['oname'])