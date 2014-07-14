# -*- coding: utf-8 -*-
import os
import shutil
 
def CleanDir(Dir):
    if os.path.isdir( Dir ):
        paths = os.listdir( Dir )
        for path in paths:
            filePath = os.path.join(Dir, path)
            if os.path.isfile(filePath):
                try:
                    os.remove( filePath )
                except os.error:
                    autoRun.exception( "remove %s error." %filePath )#引入logging
            elif os.path.isdir( filePath ):
                if filePath[-4:].lower() == ".svn".lower():
                    continue
                shutil.rmtree(filePath,True)
    return True

def delete(source):
    dirs = os.listdir(source)
    for dir in dirs:
        if str(dir) == ".git":
            print source + dir
            try:
                shutil.rmtree(source + dir)
            except OSError:
                os.remove(source + dir)
        if os.path.isdir(source + dir):
            #files = os.listdir(source + dir)
            delete(source + dir + "/")
            #print source + dir
            #for file in files:
            #    if os.path.isdir(source + dir + file):
            #        delete(source+ dir + file)
            #    else:
            #        if str(file) == ".git":
            #            print source + dir + '/' + str(file)
            #            #os.removedirs(source + dir + '/' + str(file))
            #            shutil.rmtree(source + dir + '/' + str(file))

if __name__ == '__main__':
    source = "./plugins/"
    print os.path.isdir(source)
    print os.path.isdir("./plugins/yasnippet/yasmate")
    delete(source)
    source = "./themes/"
    delete(source)
