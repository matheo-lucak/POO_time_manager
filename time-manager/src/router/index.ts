import WorkingTimesVue from '@/components/features/WorkingTimes/WorkingTimes.vue'
import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'workingtimes',
      component: WorkingTimesVue
    },
    {
      path: '/chart-manager',
      name: 'chart-manager',
      component: () => import('@/components/features/ChartManager/ChartManager.vue')
    },
  ]
})

export default router
