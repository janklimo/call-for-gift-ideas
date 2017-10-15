module Wizard.Msgs exposing (..)

import Wizard.Models exposing (..)


type Msg
    = Navigate Page
    | Like Int
    | Skip Int
    | StartAgain
    | Up Int
    | Down Int
