'use strict';

var ReactNative = require('react-native');
var React = require('react');
var SearchPage = require('./SearchPage');

var {
	AppRegistry,
	StyleSheet,
	View,
	Text
} = ReactNative;

var styles = StyleSheet.create({
  text:{
    color:'black',
    backgroundColor:'white',
    fontSize:30,
    margin:80
  },
  container:{
  	flex:1
  }
});

class HelloWorld extends React.Component {
	render() {
		return <Text style={styles.text}>Hello World</Text>;
	}
}
class PropertyFinderApp extends React.Component{
  render(){
    return (
    	<ReactNative.NavigatorIOS
     	 style={styles.container}
     	 initialRoute={{
     	 	title:'Property Finder',
     	 	component: SearchPage,
     	 }}/>
    	);
  }
}

AppRegistry.registerComponent('PropertyFinder',function(){return PropertyFinderApp});