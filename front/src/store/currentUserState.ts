import { atom } from 'recoil'

import type { User } from '@/types'

// atomで指定した型はdefault内のとセットしたstateに影響
export const currentUserState = atom<User | null>({
  key: 'currentUserState',
  default: null,
})
