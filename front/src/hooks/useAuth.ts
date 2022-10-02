import { useCallback, useState } from 'react'
import { useNavigate } from 'react-router-dom'

import 'react-toastify/dist/ReactToastify.css'
import { useCookies } from 'react-cookie'

import { useLoginUser } from '@/hooks/useLoginUser'
import { useMessage } from '@/hooks/useMessage'
import client from '@/lib/api/client'
import type { SignInParams, SignUpParams, User } from '@/types/api/user'

import type { AxiosError, AxiosResponse } from 'axios'

// apiからのレスポンスは{ data { data : User } }という階層になっている
type authResponseType = {
  data: User
}

export const useAuth = () => {
  const navigate = useNavigate()
  const { showMessage } = useMessage()
  const [loading, setLoading] = useState(false)
  const { setLoginUser } = useLoginUser()

  const [cookies, setCookie, removeCookie] = useCookies(['uid', 'client', 'access-token'])

  const signUp = useCallback((params: SignUpParams) => {
    setLoading(true)
    client
      .post('auth/', params)
      .then((res: AxiosResponse<authResponseType>) => {
        // 認証情報をcookieにセット
        setCookie('uid', res.headers.uid, { path: '/' })
        setCookie('client', res.headers.client, { path: '/' })
        setCookie('access-token', res.headers['access-token'], { path: '/' })
        setLoginUser(res.data.data)
        showMessage({ message: 'ユーザー登録が完了しました', type: 'success' })
        navigate('/user/home')
      })
      // TODO エラーメッセージをトーストではなくメッセージとして表示するhooksを作成する
      // エラーメッセージはstateとして保持した方がいい気がする
      .catch((err: AxiosError<{ errors: { fullMessages: Array<string> } }>) => {
        const errorMessages = err.response?.data.errors.fullMessages
        errorMessages?.map((errorMessage) => showMessage({ message: `${errorMessage}`, type: 'error' }))
      })
      .finally(() => {
        setLoading(false)
      })
  }, [])

  const signIn = useCallback((params: SignInParams) => {
    setLoading(true)
    client
      .post<authResponseType>('auth/sign_in', params)
      .then((res) => {
        // 認証情報をcookieにセット
        setCookie('uid', res.headers.uid, { path: '/' })
        setCookie('client', res.headers.client, { path: '/' })
        setCookie('access-token', res.headers['access-token'], { path: '/' })
        setLoginUser(res.data.data) // グローバルステートにUserの値をセット
        showMessage({ message: 'ログインしました', type: 'success' })
        navigate('/user/home')
      })
      .catch(() => {
        showMessage({ message: 'メールアドレスもしくはパスワードが正しくありません', type: 'error' })
      })
      .finally(() => {
        setLoading(false)
      })
  }, [])

  const signOut = useCallback(() => {
    client
      .get('auth/sign_out', {
        headers: {
          uid: cookies.uid as string,
          client: cookies.client as string,
          'access-token': cookies['access-token'] as string,
        },
      })
      .then(() => {
        // 認証情報をのcookieを削除
        removeCookie('uid')
        removeCookie('client')
        removeCookie('access-token')
        setLoginUser(null) // LoginUserStateを削除
        showMessage({ message: 'ログアウトしました', type: 'success' })
        navigate('/')
      })
      .catch(() => {
        showMessage({ message: 'ログアウトに失敗しました', type: 'error' })
      })
      .finally(() => {
        setLoading(false)
      })
  }, [])
  return { signUp, signIn, signOut, loading, setLoginUser }
}
