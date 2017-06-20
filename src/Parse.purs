module Parse where

import Data.Maybe
import Data.Either (Either(..))
import Data.Show (show)
import Data.String (Pattern(..), stripPrefix)
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
  show (ParseState {inp, out}) = "{inp: " <> (show inp) <> ", out: " <> (show out) <> "}"

-- |
-- | 

string :: String -> Parser
string str (ParseState state) = 
  case stripPrefix (Pattern str) state.inp of
    Just suffix ->  Right (ParseState state { inp = suffix })
    _ -> Left (ParseError "No way")

