BEGIN{
    section=0
    level=0
    skip=0
    container=(container=="")? "kubespray" : container
}

/.*required_providers.*/{
    section=1
}

/.*{.*/{
    if (section){
        level=level+1
    }
}

/.*}.*/{
    if (section){
        level=level-1
    }
    if(skip){
        skip=0
        next
    }
}

/.*backend "swift".*/{
    skip=1
}

{
    if(!skip){
        print $0
    }
    if(section && level==0){
        section=0
        print "  backend \"swift\" {"
        print "    container = \""container"\""
        print "  }"
    }
}
