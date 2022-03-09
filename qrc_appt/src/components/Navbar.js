import React from 'react'
import './Navbar.css'
import  {FaSearchengin} from "react-icons/fa";
import {FaEthereum} from 'react-icons/fa'
import magnifying_glass from '../images/magnifying_glass.png'

export default function Navbar() {
    return (
        <div className="navbar">
                           
                <FaEthereum style={{fontSize: "50px", color: "#2d2db1"}}/>

                <form >
                        <input className="search-field" placeholder="Search NFT Appts"/> 
                        <button className="search-button">
                            <i>  <FaSearchengin style={{fontSize: "190%"}}/> </i> 
                        </button>

                </form>
               
            <a >Connect Wallet</a>
        </div>
    )
}
