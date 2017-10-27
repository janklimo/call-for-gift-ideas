module Wizard.Msgs exposing (..)

import Animation
import Bootstrap.Modal as Modal


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
    | ModalMsg Modal.State
