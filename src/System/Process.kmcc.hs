{-# LANGUAGE MagicHash #-}

import qualified Prelude as P
import qualified System.Process as S
import qualified System.Exit as S
import qualified System.Time.Extra as S
import BasicDefinitions

processdotgetPID_Det# = S.getCurrentPid P.>>= P.return P.. P.fromIntegral
processdotgetPID_ND# = P.return processdotgetPID_Det#

processdotprimuscoresystem_Det# x = fromForeign P.$ do
  p <- S.spawnCommand (toForeign x)
  e <- S.waitForProcess p
  case e of
    S.ExitSuccess   -> P.return 0
    S.ExitFailure i -> P.return (P.toInteger i)
processdotprimuscoresystem_ND# = liftConvertIO1 processdotprimuscoresystem_Det#

processdotprimuscoreexitWith_Det# x | x P.== 0    = S.exitWith S.ExitSuccess
                                    | P.otherwise = S.exitWith (S.ExitFailure (P.fromInteger x))
processdotprimuscoreexitWith_ND# = P.return P.$ Func P.$ \x -> do
  x' <- x
  P.return (processdotprimuscoreexitWith_Det# x')

processdotprimuscoresleep_Det# x = fromForeign P.$ S.sleep (P.fromIntegral x)
processdotprimuscoresleep_ND# = liftConvertIO1 processdotprimuscoresleep_Det#