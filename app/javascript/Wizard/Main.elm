module Wizard.Main exposing (..)

import Wizard.App exposing (..)
import Html exposing (programWithFlags)


main : Program Flags Model Msg
main =
    programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
