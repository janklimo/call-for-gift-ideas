module Wizard.Msgs exposing (..)

import Animation


type Page
    = Welcome
    | Cards
    | Sort


type Msg
    = Navigate Page
    | Like Int
    | Skip Int
    | StartAgain
    | Up Int
    | Down Int
    | Animate Animation.Msg
    | FadeInFadeOut Msg
