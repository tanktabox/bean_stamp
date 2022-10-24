import { regexp } from '@/utils/regexp'

export const validation = {
  required: '値を入力してください',
  minLength: (minLength: number) => ({ value: minLength, message: `${minLength}文字以上入力してください` }),
  maxLength: (maxLength: number) => ({ value: maxLength, message: `最大${maxLength}文字以下入力できます` }),
  pattern: {
    email: { value: regexp.email, message: 'メールアドレスの形式が正しくありません' },
    password: { value: regexp.password, message: '半角英数記号を入力してください' },
  },
  validate: {
    confirm: (targetValue: unknown, value: unknown, name?: string) =>
      targetValue === value || `${name || '値'}が一致しません`,
  },
}
