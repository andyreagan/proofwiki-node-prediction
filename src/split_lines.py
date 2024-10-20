#!/usr/bin/python
#
# split_lines.py
# 
# usage:
# python split_lines.py big_file.txt

import sys

inputFileName=str(sys.argv[1])
outputFileName=inputFileName[:inputFileName.find('.')] + '_split' + inputFileName[inputFileName.find('.'):]
outputFileName2=outputFileName[:outputFileName.find('.')] + '2' + outputFileName[outputFileName.find('.'):]

def replaceTabs(inputFN, outputFN):
  input=open(inputFN,'r')
  output=open(outputFN,'w')
  
  for line in input:
    tempstr=line.replace('\t','\n')
    output.write(tempstr)

  input.close()
  output.close()

def deleteBlanks(inputFN, outputFN):
  input=open(inputFN,'r')
  output=open(outputFN,'w')
  
  for line in input:
    print line
    if line:  
      output.write(line)

  input.close()
  output.close()


if __name__=='__main__':
  replaceTabs(inputFileName,outputFileName) 
  print outputFileName + ' written'
  deleteBlanks(outputFileName,outputFileName2)
  print outputFileName2 + 'written'






