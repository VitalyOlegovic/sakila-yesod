module Handler.ActorHandler where

import Import

getActorListR :: Handler Html
getActorListR = do
    actorList <- runDB $ selectList ([] :: [Filter Actor]) []
    defaultLayout $ do
        --Set the title
        let title = "Actor list" :: String
        setTitle (toHtml title)
        --Set the view to use to show data to the user
        $(widgetFile "actor-list")

getNewActorR :: Handler Html
getNewActorR = do
    defaultLayout $ do
        $(widgetFile "actor-new")

postCreateActorR :: Handler Html
postCreateActorR = do
    firstName <- runInputPost $ ireq textField "firstName"
    lastName <- runInputPost $ ireq textField "lastName"
    now <- liftIO getCurrentTime
    let actor = Actor firstName lastName now
    _ <- ($) runDB $ insertEntity actor
    getActorListR

getEditActorR :: Handler Html
getEditActorR = do
    actorId <- runInputGet $ ireq intField "id"
    maybeActor <- runDB $ get $ ActorKey actorId
    case maybeActor of
        Just actor -> defaultLayout $ do
            $(widgetFile "actor-edit")
        Nothing -> getActorListR
    
postUpdateActorR :: Handler Html
postUpdateActorR = do
    actorId <- runInputPost $ ireq intField "actorId"
    firstName <- runInputPost $ ireq textField "firstName"
    lastName <- runInputPost $ ireq textField "lastName"
    now <- liftIO getCurrentTime
    let actor = Actor firstName lastName now
    runDB $ replace (ActorKey actorId) $ actor
    getActorListR

getDeleteActorR :: Handler Html
getDeleteActorR = do
    actorId <- runInputGet $ ireq intField "id"
    runDB $ delete (ActorKey actorId)
    getActorListR
