import type { FC } from 'react'
import { memo } from 'react'
import { Link as ReactLink } from 'react-router-dom'

import { PrimaryButton } from '@/components/Elements/Button'
import { Card, CardContainer } from '@/components/Elements/Card'
import { Link } from '@/components/Elements/Link'
import { RoasterImage } from '@/features/roasters/components/molecules/RoasterImage'
import { useCurrentRoaster } from '@/features/roasters/hooks/useCurrentRoaster'
import type { Roaster } from '@/features/roasters/types'
import { fullAddress } from '@/features/roasters/utils/fullAddress'

type Props = {
  roaster: Roaster
}

export const RoasterCard: FC<Props> = memo((props) => {
  const { roaster } = props
  const { currentRoaster } = useCurrentRoaster()

  return (
    <Card>
      <CardContainer>
        <div className="items-center flex flex-col lg:flex-row">
          <div className="lg:w-1/2 lg:mx-4 text-center lg:text-left">
            <div className="lg:flex lg:items-end">
              <ReactLink to={`/roasters/${roaster.id}`}>
                <div className="text-2xl font-medium text-gray-800">{roaster.name}</div>
              </ReactLink>
              {roaster.id === currentRoaster?.id ? (
                <div className="ml-4">
                  <Link to="/roasters/edit">編集</Link>
                </div>
              ) : null}
            </div>
            <div className="flex items-baseline justify-around lg:justify-start">
              {/* TODO follow機能実装時に人数を表示する */}
              <Link to={`/roasters/${roaster.id}/following`}>フォロー人数</Link>
              <div className="ml-4">
                {/* TODO コンポーネント化する */}
                {roaster.id !== currentRoaster?.id ? (
                  <div className="ml-4">
                    <PrimaryButton>Followボタン</PrimaryButton>
                  </div>
                ) : null}
              </div>
            </div>
            <div className="mt-4 text-gray-500 lg:max-w-md">
              <div>住所: {fullAddress({ roaster })}</div>
              <div>TEL: {roaster.phoneNumber}</div>

              <p className="mt-4">{roaster.describe}</p>
            </div>
          </div>
          <div className="mt-8 lg:mt-0 lg:w-1/2">
            <div className="flex items-center justify-center lg:justify-end">
              <div className="max-w-lg">
                <RoasterImage roaster={roaster} />
              </div>
            </div>
          </div>
        </div>
      </CardContainer>
    </Card>
  )
})
