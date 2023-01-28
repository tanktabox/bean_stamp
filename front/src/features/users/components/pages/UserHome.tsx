import type { FC } from 'react'
import { useEffect, memo } from 'react'
import { useSearchParams } from 'react-router-dom'

import { SecondaryButton } from '@/components/Elements/Button'
import { ContentHeader, ContentHeaderTitle } from '@/components/Elements/Content'
import { Link } from '@/components/Elements/Link'
import { Pagination } from '@/components/Elements/Pagination'
import { Spinner } from '@/components/Elements/Spinner'
import { Head } from '@/components/Head'
import { useLoadUser } from '@/features/auth'
import { useSignedInUser } from '@/features/auth/hooks/useSignedInUser'
import { OfferContentCard } from '@/features/offers'
import { useGetCurrentOffers } from '@/features/users/hooks/useGetCurrentOffers'

export const UserHome: FC = memo(() => {
  const { signedInUser } = useSignedInUser()
  const { loadUser } = useLoadUser()
  const { currentOffers, getCurrentOffers, loading, totalPage, currentPage } = useGetCurrentOffers()
  const [searchParams, setSearchParams] = useSearchParams()

  // NOTE サインイン直後のユーザー＆ロースター情報の更新はここでOKか？
  useEffect(() => {
    void loadUser()
  }, [])

  useEffect(() => {
    // フォローしているロースターのオファー一覧を取得
    getCurrentOffers({ page: searchParams.get('page') })
  }, [searchParams])

  const onClickReload = () => {
    getCurrentOffers({ page: null })
    setSearchParams({})
  }

  return (
    <>
      <Head title="ホーム" />
      <ContentHeader>
        <div className="h-full flex justify-between items-end">
          <ContentHeaderTitle title={`${signedInUser?.name ?? ''}のホーム`} />
        </div>
      </ContentHeader>

      {/* オファー更新ボタン */}
      <div className="flex justify-center">
        <SecondaryButton onClick={onClickReload}>
          {loading ? (
            <Spinner />
          ) : (
            <svg className="h-6 w-6 text-gray-500">
              <use xlinkHref="#arrow-path" />
            </svg>
          )}
        </SecondaryButton>
      </div>

      {!loading && (
        <>
          {/* オファー 一覧 */}
          {currentOffers && (
            <section className="mt-4">
              {currentOffers.length ? (
                <>
                  <ol>
                    {currentOffers.map((offer) => (
                      <li key={offer.id} className="mb-20">
                        <OfferContentCard offer={offer} />
                      </li>
                    ))}
                  </ol>
                  {currentPage && totalPage && <Pagination currentPage={currentPage} totalPage={totalPage} />}
                </>
              ) : (
                <div className="text-center text-gray-400">
                  <p>オファーがありません</p>
                  <Link to="/search">ロースターをフォローしてオファーを受け取る</Link>
                </div>
              )}
            </section>
          )}
        </>
      )}
    </>
  )
})
