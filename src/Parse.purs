module Parse where

import Data.Either (Either(..))
import Prelude (class Show, (<>))

--| A Parser performs some parsing on the given ParseState and
--| generates the next ParseState (or an error)
type Parser = ParseState -> Either ParseError ParseState

--|
--| Representation of errors while parsing
newtype ParseError = ParseError String

instance showParseError :: Show ParseError where
  show (ParseError msg) = "ParseError: " <> msg

--|
--| 
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

