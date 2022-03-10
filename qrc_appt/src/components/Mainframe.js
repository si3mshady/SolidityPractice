import React from 'react'
import './Mainframe.css'
import Datacard from './Datacard'
import {data} from '../starterData'

export default function Mainframe() {
    return (
        <div className="container">

            {data.map(url => (<Datacard url={url}/>))}
        
        </div>
    )
}
