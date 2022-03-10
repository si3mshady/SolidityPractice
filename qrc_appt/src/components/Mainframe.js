import React from 'react'
import {useContext} from 'react'

import './Mainframe.css'
import Datacard from './Datacard'
// import {data} from '../starterData'
import {ChainContext} from '../context/chainContext'



export default function Mainframe() {
    const {starterData} = useContext(ChainContext)
    return (
        <div className="container">

            {starterData.map(url => (<Datacard key={url}  url={url}/>))}
                           
        
        </div>
    )
}
