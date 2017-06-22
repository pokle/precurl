module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Parse (ParseState(..), inp, Parser, string, seq)

http :: Parser
http = string "http://" 

dom :: Parser
dom = string "purescript.org"

parse :: Parser
parse = seq [http, dom]

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log $ show $ parse $ inp "http://purescript.org"
