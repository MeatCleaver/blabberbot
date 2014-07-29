require 'rubygems'
require 'selenium-webdriver'

$sub = "/r/worldnews" #put your sub here

$driver = Selenium::WebDriver.for :chrome
print "Opened Chrome\n"

$website = "http://www.reddit.com"
$driver.get ($website + $sub)
print "Connecting to reddit\n"

puts "Page title is #{$driver.title}\n"

sleep(2); 

#login click
$login = $driver.find_elements(:class ,"login-required");
$login[0].click();

sleep(2);

#username entry
$user_login = $driver.find_element(:id, "user_login");
$user_login.send_keys(""); #your username goes here
$passwd_login = $driver.find_element(:id, "passwd_login");
$passwd_login.send_keys("") #your password goes here
sleep(1);

#click submit
$submit_login = $driver.find_elements(:class, "button");
$submit_login[1].click();
sleep(3);

$time = Time.new
while $time.month != 8 
	#new click
	$choices = $driver.find_elements(:class, "choice");

	$choices.each do |e|
		$text = e.text
		if($text=="new")
			print "In new \n"
			e.click;
			break;
		end
	end

	sleep(2);

	$comments = $driver.find_elements(:class, "comments");
	$replies = IO.readlines("./replies.json")

	$comments[rand($comments.length-1)].click;

	sleep(2);

	#write comment
	$commentboxes = $driver.find_elements(:tag_name, "textarea");
	$commentboxes.each do |e|
		$name = e.attribute('name');
		if($name=="text")
			e.send_keys($replies[$replies.length-1]);	
			break;
		end
	end

	sleep(1)	
	#save
	$save = $driver.find_element(:class, "save");
	$save.click();
	print "Posted Comment \n"

	sleep(450);
	$driver.get ($website + $sub)
	sleep(rand(200));
	$time = Time.new;
end


$driver.close;
















