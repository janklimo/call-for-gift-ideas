module Wizard.Msgs exposing (..)

import Animation
import Bootstrap.Modal as Modal
import RemoteData exposing (WebData)


type Page
    = Welcome
    | Cards
    | Sort
    | Failure
    | Success


type Msg
    = Navigate Page
    | Like Int
    | Skip Int
    | StartAgain
    | Up Int
    | Down Int
    | FadeInFadeOut Msg
    | SwapCards Msg
    | ConfirmDeletion Int
    | ToggleModalState Modal.State
    | AnimatedDelete
    | HandleSubmitWishlistResponse (WebData String)
    | SubmitWishlist
      -- private messages
    | Animate Animation.Msg
    | Delete Int
