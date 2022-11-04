import type { FC } from 'react'
import { memo } from 'react'
import { Link } from 'react-router-dom'

import { BottomNavItem } from '@/components/Layout/Nav/BottomNavItem'

export const RoasterBottomNav: FC = memo(() => (
  <>
    {/* ロースター用 */}
    {/* TODO Roaster Homeリンク */}
    <Link to="/roaster/home">
      <BottomNavItem>
        <svg className="w-8 h-8">
          <use xlinkHref="#home-solid" />
        </svg>
      </BottomNavItem>
    </Link>
    {/* TODO ロースターページリンク */}
    <Link to="/roaster/show">
      <BottomNavItem>
        <i className="fa-solid fa-mug-saucer fa-xl" />
      </BottomNavItem>
    </Link>
    {/* TODO Offersリンク */}
    <Link to="/roaster/show">
      <BottomNavItem>
        <svg className="w-8 h-8">
          <use xlinkHref="#clipboard-solid" />
        </svg>
      </BottomNavItem>
    </Link>
    {/* TODO ビーンズリンク */}
    <Link to="/roaster/show">
      <BottomNavItem>
        <svg className="h-8 w-8 transform -rotate-45">
          <use xlinkHref="#coffee-bean-solid" />
        </svg>
      </BottomNavItem>
    </Link>
  </>
))
