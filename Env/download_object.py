
#This script is to download report objects from one instance and upload to target enviroment.
import requests
import sys
import argparse


def process_download_objects(paramDict):
    #yet to be implemented.
    r=requests.get(paramDict.get('surl'))
    print(r.status_code)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--username", "-u", help="set bi username")
    parser.add_argument("--password", "-p", help="set bi password")
    parser.add_argument("--surl", "-t", help="set source application URL")
    args = parser.parse_args()
    
    #dictionary with parameters
    paramDict = {}
    
    if args.username:
        print("Username is : %s" % args.username)
        paramDict['username'] = args.username
    if args.password:
        print("Username is : %s" % args.password)
        paramDict['password'] = args.password
    if args.surl:
        print("URL is : %s" % args.surl)
        paramDict['surl'] = args.surl

    process_download_objects(paramDict)