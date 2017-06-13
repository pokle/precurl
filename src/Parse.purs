module Parse where

import Data.Either (Either(..))
import Prelude (class Show, (<>))

data ParseError = OhNo String
newtype ParseState = ParseState {
  inp :: String,
  out :: String
}

type Parser = ParseState -> Either ParseError ParseState

instance showParseError :: Show ParseError where
  show (OhNo msg) = "Error: " <> msg

instance showParseState :: Show ParseState where
  show (ParseState {inp, out}) = "inp: " <> inp <> ", out: " <> out

-- |
-- | 

string :: String -> Parser
string str = \state -> Left (OhNo "No way")

