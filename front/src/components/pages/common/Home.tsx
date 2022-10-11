import type { FC } from 'react'
import { memo } from 'react'
import { Navigate } from 'react-router-dom'

import { useCurrentUser } from '@/hooks/useCurrentUser'

export const Home: FC = memo(() => {
  const { isSignedIn } = useCurrentUser()

  // ルートパスアクセス時にログイン済みならリダイレクト
  if (isSignedIn) {
    return <Navigate to="/user/home" replace />
  }

  return (
    <>
      <h1 className="text-3xl font-bold underline text-red-600">Hello world!</h1>
      <p>トップページです。</p>
    </>
  )
})
