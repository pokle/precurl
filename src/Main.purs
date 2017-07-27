module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Parse (Parser, inp, seq, string)

protocol :: Parser
protocol = string "http://" 

domain :: Parser
domain = string "purescript.org"

url :: Parser
url = seq [protocol, domain]

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log $ show $ url $ inp "http://pur,escript.org"
