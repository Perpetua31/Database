
#Perpetua Sarina musicdb_senatus

 #All sensitive information, such as passwords, hosts, and IP addresses, has been replaced with '0' to ensure security and privacy in this project.


/* Create the database system in GCP */
gcloud sql instances create final2024 \
--database-version MYSQL_8_0 \
--root-password '0000' \
--authorized-networks 000.00.000.0/00 \ 
--storage-type SSD \
--storage-size 10GB \
--tier=db-n1-standard-1 \
--region=us-east1

\connect --mysql --user root --host 00.000.00.000 --ssl-ca=server-ca.pem --ssl-cert=client-cert.pem --ssl-key=client-key.pem --password

/* switch into SQL mode and create the schema and tables */


-- Create a schema called musicdb_lastname (Where lastname is your lastname ie. John Smith will have a schema called musicdb_smith)
CREATE DATABASE `musicdb_senatus`;


-- Create a database user called musicadmin who has access to the musicdb and no other databases but musicdb_lastname 
-- Give this user a password 
using GCP :
gcloud sql connect final2024 --user=root

CREATE USER 'musicadmin'@'%' IDENTIFIED BY '000000';  

GRANT ALL PRIVILEGES ON musicdb_senatus.* TO 'musicadmin'@'%';

FLUSH PRIVILEGES;


-- Confirm that you can sign in as this user from cli (command line interface ie. terminal) remotely
using terminal : 
\q
\mysqlsh
\connect musicadmin@00.000.00.000


/* go back to old connection to create tables*/
\q
\connect --mysql --user root --host 00.000.00.000--ssl-ca=server-ca.pem --ssl-cert=client-cert.pem --ssl-key=client-key.pem --password

SHOW DATABASES;

USE `musicdb_senatus`;


-- Generate the following tables in this schema (Artist, Album, Lyrics) with appropriate relationships
CREATE TABLE `Artist` (
    `artistId` INT AUTO_INCREMENT PRIMARY KEY,
    `artistName` VARCHAR(255) NOT NULL,
    `genre` VARCHAR(100) NOT NULL
);

-- Create Album table
CREATE TABLE `Album` (
    `albumId` INT AUTO_INCREMENT PRIMARY KEY,
    `artistId` INT,
    `albumTitle` VARCHAR(255) NOT NULL,
    `albumReleaseYear` YEAR,
    FOREIGN KEY (`artistId`) REFERENCES `Artist`(`artistId`)
);

-- Create Lyrics table
CREATE TABLE `Lyrics` (
    `lyricsId` INT AUTO_INCREMENT PRIMARY KEY,
    `albumId` INT,
    `songTitle` VARCHAR(255) NOT NULL,
    `trackNumber` INT NOT NULL,
    `lyricsDisplay` TEXT NOT NULL,
    FOREIGN KEY (`albumId`) REFERENCES `Album`(`albumId`)
);

-- Insert data into Artist table
INSERT INTO `Artist` (`artistName`, `genre`)
VALUES 
('XXXTentacion', 'Hip-Hop'), 
('DaBaby', 'Hip-Hop'), 
('Travis Scott', 'Hip-Hop'), 
('2Pac', 'Hip-Hop'), 
('Nas', 'Hip-Hop'), 
('Lil Wayne', 'Hip-Hop'), 
('Kanye West', 'Hip-Hop'), 
('Snoop Dog', 'Hip-Hop'), 
('Drake', 'Hip-Hop'), 
('Nicki Minaj', 'Hip-Hop');


-- Insert data into Album table
INSERT INTO `Album` (`artistId`, `albumTitle`, `albumReleaseYear`)
VALUES  
(1, '? Question Mark', 2018), 
(2, 'Blame It On Baby', 2020), 
(3, 'Astroworld', 2018), 
(4, 'Me Against The World', 1995), 
(5, 'God’s Son', 2002), 
(6, 'Tha Carter IV', 2011), 
(7, 'Late Registration', 2015), 
(8, 'Paid Tha Cost To Be Da Bo$$', 2002), 
(9, 'Thank Me Later', 2010), 
(10, 'Pink Friday (Complete Edition)', 2010); 



