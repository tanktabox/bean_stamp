import type { Offer } from '@/features/offers'

type Options = {
  offer: Offer
}

export const isAfterReceiptStartedAt = ({ offer }: Options) => {
  const now = new Date()
  const rowDate = new Date(offer.receiptStartedAt)
  const [year, month, date] = [rowDate.getFullYear(), rowDate.getMonth(), rowDate.getDate()]
  const receiptStartedAt = new Date(year, month, date)

  return now >= receiptStartedAt
}
