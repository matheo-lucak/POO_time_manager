import WorkingTimesVue from '@/components/features/WorkingTimes/WorkingTimes.vue'
import ClockVue from '@/components/features/Clock/Clock.vue'
import LoginVue from '@/components/features/User/components/Login.vue'
import RegisterVue from '@/components/features/User/components/Register.vue'
import { createRouter, createWebHistory } from 'vue-router'
import RickCompliantVue from '@/components/shared/RickCompliant.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('@/components/features/Features.vue'),
      children: [
        {
          path: '/',
          redirect: '/workingtimes'
        },
        {
          path: '/workingtimes',
          name: 'workingtimes',
          component: () => import('@/components/features/WorkingTimes/WorkingTimes.vue')
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
          component: () =>ClockVue
        },
        {
          path: '/auth/login',
          name: 'login',
          component: () =>LoginVue
        },
        {
          path: '/auth/register',
          name: 'register',
          component: () =>RegisterVue
        },
        {
          path: '/rgpd',
          name: 'rgpd',
          component: () =>RickCompliantVue
        },
        {
          path: '/contact',
          name: 'contact',
          component: () =>RickCompliantVue
        },
        {
          path: '/howaboutda',
          name: 'howaboutda',
          component: () =>RickCompliantVue
        },
    
      ]
    },
    
  ]
})

export default router
