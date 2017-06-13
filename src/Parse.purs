module Parse where

import Data.Either (Either(..))
import Prelude (class Show, (<>))

-- | A Parser is just a function 
type Parser = ParseState -> Either ParseError ParseState

newtype ParseError = ParseError String

instance showParseError :: Show ParseError where
  show (ParseError msg) = "Error: " <> msg

newtype ParseState = ParseState {
  inp :: String,
  out :: String
}

instance showParseState :: Show ParseState where
  show (ParseState {inp, out}) = "inp: " <> inp <> ", out: " <> out

-- |
-- | 

string :: String -> Parser
string str = \state -> Left (ParseError "No way")

