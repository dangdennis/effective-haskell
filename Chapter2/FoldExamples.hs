module FoldExamples where
import Prelude hiding (foldl, foldr)

foldl func carryVal lst =
    if null lst then carryVal
    else foldl func (func carryVal (head lst)) (tail lst)

foldr func carryVal lst = 
    if null lst then carryVal
    else func (head lst) $ foldr func carryVal (tail lst)