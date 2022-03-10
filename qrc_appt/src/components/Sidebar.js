import React from 'react'
import {FaRegUser, FaRegPlusSquare,FaSearchengin} from 'react-icons/fa'
import './Sidebar.css'


export default function Sidebar() {
    return (

        <aside>

            <div className='group'>
                <FaRegUser style={{color:"#2d2db1"}}/>
                <br/>
                <FaRegPlusSquare style={{color:"#2d2db1"}}/>
                <br/>
                <FaSearchengin style={{color:"#2d2db1"}} />
        
            </div>
          
            
            
        </aside>
    )
}
