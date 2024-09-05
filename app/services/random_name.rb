class RandomName
  FIRST_NAMES = %w[Liam Olivia Noah Emma Oliver Ava Elijah Charlotte William Sophia James Amelia Benjamin Isabella
    Lucas Mia Henry Evelyn Alexander Harper Mason Camila Michael Gianna Ethan Abigail Daniel Luna Jacob Ella Logan
    Elizabeth Jackson Sofia Sebastian Emily Jack Avery Aiden Mila Owen Scarlett Samuel Eleanor Matthew Madison Joseph
    Layla Levi Penelope Mateo Aria David Chloe John Grace Wyatt Ellie Carter Nora Julian Hazel Luke Zoey Grayson Riley
    Isaac Victoria Jayden Lily Theodore Aurora Gabriel Violet Anthony Nova Dylan Hannah Leo Emilia Lincoln Zoe Jaxon
    Stella Asher Everly Christopher Isla Josiah Leah Andrew Lillian Thomas Addison Joshua Willow Ezra Lucy Hudson
    Paisley Charles Natalie Caleb Naomi Isaiah Eliana Ryan Brooklyn Nathan Elena Adrian Aubrey Christian Claire Maverick
    Ivy Colton Kinsley Elias Audrey Aaron Maya Eli Genesis Landon Skylar Jonathan Bella Nolan Aaliyah Hunter Madelyn
    Cameron Savannah Connor Anna Santiago Delilah Jeremiah Serenity Ezekiel Caroline Angel Kennedy Roman Valentina
    Easton Ruby Miles Sophie Robert Alice Jameson Gabriella Nicholas Sadie Greyson Ariana Cooper Allison Ian Hailey
    Carson Autumn Axel Nevaeh Jaxson Natalia Dominic Quinn Leonardo Josephine Luca Samantha Austin Leilani Jordan
    Everleigh Adam Madeline Xavier Lydia Jose Peyton Jace Kaylee Everett Jade Declan Cora Evan Bailey Kayden Brielle
    Parker Adriana Wesley Ryleigh Kai Arianna Brayden Finley Bryson Amara Weston Harmony Jason Amy Emmett Aubree Sawyer
    Fallon Silas Giselle Bennett Hadley Brooks Juniper Micah Lilith Damian Melody Harrison Ainsley Waylon Kylie Ayden
    Emery Vincent Amira
  ]

  def self.generate
    "#{FIRST_NAMES.sample}"
  end
end