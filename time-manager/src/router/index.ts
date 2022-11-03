import WorkingTimesVue from '@/components/features/WorkingTimes/WorkingTimes.vue'
import { createRouter, createWebHistory } from 'vue-router'
import ClockManager from '@/components/features/Clock/Clock.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      redirect: '/workingtimes'
    },
    {
      path: '/workingtimes',
      name: 'workingtimes',
      component: WorkingTimesVue
    },
    {
      path: '/workingtime/:userId/:id',
      name: 'workingtime',
      component: () => import('@/components/features/WorkingTimes/WorkingTime.vue')
    },
    {
      path: '/workingtime/:userId',
      name: 'create-workingtime',
      component: () => import('@/components/features/WorkingTimes/WorkingTime.vue')
    },
    {
      path: '/charts',
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
