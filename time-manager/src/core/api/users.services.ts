import AxiosServices from "@/core/api/axios.services";
import axios from "axios";
import type {User} from "@/core/interfaces/user.interface";

export default class UsersServices extends AxiosServices
{
    public async getUser(userID: number) : Promise<User>
    {
        return this.get(`/users/${userID}`, null);
    }

    public async getAllUser(email: string | undefined, username: string | undefined) : Promise<User>
    {
        let queryParams : any = {params: {        } };
        if (email)
        {
            queryParams.params.email = email;
        }
        if (username)
        {
            queryParams.params.username = username;
        }
        return this.get(`/users`, queryParams)
    }

    public async postUser(userID: number) : Promise<User>
    {
        return this.post(`/users/${userID}`, null,null);
    }

    public async putUser(userID: number) : Promise<User>
    {
        return this.put(`/users/${userID}`, null, null);
    }

    public async deleteUser(userID: number) : Promise<User>
    {
        return this.delete(`/users/${userID}`, null);
    }

    public async loginUser(email: string, password: string) : Promise<User>
    {
        return this.post(`/auth/login`, null, null).then(response => {
            axios.defaults.headers.common['Authorization'] = 'Bearer ' + response.data.token;

            localStorage.setItem('token', JSON.stringify(response.data.token));
            let user: User = {
                username: response.data.username,
                userID: response.data.userID,
                role: response.data.username,
                email: response.data.email
            };
            return user;
        });
    }

    public async registerUser(email: string, username: string, password: string) : Promise<User> {
        return this.post(`/auth/register`, null, null).then(response => {
            axios.defaults.headers.common['Authorization'] = 'Bearer ' + response.data.token;

            localStorage.setItem('token', JSON.stringify(response.data.token));
            let user: User = {
                username: response.data.username,
                userID: response.data.userID,
                role: response.data.username,
                email: response.data.email
            };
            return user;
        })
    }
}
