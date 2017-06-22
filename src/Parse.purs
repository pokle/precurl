module Parse where

import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Show (show)
import Data.String (Pattern(..), stripPrefix)
import Prelude (class Show, (<>))
import Data.Foldable (foldl)

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

inp s = ParseState { inp: s, out: "" }

instance showParseState :: Show ParseState where
  show (ParseState {inp, out}) = "{inp: " <> (show inp) <> ", out: " <> (show out) <> "}"

--|
--| Parsers

string :: String -> Parser
string str (ParseState state) = 
  case stripPrefix (Pattern str) state.inp of
    Just suffix ->  Right (ParseState state { inp = suffix })
    _ -> Left (ParseError ("Expected '" <> str <> "', but saw '" <> state.inp <> "'"))

--|
--| Combinators

zeroParser :: Parser
zeroParser ps = Right ps

andParser :: Parser -> Parser -> Parser
andParser a b parseState = case a parseState of
  Right parseOfA -> b parseOfA
  Left parseError -> Left parseError  

--| Calls a sequence of Parsers, and only succeeds if they all succeed.
seq :: Array Parser -> Parser
seq parsers = foldl andParser zeroParser parsers

