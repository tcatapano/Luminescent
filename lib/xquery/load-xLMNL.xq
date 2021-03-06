import module namespace lm = "http://www.lmnl-markup.org/ns/luminescent/xquery" at "luminescent.xqm";

declare namespace x = "http://lmnl-markup.org/ns/xLMNL";
declare option output:indent "no";
declare option output:format "no";
declare option db:chop 'no';


let $silkenTent := '[sonneteer [id}silkentent{id]}[meta [author}Robert Frost{author] [title}A Silken Tent{title]]
[sonnet}
[octave}[quatrain}[line}[s}[phr}She is as in a field a silken tent{line]
[line}At midday when the sunny summer breeze{line]
[line}Has dried the dew and all its ropes relent,{phr]{line]
[line}[phr}So that in guys it gently sways at ease,{phr]{line]{quatrain]
[quatrain}[line}[phr}And its supporting central cedar pole,{phr]{line]
[line}[phr}That is its pinnacle to heavenward{line]
[line}And signifies the sureness of the soul,{phr]{line]
[line}[phr}Seems to owe naught to any single cord,{phr]{line]{quatrain]{octave]
[sestet}[quatrain}[line}[phr}But strictly held by none,{phr] [phr}is loosely bound{line]
[line}By countless silken ties of love and thought{line]
[line}To every thing on earth the compass round,{phr]{line]
[line}[phr}And only by one''s going slightly taut{line]{quatrain]
[couplet}[line}In the capriciousness of summer air{line]
[line}Is of the slightest bondage made aware.{phr]{s]{line]{couplet]{sestet]
{sonnet]{sonneteer]'

(: return lm:lmnl-to-xLMNL('[range [a1}1{] [a2}2{]}testing my range{range [a3}3{a3]]') :)
(: return lm:lmnl-to-xLMNL($silkenTent):)


let $fileSet := map {
   "Frankenstein.xlmnl" := 'file:///C:/Projects/Github/Luminescent/lmnl/frankenstein.lmnl',
   "Tempest.xlmnl"      := 'file:///C:/Projects/Github/Luminescent/lmnl/Tempest.lmnl'       }
  
for $file in map:keys($fileSet)
let $fileURI := map($fileSet,$file)
let $lmnl    := file:read-text($fileURI)

return 
  db:add('LMNL-samples', lm:lmnl-to-xLMNL($lmnl,$fileURI), $file)
