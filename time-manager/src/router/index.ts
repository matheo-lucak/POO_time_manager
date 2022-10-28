import WorkingTimesVue from '@/components/features/WorkingTimes/WorkingTimes.vue'
import ClockVue from '@/components/features/Clock/Clock.vue'
import { createRouter, createWebHistory } from 'vue-router'
import ClockManager from '@/components/features/Clock/Clock.vue'

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
    {
      path: '/clocks',
      name: 'clock',
      component: () =>ClockVue
    },
  ]
})

export default router
