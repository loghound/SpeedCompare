
One of the niftier things in Snow Leopard are blocks -- It's a way to encapsulate a bit of code and pass it around to do useful things.

I won't go into the hairy details but suffice to say it lets you do some interesting design.  Recently I was faced with the problem of looking through a 'large (30,000+) array of strings to find matchess.  The simple 'containsObject' feature of NSArray was "ok" but slows down as the size increases.

As an experiment I thought to write a version that use blocks and concurrent searching.  NSArray has a enumerateObjectsWithOptions:usingBlock: method that exactly fit the bill.

So... replace:

    foundIt=[self.items containsObject:itemToFind]


with 

    [self.items enumerateObjectsWithOptions:NSEnumerationConcurrent
    usingBlock:^(id s,NSUInteger idx,BOOL *stop){
    
       if ([(NSString*)s isEqual:itemToFind]) {
       foundIt=TRUE;
       *stop=TRUE;
       }
    return;  
    }]; 

The results? I tried 4 experiments for a variety of sizes.

In every case the blocks version was faster for ~8000 elements or more (below 8000, the startup costs of blocks are too much) -- These results are on a 8 core mac pro so it's possible it could be worse on a dual core machine but the result would be the same -- at some point there the blocks version will win.



![chart comparison](https://spreadsheets.google.com/oimg?key=0AmmRIsKpMJd7dExPcXl1R3ltTGlWOEdRUG1Ka3YwaGc&oid=2&zx=stqr2k-ilv811)


[Link to the spreadsheet with detailed results:](https://spreadsheets.google.com/pub?key=0AmmRIsKpMJd7dExPcXl1R3ltTGlWOEdRUG1Ka3YwaGc&hl=en&output=html)
