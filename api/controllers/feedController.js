const Post = require('../models/post');

exports.showFeed = async (req, res) => {
    try{
        const posts = await Post.find({});
        const nearby_posts = posts.map(p => {
            if(calculateDistance(req.body.latitude, req.body.longitude, p.latitude, p.longitude) <= 5){
                return p;
            }
        });
        res.json(nearby_posts);
    }catch(error){
        console.error('Error showing feed:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
}

const calculateDistance = async (lat1, long1, lat2, long2) => {
    try{
        lat1 = degToRad(lat1);
        long1 = degToRad(long1);
        lat2 = degToRad(lat2);
        long2 = degToRad(long2);
        
        return distance = 1.609344 * (3963.0 *
            Math.acos((Math.sin(lat1) * Math.sin(lat2)) +
            Math.cos(lat1) * Math.cos(lat2) * Math.cos(long2 - long1))); // 1.609344 is to convert miles into kilometers
        
    }catch (error) {
        console.error('Error calculating distance:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
}

const degToRad = (degrees) => {
    return (degrees % 360) * (Math.PI / 180);
}

/* Test Data:
    KU: 27.620405, 85.538609
    Bhatbhateni, bhaktapur: 27.675083, 85.398047
    KU Medical: 27.607235, 85.548595
*/