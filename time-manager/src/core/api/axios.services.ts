import axios, { type AxiosInstance, type AxiosRequestConfig } from 'axios'

export default class AxiosServices
{
    private axiosClient: AxiosInstance;
// server 10.134.198.1
    constructor() {
        this.axiosClient = axios.create({
            baseURL: "http://localhost:4000/api"
        });
    }
    public async get(url: string, config : any) : Promise<any>
    {
        let token = localStorage.getItem('token');
        if (token && config !== null)
        {
            config.headers = {
                'Authorization': `Bearer ${token}`
            }
        }

        return await this.axiosClient.get(url, config);

    }

    public async post(url: string, body: any, config: any) : Promise<any>
    {
        let token = localStorage.getItem('token');
        if (token && config)
        {
            config.headers = {
                'Authorization': `Bearer ${token}`
            }
        }

        return await this.axiosClient.post(url, body, config);
    }

    public async put(url: string, body: any, config: any) : Promise<any>
    {
        let token = localStorage.getItem('token');
        if (token && config)
        {
            config.headers = {
                'Authorization': `Bearer ${token}`
            }
        }
        return await this.axiosClient.put(url, body, config);
    }

    public async delete(url: string, config: any) : Promise<any>
    {
        let token = localStorage.getItem('token');
        if (token && config)
        {
            config.headers = {
                'Authorization': `Bearer ${token}`
            }
        }
        return await this.axiosClient.delete(url, config);
    }

}

