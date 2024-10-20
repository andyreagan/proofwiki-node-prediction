#!/usr/bin/python
#
# parse_proofwiki.py
#
# written by Andy Reagan

# goal is to parse this big XML into an edge table, readable by Gephi

# i'll store the table as a hash table so I can lookup proofs

import re

f = open('../data/ProofWiki.xml')
pages = -1

#set a bunch of flags to be false
pageFlag = False
proofFlag = False

proofwikidict={}

proofs = 0
endproofs = 0

line_counter=1
for line in f:
  line_stripped=re.findall(r"[^<>][^<>]+", line)
  # print line_stripped
  #i=0
  #for tmp in line_stripped:
  #  line_stripped[i] = tmp.strip('<>')
  #  i+=1
  if line_stripped:
    # print line_stripped
    if 'page' in line_stripped:
      pages += 1
      pageFlag = True
      # print 'found page'
    if '/page' in line_stripped:
      pageFlag=False
      proofFlag=False
    if pageFlag:
      if 'title' in line_stripped:
        title=line_stripped[line_stripped.index('title')+1]
        # print 'Found title: ' + title
      if ['Proof'] in [re.findall(r"[\w]+",tmptmptmp) for tmptmptmp in line_stripped]: #[[tmp_re.strip() for tmp_re in re.findall(r"[^=][^=]+",line_stripped[i])] for i in range(len(line_stripped))]:
        proofFlag = True
        #print 'in a proof'
        proofs+=1
      if ['qed'] in [re.findall(r"[\w]+",line_tmp) for line_tmp in line_stripped]:
        proofFlag = False
        endproofs+=1
      if proofFlag:
        for tmp in line_stripped:
          # search for links (i'll include this within a proof check later)
          tmp_link=re.findall(r"\[\[[^\]]+",tmp)
          if tmp_link:
            j=0
            for tmp_link_links in tmp_link:
              tmp_link[j]=tmp_link_links.strip('[]')
              if title in proofwikidict:
                proofwikidict[title].append(tmp_link[j])
              else:
                proofwikidict[title]=[tmp_link[j]]
              j+=1
  # search for the word proof within "== Proof ==" to begin in proof checking
  #if inProof:
  #  proofFlag = True
  line_counter+=1

#print proofwikidict['Generalized Sum Preserves Inequality']
print 'length of proofwikidict is: '+ str(len(proofwikidict))
print 'read ' + str(line_counter) + ' lines'
print 'read ' + str(pages) + ' pages'
print 'read ' + str(proofs) + ' proofs'
print 'of those, ' + str(endproofs) + ' ended'

f = open('../data/proofwiki_parsed_seplines_proofsonly2.csv','w')
f.write('Target,Source\n')
for key in proofwikidict:
  for tmpentry in proofwikidict[key]:
    f.write(key)
    f.write(',')
    f.write(tmpentry)
    f.write('\n')
    
f.close()
