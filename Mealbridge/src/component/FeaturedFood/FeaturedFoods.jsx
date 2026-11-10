import { useQuery } from '@tanstack/react-query'; //Fetches and manages server data
// It is a library for fetching, caching, synchronizing and updating server data in React applications.
import React from 'react';
import FeaturedFood from './FeaturedFood';
import { Link } from 'react-router';

const FeaturedFoods = () => {
    
    const { isPending,isError,error,data}= useQuery ({
        queryKey:['featuredFood'],
        queryFn:async ()=>{
            const res= await fetch('./Fooddata.json');
            if (!res.ok) {
                throw new Error("Failed to fetch featured foods");
            }
            return res.json()
        }
    })

    

    if(isError){
        return <p>{error.message}</p>
    }

    if(isPending){
        return <span className="loading loading-spinner text-error"></span>
    }

    return (
        <div className='w-full bg-gray-200 py-4'>

            <div className='text-center'>
                <h1 className='font-bold text-3xl'>Featured Foods</h1>
                <p className='text-xl font-bold mt-3'>Discover the most abundant food items shared by our generous community. 
                Enjoy fresh, good quality meals available for pickup - <span className='text-red-600'>First come, First served</span>
                </p>
            </div>

            <div className='responsive grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 items-stretch justify-center mt-10'>

                {
                    data.map(food=><FeaturedFood key={food._id} food={food}></FeaturedFood>)
                }

            </div>

            <div className='text-center mt-10'>
                <Link to={'/avlailablefood'} className='btn primary text-white shadow border-none '>Show All</Link>

            </div>
            
        </div>
    );
};

export default FeaturedFoods;