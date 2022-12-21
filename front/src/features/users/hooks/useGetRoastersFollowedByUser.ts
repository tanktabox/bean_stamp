import { useCallback, useState } from 'react'
import { useNavigate } from 'react-router-dom'

import type { Roaster } from '@/features/roasters'
import { getRoastersFollowedByUser as getRoastersFollowedByUserRequest } from '@/features/users/api/getRoastersFollowedByUser'
import { useMessage } from '@/hooks/useMessage'

export const useGetRoastersFollowedByUser = () => {
  const navigate = useNavigate()
  const { showMessage } = useMessage()

  const [loading, setLoading] = useState(false)
  const [roasters, setRoasters] = useState<Array<Roaster>>()

  const getRoastersFollowedByUser = useCallback((id: string) => {
    setLoading(true)
    getRoastersFollowedByUserRequest({ id })
      .then((response) => {
        setRoasters(response.data)
      })
      .catch(() => {
        navigate('/')
        showMessage({ message: 'ユーザーが存在しません', type: 'error' })
      })
      .finally(() => {
        setLoading(false)
      })
  }, [])

  return { roasters, getRoastersFollowedByUser, loading }
}