-- Import lyrics from https://genius.com/ into the lyrics table using INSERT INTO statements
INSERT INTO `Lyrics` (`albumId`, `songTitle`, `trackNumber`,`lyricsDisplay`)
VALUES (1, 'Changes', 15,
'[Chorus: XXXTENTACION]
Mmm, baby, I don t understand this
You re changing, I can t stand it
My heart can t take this damage
And the way I feel, can t stand it
Mmm, baby, I don t understand this
You re changing, I can t stand it
My heart can t take this damage
And the way I feel, can t stand it
Mmm, baby, I don t understand it

[Bridge: PnB Rock]
Girl, you re makin it hard for me
Girl, you re makin it hard for me
Girl, you re makin it hard for me
Mmm, ohh
Girl, you re makin it hard for me
Girl, you re makin it hard for me
Girl, you re makin  it hard for me

[Chorus: XXXTENTACION & PnB Rock]
Mmm, baby, I don t understand this
You re changing, I can t stand it
My heart can t take this damage
And the way I feel, can t stand it
Mmm, baby, I don t understand this
You re changing, I can t stand it
My heart can t take this damage
And the way I feel, can t stand it
Mmm, baby, I don t understand this

[Outro: XXXTENTACION]
You re changing, I can t stand it
My heart can t take this damage
And the way I feel, can t stand it
Mmm, baby, I don t understand it '),



(2, 'Champion', 9, 
'[Intro]
Yeah, yeah
Wait a minute, who are you? (Ayy, yo, K.i.D.)
Let s go (Woo)

[Chorus]
Yeah, I took the cash route
I put in more time, more grind, no lyin
I didn t take the fast route (Let s go)
Suck it up, no cryin , no cryin , no cryin
I didn t ask for handouts (Yeah)
Go to work, no grind, no shine, no shine
And that s how you stand out (Yeah)
Yeah, that s how I stand out (Yeah)
Yeah, I took the cash route
I put in more time, more grind, no lyin (Let s go)
I didn t take the fast route
Suck it up, no cryin , no cryin, no cryin
I didn t ask for handouts (Uh-uh)
Go to work, no grind, no shine, no shine (Yeah)
And that s how you stand out
Yeah, that s how I stand out (Let s go)

[Verse]
Yeah, I took the cash route
I did it and did it again (What you did?)
I started at one and I went up to ten
Came back, now I m winning again (Uh-huh)
We pull up behind tints, which one he gon hop out? (Skrrt)
They don t know what whip that he in (Vroom)
Put in hours of practice and that s how it happened
I don t even pick up a pen
Nah, I m comin straight up off the top with it (Let s go)
Ain t a power forward, he ain t a center, but he was on the block with me
Shootin in the gym, we really got it in, he put up the shots with me (Uh-huh)
Now we breakin bread, everybody playin , he hold up a knot with me (No cap)
We took the cash route (Let s go)
Yeah, I m talkin mula, fetty (Uh-huh)
We grew up off of noodles, spaghetti
Used to be peanut butter and jelly (Uh-huh)
Now the Chevy gon come when it s ready (Uh-huh)
What you know bout the lights off, candles? (Lights)
I provide with the mic off dancin (Like Mike)
I m a star and I m moonwalkin
Now I got the whole room talkin
Yeah, I m talkin trophies
I got everybody talkin down, actin like they know me
I m a champion like LeBron, ballin with my homies
I m better than the old me
R.I.P. to Kobe, yeah
[Chorus]
Yeah, I took the cash route (Let s go)
Put in more time, more grind, no lyin
I didn t take the fast route (Let s go)
Suck it up, no cryin, no cryin, no cryin
I didn t ask for handouts (Yeah)
Go to work, no grind, no shine, no shine
And that s how you stand out (Yeah)
Yeah, that s how I stand out (Uh-huh)
Yeah, I took the cash route (Let s go)
I put in more time, more grind, no lyin
I didn t take the fast route (Uh-huh)
Suck it up, no cryin, no cryin , no cryin
I didn t ask for handouts (Uh-huh)
Go to work, no grind, no shine, no shine (Yeah)
And that s how you stand out (Yeah)
Yeah, that s how I stand out (Let s go)

[Outro]
Yeah
Yeah
Uh-huh'),





(3, 'Butterfly Effect', 15, 
'
[Intro]
(All the commas)
(Murda on the beat, so it s not nice)
Ooh, hmm

[Chorus]
For this life, I cannot change (Change)
Hidden Hills, deep off in the main (Main)
M&M s, sweet like candy cane (Cane)
Drop the top, pop it, let it bang (Pop it, pop it)
For this life, I cannot change
In the hills, deep off in the main
M&M s, sweet like candy cane
Drop the top, pop it, let it bang (Pop it, pop it)

[Verse 1]
Drop the top, play hide and seek (Yeah)
Jump inside, jump straight to the league (League)
Take a sip, feel just how I be (It s lit)
On Freeway, but no, ain t nothin free (Straight up)
Bend laws, bend lanes (Skrrt, skrrt)
Been bustin bills, but still, ain t nothin change (Skrrt, skrrt, skrrt, skrrt)
You in the mob soon as you rock the chain (Skrrt, skrrt, mob)
She caught the waves, just thumbin through my braids (Alright)
Heatin up, baby, I m just heatin up (It s lit)
Need your love, not a need, it is a must (Yeah)
Feelin stuck, you know how to keep me up (Yeah, yeah)
Icy love, icy like a hockey puck (Alright)

[Chorus]
For this life, I cannot change (Change)
Hidden Hills, deep off in the main (Main)
M&M s, sweet like candy cane (Cane)
Drop the top, pop it, let it bang (Pop it, pop it)
For this life, I cannot change
Hidden Hills, deep off in the main (Yeah, yeah)
M&M s, sweet like candy cane
Drop the top, pop it, let it bang

[Verse 2]
All the ones, all the chains piled on the mantle (Yeah)
All the dawgs, all the dawgs low creep right behind me in the Phantom (It s lit)
Yeah, never go, never go dip on the set, stayed Santana
Yeah, run it back, turn the lights on when I hit up Green Lantern (It s lit, alright)
Yeah, fly the broads, fly the dawgs down to Atlanta
Yeah, in the cut in Medusa, lay low, yeah, I might be
Yeah, roll up, help me calm down when I m movin high speed
Yeah, if I send one, need to text back cause you know what I need (Straight up)
Oh, please, oh, me, oh, my
We been movin, we been movin for some time (Alright)
Flexin, flexin , try to exercise
Exercise (Exercise), exercise (Exercise), exercise (Exercise), exercise (Exercise)
(Yeah, yeah)

[Chorus]
(For this life)
For this life, I cannot change (Change)
Hidden Hills, deep off in the main (Main)
M&M s, sweet like candy cane (Cane)
Drop the top, pop it, let it bang (Pop it, pop it)
For this life, I cannot change
Hidden Hills, deep off in the main
M&M s, sweet like candy cane
Drop the top, pop it, let it bang (Bang, yeah)

'),




(4, 'Dear Mama', 9, 
'[Intro]
You are appreciated

[Verse 1]
When I was young, me and my mama had beef
Seventeen years old, kicked out on the streets
Though back at the time I never thought I d see her face
Ain t a woman alive that could take my mama s place
Suspended from school, and scared to go home
I was a fool, with the big boys breakin all the rules
I shed tears with my baby sister, over the years
We was poorer than the other little kids
And even though we had different daddies, the same drama
When things went wrong we d blame Mama
I reminisce on the stress I caused, it was hell
Huggin on my mama from a jail cell
And who d think in elementary, hey
I d see the penitentiary one day?
And runnin from the police, that s right
Mama catch me, put a whoopin to my backside
And even as a crack fiend, Mama
You always was a black queen, Mama
I finally understand
For a woman, it ain t easy tryin to raise a man
You always was committed
A poor single mother on welfare, tell me how you did it
There s no way I can pay you back
But the plan is to show you that I understand
You are appreciated

[Chorus: Reggie Green & Sweet Franklin, 2Pac]
Lady, don t you know we love ya? (Dear Mama)
Sweet lady, place no one above ya (You are appreciated)
Sweet lady, don t you know we love ya?

[Verse 2]
Now, ain t nobody tell us it was fair
No love for my daddy, cause the coward wasn t there
He passed away and I didn t cry
Cause my anger wouldn t let me feel for a stranger
They say I m wrong and I m heartless, but all along
I was lookin  for a father, he was gone
I hung around with the thugs, and even though they sold drugs
They showed a young brother love
I moved out and started really hangin
I needed money of my own, so I started slangin
I ain t guilty, cause even though I sell rocks
It feels good puttin money in your mailbox
I love payin rent when the rent is due
I hope you got the diamond necklace that I sent to you
Cause when I was low you was there for me
You never left me alone, because you cared for me
And I could see you comin  home after work late
You re in the kitchen, tryin to fix us a hotplate
You just workin with the scraps you was given
And Mama made miracles every Thanksgivin
But now the road got rough, you re alone
You re tryin to raise two bad kids on your own
And there s no way I can pay you back
But my plan is to show you that I understand
You are appreciated


[Chorus: Reggie Green & Sweet Franklin, 2Pac]
Lady, don t you know we love ya? (Dear Mama)
Sweet lady, place no one above ya (You are appreciated)
Sweet lady, don t you know we love ya?

[Verse 3]
Pour out some liquor and I reminisce
Cause through the drama, I can always depend on my mama
And when it seems that I m hopeless
You say the words that can get me back in focus
When I was sick as a little kid
To keep me happy there s no limit to the things you did
And all my childhood memories
Are full of all the sweet things you did for me
And even though I act crazy
I gotta thank the Lord that you made me
There are no words that can express how I feel
You never kept a secret, always stayed real
And I appreciate how you raised me
And all the extra love that you gave me
I wish I could take the pain away
If you can make it through the night, there s a brighter day
Everything will be alright if you hold on
It s a struggle every day, gotta roll on
And there s no way I can pay you back
But my plan is to show you that I understand
You are appreciated


[Chorus: Reggie Green & Sweet Franklin, 2Pac]
Lady, don t you know we love ya? (Dear Mama)
Sweet lady, place no one above ya (You are appreciated)
Sweet lady, don t you know we love ya? (Dear Mama)
Sweet lady, lady (Dear Mama)
Lady, lady'),




(5, 'I Can', 7,
'[Intro: Children s Choir]
I know I can
Be what I wanna be
If I work hard at it
Ill be where I wanna be
I know I can (I know I can)
Be what I wanna be (Be what I wanna be)
If I work hard at it (If I work hard at it)
I ll be where I wanna be (I ll be where I wanna be)

[Verse 1]
Be, b-boys and girls, listen up
You can be anything in the world, in God we trust
An architect, doctor, maybe an actress
But nothing comes easy, it takes much practice
Like, I met a woman who s becoming a star
She was very beautiful, leaving people in awe
Singing songs, Lena Horne, but the younger version
Hung with the wrong person, got her strung on that heroin
Cocaine, sniffing up drugs, all in her nose
Could ve died, so young, now looks ugly and old
No fun cause now when she reaches for hugs, people hold they breath
Cause she smells of corrosion and death
Watch the company you keep and the crowd you bring
Cause they came to do drugs and you came to sing
So if you gonna be the best, I ma tell you how
Put your hands in the air, and take the vow

[Chorus]
I know I can (I know I can)
Be what I wanna be (Be what I wanna be)
If I work hard at it (If I work hard at it)
I ll be where I wanna be (I ll be where I wanna be)
I know I can (I know I can)
Be what I wanna be (Be what I wanna be)
If I work hard at it (If I work hard at it)
I ll be where I wanna be (I ll be where I wanna be)
I know I can (I know I can)
Be what I wanna be (Be what I wanna be)
If I work hard at it (If I work hard at it)
I ll be where I wanna be (I ll be where I wanna be)

[Verse 2]
Be, b-boys and girls, listen again
This is for grown-looking girls who s only 10
The ones who watch videos and do what they see
As cute as can be, up in the club with fake ID
Careful, fore you meet a man with HIV
You can host the TV like Oprah Winfrey
Whatever you decide, be careful, some men be
Rapists, so act your age, don t pretend to be
Older than you are, give yourself time to grow
You thinking he can give you wealth, but so
Young boys, you can use a lot of help, you know
You thinking life s all about smoking weed and ice
You don t wanna be my age and can t read and write
Begging different women for a place to sleep at night
Smart boys turn to men and do whatever they wish
If you believe you can achieve, then say it like this


[Chorus x2]
I know I can (I know I can)
Be what I wanna be (Be what I wanna be)
If I work hard at it (If I work hard at it)
I ll be where I wanna be (I ll be where I wanna be)
I know I can (I know I can)
Be what I wanna be (Be what I wanna be)
If I work hard at it (If I work hard at it)
I ll be where I wanna be (I ll be where I wanna be)

[Verse 3]
Be, be-fore we came to this country
We were kings and queens, never porch monkeys
There was empires in Africa called Kush
Timbuktu, where every race came to get books
To learn from black teachers, who taught Greeks and Romans
Asian Arabs and gave them gold, when
Gold was converted to money it all changed
Money then became empowerment for Europeans
The Persian military invaded
They heard about the gold, the teachings, and everything sacred
Africa was almost robbed naked
Slavery was money, so they began making slave ships
Egypt was the place that Alexander the Great went
He was so shocked at the mountains with black faces
Shot up they nose to impose what basically
Still goes on today, you see?
If the truth is told, the youth can grow
They learn to survive until they gain control
Nobody says you have to be gangstas, hoes
Read more, learn more, change the globe
Ghetto children, do your thing
Hold your head up, little man, you re a king
Young princess, when you get your wedding ring
Your man will sing, She s my Queeeeeen


[Chorus]
I know I can (I know I can)
Be what I wanna be (Be what I wanna be)
If I work hard at it (If I work hard at it)
I ll be where I wanna be (I ll be where I wanna be)
I know I can (I know I can)
Be what I wanna be (Be what I wanna be)
If I work hard at it (If I work hard at it)
I ll be where I wanna be (I ll be where I wanna be)

[Outro]
Save the music, y all
Save the music, y all
Save the music, y all
Save the music, y all
Save the music'),






(6, 'How to Love', 12, 
'[Intro]
Cut the music up
A little louder, yeah

[Chorus]
You had a lot of crooks try to steal your heart
Never really had luck, couldn t never figure out
How to love, how to love, mm
You had a lot of moments that didn t last forever
Now you in a corner, tryna put it together
How to love, how to love, mm
For a second you were here (Hey), now you over there (Hey, hey)
It s hard not to stare the way you re moving your body
Like you never had a love (Ayy), never had a love (Ayy)

[Verse 1]
When you was just a youngin, your looks were so precious
But now you re grown up, so fly, it s like a blessin
But you can t have a man look at you for five seconds
Without you being insecure
You never credit yourself, so when you got older
It seems like you came back ten times over
Now you re sittin here in this damn corner
Looking through all your thoughts and looking over your shoulder

[Chorus]
See you had a lot of crooks try to steal your heart
Never really had luck, couldn t never figure out
How to love, how to love, mm
See you had a lot of moments that didn t last forever
Now you in this corner, tryna put it together
How to love, ah, how to love, mm
For a second you were here (Hey), now you over there (Hey)
It s hard not to stare the way you re moving your body (Hey)
Like you never had a love (Ayy), uh, had a love (Ayy)

[Verse 2]
Oh, and you had a lot of dreams that transform to visions
The fact that you saw the world affected all your decisions
But it wasn t your fault, wasn t in your intentions
To be the one here talking to me, be the one listenin, but
But I admire your poppin bottles and dippin
Just as much as you admire bartendin and strippin, baby
So don t be mad, nobody else trippin
You seen a lot of crooks and them crooks still crook

[Chorus]
You see, you had a lot of crooks try to steal your heart
Never really had luck, couldn t never figure out
How to love, how to love, mm
See, you had a lot of moments that didn t last forever
Now you in this corner, tryna put it together
How to love, how to love, oh

[Bridge]
See, I just want you to know
That you deserve the best, you re beautiful (Ayy)
You re beautiful (Ayy), yeah
And I want you to know
You re far from the usual (Ayy), far from the usual (Ayy)

[Chorus]
You see, you had a lot of crooks try to steal your heart
Never really had luck, couldn t never figure out
How to love, how to love, mm
See, you had a lot of moments that didn t last forever
Now you in this corner, tryna put it together
How to love, how to love, mm
See, you had a lot of crooks try to steal your heart
Never really had luck, couldn t never figure out
How to love, how to love, yeah
See, you had a lot of moments that didn t last forever
Now you in this corner, tryna put it together
How to love, how to love, mm '),



(7, 'Hey Mama', 16, 
'[Chorus]
(Hey, Mama, ah, ow)
I wanna scream so loud for you, cause I m so proud of you, and uh
Let me tell you what I m about to do
(Hey, Mama)
I know I act a fool, but I promise you, I m goin  back to school, and
I appreciate what you allowed for me, and I
I just want you to be proud of me
(Hey, Mama)

[Verse 1]
I wanna tell the whole world about a friend of mine
This little light of mine, I m finna let it shine
I m finna take y all back to them better times
I m finna talk about my mama if y all don t mind
I was three years old when you and I moved to the Chi
Late December, harsh winter gave me a cold
You fixed me up something that was good for my soul
Famous homemade chicken soup, can I have another bowl?
You work late nights just to keep on the lights
Mommy got me training wheels so I could keep on my bike
And you would give anything in this world
Michael Jackson leather and a glove, but didn t give me a curl
And you never put no man over me
And I love you for that, mommy, can t you see?
Seven years old, caught you with tears in your eyes
Cause a nigga cheatin, telling you lies, then I started to cry
As we knelt on the kitchen floor
I said, Mommy, I ma love you til you don t hurt no more
And when I m older, you ain t gotta work no more
And I ma get you that mansion that we couldn t afford
See, you re unbreakable, unmistakable
Highly capable lady that s makin loot
A livin legend too, just look at what Heaven do
Sent us an angel, and I thank you, Mama

[Chorus]
(Hey, Mama, ah, ow)
I wanna scream so loud for you, cause I m so proud of you, and uh
Let me tell you what I m about to do
(Hey, Mama)
I know I act a fool, but I promise you, I m goin back to school, and
I appreciate what you allowed for me, and I
I just want you to be proud of me
(Hey, Mama)

[Verse 2]
Forrest Gump mama said, Life is like a box of chocolates
My mama told me, Go to school, get your doctorate
Something to fall back on, you could profit with
But still supported me when I did the opposite
Now I feel like it s things I gotta get
Things I gotta do, just to prove to you
You was getting through, can the choir please
Give me a verse of You Are So Beautiful To Me?
Can t you see, you re like a book of poetry
Maya Angelou, Nikki Giovanni
Turn one page and there s my mommy
Come on, Mommy, just dance wit me
Let the whole world see your dancing feet
Now when I say Hey, y all say, Mama
Now everybody answer me, come on


[Chorus]
(Hey, Mama, ah, ow)
I wanna scream so loud for you, cause I m so proud of you
Let me tell you what I m about to do
(Hey, Mama)
I know I act a fool, but I promise you, I m goin back to school
I appreciate what you allowed for me
I just want you to be proud of me
(Hey, Mama)

[Break]
I guess it also depends though if my ends low
Second they get up, you gon get that Benzo
Tint the windows, ride around the city and let your friends know (Hey, Mama)
Tell your job you gotta fake em out
Since you brought me in this world, let me take you out
To a restaurant, upper echelon
I ma get you a Jag , whatever else you want
Just tell me what kind of S-Type Donda West like?
Tell me the perfect color so I make it just right
It don t gotta be Mother s Day or your birthday
For me to just call and say

[Outro]
(Hey, Mama, ah, ow)
I wanna scream so loud for you, cause I m so proud of you, and uh
Let me tell you what I m about to do
(Hey, Mama)
You know I love you so, and
I never let you go
Wrote this song just so you know
No matter where you go, our love is true
(Hey, Mama)'),






(8, 'Beautiful', 8,
'[Intro: Charlie Wilson & Pharrell Williams]
Oh, oh, oh, oh
Yeah, yeah, yeah, yeah
(Yeah, oh yeah, there s something about you)
Oh, oh, oh, oh
Yeah, yeah, yeah, yeah
(Yeah, oh yeah, there s something about you)

[Chorus: Pharrell Williams]
Beautiful, I just want you to know
You re my favorite girl
(Yeah, oh yeah, there s something about you)
Beautiful, I just want you to know
You re my favorite girl
(Yeah, oh yeah, there s something about you)

[Verse 1: Snoop Dogg]
I know you gon lose it, this new Snoop shit
Come on, baby boo, you gots to get into it
Don t fool with the player with the cool whip
Yeah, yeah, you know I m always on that cool shit
Walk to it, do it how you do it
Have a glass, let me put you in the mood, and
Little cutie, looking like a student
Long hair with your big fat booty
Back in the days, you was a girl I went to school with
Had to tell your moms and sister to cool it
The girl wanna do it, I just might do it
Hit her up with some pimp-pimp fluid
Mommy, don t worry, I won t abuse it
Hurry up and finish so we can watch Clueless
I laugh at these niggas when they ask, Who do this?
But everybody know, ooh, girl, that you is

[Chorus: Pharrell Williams]
Beautiful, I just want you to know
You re my favorite girl
(Yeah, oh yeah, there s something about you)
Beautiful, I just want you to know
You re my favorite girl
(Yeah, oh yeah, there s something about you)

[Verse 2: Snoop Dogg & Pharrell Williams]
When I see my baby boo, shit, I get foolish
Smack a nigga that tries to pursue it
Homeboy, she taken, just move it
I asked you nicely, don t make the Dogg lose it
We just blow drop and keep the flow movin
In a 64, me and baby boo cruisin
Body rag interior blue, and
Have them hydraulics squeakin  when we screwin
Now she s yellin , hollerin out Snoop! and
Hootin , hollerin ; hollerin , hootin
Black and beautiful, you the one I m choosin
Hair long, thin, black and curly like you re Cuban
Keep groovin , that s what we doin
And we gon be together until your moms move in
(Yeah, oh yeah, there s something about you)

[Chorus: Pharrell Williams]
Beautiful, I just want you to know
You re my favorite girl
(Yeah, oh yeah, there s something about you)
Beautiful, I just want you to know
You re my favorite girl
(Yeah, oh yeah, there s something about you)

[Post-Chorus: Charlie Wilson & Pharrell Williams]
See, I just want you
To know that you are really special
(Yeah, oh yeah, there s something about you)
Oh my, oh my, oh my, oh my
See, I just want you
To know that you are really special
(Yeah, oh yeah, there s something about you)
Oh my, oh my, oh my, oh my
(Yeah, oh yeah, there s something about you)

[Verse 3: Snoop Dogg & Pharrell Williams]
Snoop Dogg Clothing, that s what I m groomed in
You got my pictures on the wall in your room, and
Girls be complaining you keep me boomin
But girls like that wanna listen to Pat Boone
(Yeah, oh yeah, there s something about you)
You s a college girl, but that don t stop you from doin
Come and see the Dogg in a hood near you, and
You don t ask why I roll with a crew, and
Twist up my fingers, and wear dark blue, and
(Yeah, oh yeah, there s something about you)
On the Eastside, that s the crew I choose
Nothing I do is new to you
I smack up the world if they rude to you
Cause baby girl, you re so beautiful

[Chorus: Pharrell Williams]
Beautiful, I just want you to know
You re my favorite girl
Beautiful, I just want you to know
You re my favorite girl

[Post-Chorus: Charlie Wilson & Pharrell Williams]
See, I just want you
To know that you are really special
(Yeah, oh yeah, there s something about you)
Oh my, oh my, oh my, oh my
See, I just want you
To know that you are really special
(Yeah, oh yeah, there s something about you)
Oh my, oh my, oh my, oh my
See, I just want you
To know that you are really special
(Yeah, oh yeah, there s something about you)
Oh my, oh my, oh my, oh my
I just want you
To know that you are really special
(Yeah, oh yeah, there s something about you)
Oh my, oh my, oh my, oh my

[Outro: Pharrell Williams]
Ehh... oh yeah, there s something about you... Oh-hooo!
Ehh... oh yeah, there s something about you... Oh-hooo!
Ehh... oh yeah, there s something about you... Oh-hooo!'),




(9, 'Find Your Love', 13, 
'[Verse 1]
I m more than just an option (Hey, hey, hey)
Refuse to be forgotten (Hey, hey, hey)
I took a chance with my heart (Hey, hey, hey)
And I feel it taking over

[Chorus]
I better find your loving, I better find your heart
I better find your loving, I better find your heart
I better find your loving, I better find your heart
I bet if I give all my love then nothing s gonna tear us apart

[Verse 2]
I m more than just a number (Hey, hey, hey)
I doubt you ll find another (Hey, hey, hey)
So every single summer (Hey, hey, hey)
I ll be the one that you ll remember and

[Chorus]
I better find your loving, I better find your heart
I better find your loving, I better find your heart
I better find your loving, I better find your heart
I bet if I give all my love then nothing s gonna tear us apart

[Verse 3]
It s more than just a mission (Hey, hey, hey)
You hear, but you don t listen (Hey, hey, hey)
You better pay attention (Hey, hey, hey)
And get what you ve been missing

[Chorus]
I better find your loving, I better find your heart
I better find your loving, I better find your heart
I better find your loving, I better find your heart
I bet if I give all my love then nothing s gonna tear us apart

[Bridge]
Too many times I ve been wrong
I guess being right takes too long
I m done waiting, there s nothing left to do
But give all I have to you and

[Chorus]
I better find your loving, I better find your heart
I better find your loving
I bet if I give all my love then nothing s gonna tear us apart
I bet if I give all my love then nothing s gonna tear us apart'),




(10, 'Fly', 5, 
'[Chorus: Rihanna]
I came to win, to fight
To conquer, to thrive
I came to win (J.R.), to survive
To prosper, to rise
To fly
To fly

[Verse 1: Nicki Minaj]
Uh, yo, yo
I wish today it would rain all day
Maybe that d kinda make the pain go away
Tryna forgive you for abandoning me
Prayin , but I think I m still an angel away
Angel away, yeah, it s strange in a way
Maybe that is why I chase strangers away
They got they guns out aimin at me
But I become Neo when they aimin at me
Me, me, me against them
Me against enemies, me against friends
Somehow, they both seem to become one
A sea full of sharks and they all smell blood
They start comin and I start risin
Must be surprisin , I m just surmisin
I win, thrive, soar, higher
Higher, higher, more fire


[Chorus: Rihanna]
I came to win, to fight
To conquer, to thrive
I came to win, to survive
To prosper, to rise
To fly
To fly

[Verse 2: Nicki Minaj]
Uh, yo, yo
Everybody wanna try to box me in
Suffocatin  every time it locks me in
Paintin they own pictures, then they crop me in
But I will remain where the top begins
Cause I am not a word, I am not a line
I am not a girl that could ever be defined
I am not fly, I am levitation
I represent an entire generation
I hear the criticism loud and clear
That is how I know that the time is near
See we become alive in the time of fear
And I ain t got no motherfuckin time to spare
Cry my eyes out for days upon days
Such a heavy burden placed upon me
But when you go hard, your nays become yays
Yankee stadium with Jays and Kanyes


[Chorus: Rihanna]
I came to win, to fight
To conquer, to thrive
I came to win, to survive
To prosper, to rise
To fly
To fly

[Bridge: Nicki Minaj]
Get ready for it
Get ready for it
Get ready for it
I came to win
Get ready for it
Get ready for it
Get ready for it

[Chorus: Rihanna]
I came to win, to fight
To conquer, to thrive
I came to win, to survive
To prosper, to rise
To fly
To fly');


-- Show the output of your database by joining all of the three tables together
SELECT 
    Artist.artistId,
    Artist.artistName,
    Artist.genre,
    Album.albumId,
    Album.albumTitle,
    Album.albumReleaseYear,
    Lyrics.lyricsId,
    Lyrics.songTitle,
    Lyrics.trackNumber,
    Lyrics.lyricsDisplay
FROM 
    Artist
JOIN 
    Album ON Artist.artistId = Album.artistId
JOIN 
    Lyrics ON Album.albumId = Lyrics.albumId;



 -- Export your entire musicdb environment as a self-contained .sql export file and submit to the project
/* switch into into java mode to export data */
util.dumpSchemas(["musicdb_senatus"], "./musicdb_senatus_backup.sql");


