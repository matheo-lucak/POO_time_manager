import WorkingTimesVue from '@/components/features/WorkingTimes/WorkingTimes.vue'
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
      path: '/workingtime/:id',
      name: 'workingtime',
      component: () => import('@/components/features/WorkingTimes/WorkingTime.vue')
    },
    {
      path: '/chart-manager',
      name: 'chart-manager',
      component: () => import('@/components/features/ChartManager/ChartManager.vue')
    },
    {
      path: '/clocks',
      name: 'clock',
      component: ClockManager
    },
  ]
})

export default router
