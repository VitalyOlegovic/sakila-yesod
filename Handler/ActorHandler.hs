module Handler.ActorHandler where

import Import
import Database.Persist.Sql
import Database.Persist.Types (PersistValue(PersistInt64))
import Database.Persist.Class

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
    insertedActor <- runDB $ insertEntity actor
    defaultLayout $ do
        $(widgetFile "actor-new")

getEditActorR :: Handler Html
getEditActorR = do
    actorId <- runInputGet $ ireq intField "id"
    maybeActor <- runDB $ get $ ActorKey actorId
    case maybeActor of
        Just actor -> defaultLayout $ do
            $(widgetFile "actor-edit")
        Nothing -> defaultLayout $ do
            $(widgetFile "actor-new")
    

getDeleteActorR :: Handler Html
getDeleteActorR = do
    defaultLayout $ do
        $(widgetFile "actor-delete")
