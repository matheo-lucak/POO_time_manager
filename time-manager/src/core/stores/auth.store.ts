import { defineStore } from 'pinia';
import router from "@/router";
import AxiosServices from "@/core/api/axios.services";

export const useAuthStore = defineStore({
    id: 'auth',
    state: () => ({
        // initialize state from local storage to enable user to stay logged in
        token: JSON.parse(localStorage.getItem('token') ?? ""),
        axiosServices: new AxiosServices(),
        returnUrl: null
    }),
    actions: {
        async login(username: string, password: string) {
            const token = await this.axiosServices.post("/auth/login", { username, password }, null);

            // update pinia state
            this.token = token;

            // store user details and jwt in local storage to keep user logged in between page refreshes
            localStorage.setItem('token', JSON.stringify(token));

            // redirect to previous url or default to home page
            await router.push(this.returnUrl || '/');
        },
        logout() {
            this.token = null;
            localStorage.removeItem('token');
            router.push('/login');
        }
    }
});
