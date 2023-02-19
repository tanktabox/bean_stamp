import type { Dispatch, FC } from 'react'

import Drawer from 'react-modern-drawer'

import 'react-modern-drawer/dist/index.css'

import { Hamburger } from '@/components/Elements/Hamburger'
import { DrawerNavLink } from '@/components/Elements/Link'
import { useAuth } from '@/features/auth'
import type { Roaster } from '@/features/roasters'
import { useCurrentRoaster } from '@/features/roasters'
import type { User } from '@/features/users'

type Props = {
  user: User
  roaster: Roaster | null
  isOpen: boolean
  setIsOpen: Dispatch<React.SetStateAction<boolean>>
}

export const DrawerNav: FC<Props> = (props) => {
  const { user, roaster, isOpen, setIsOpen } = props
  const { isRoaster } = useCurrentRoaster()

  const { signOut } = useAuth()
  const toggleDrawer = () => {
    setIsOpen((prevState) => !prevState)
  }

  const onClickSignOut = () => {
    signOut()
  }

  return (
    <Drawer open={isOpen} onClose={toggleDrawer} direction="right" size={170}>
      <div className="absolute bottom-0 inset-x-0">
        <ul className="flex flex-col w-full text-left ml-auto">
          {isRoaster && roaster ? (
            <>
              {/* ロースター用 */}
              <li>
                <DrawerNavLink to={`/roasters/${roaster.id}`} title="マイロースター" />
              </li>
            </>
          ) : (
            <>
              {/* ユーザー用 */}
              <li>
                <DrawerNavLink to={`/users/${user.id}`} title="マイページ" />
              </li>
              <li>
                <DrawerNavLink to={`/users/${user.id}/following`} title="フォロー" />
              </li>
            </>
          )}
          <li>
            <DrawerNavLink to="/help" title="ヘルプ" />
          </li>
          <li>
            <button type="button" onClick={onClickSignOut} className="w-full text-left">
              <DrawerNavLink to="#" title="サインアウト" />
            </button>
          </li>
        </ul>
        <div className="h-14 pr-8 flex items-center justify-end">
          <Hamburger toggled={isOpen} toggle={toggleDrawer} />
        </div>
      </div>
    </Drawer>
  )
}
