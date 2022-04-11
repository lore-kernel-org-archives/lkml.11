Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAEBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 22:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348181AbiDKWY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 18:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350461AbiDKWYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:24:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175E310FCB;
        Mon, 11 Apr 2022 15:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649715743; x=1681251743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oXXoBWTt1Xe5PEiUAYw2pYMljxLFcnpZnLwQ3WTj6sw=;
  b=kPl84TItKpioIO7FoLBe1Nn0rhAxL5NuB0nYhZE45Kr78eHF/xYsIdcd
   j2tcYlFbllUGVxA5EJ8bIUmrFe927M1TirGT5rpt+JQKlnR8QFIy6b3Z0
   1Ua8qZCv1RpDi8mp+zG5wVqcDR/3B51faij1aJ5ZFHPtZ0YeGwgXvUxYq
   0YNtlFGn837VU9LSTdgY+bAsmxbYX7YCQ3SnEPZfWKZNbZh98F7hIzSpr
   CM575xyUCZlPV/RqY8bYCesJxIrNtDjbLTdFoOQVwLMlWdwbAbwo3VxA5
   7enMe8I6VancJWYvKSnPG6F/i3hNI23jaMkZiRrhCSaiDH987O4lhp5K0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="325139667"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="325139667"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 15:22:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="507292101"
Received: from lvnguyen-mobl2.amr.corp.intel.com (HELO localhost) ([10.213.163.243])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 15:22:22 -0700
Date:   Mon, 11 Apr 2022 15:22:21 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        peterz@infradead.org
Subject: Re: [PATCH] Documentation/vm: Extend "Temporary Virtual Mappings" in
 highmem.rst
Message-ID: <YlSqHf8Kv23iNp0E@iweiny-desk3>
References: <20220409184907.25122-1-fmdefrancesco@gmail.com>
 <YlJNI7c9pwq5R0RB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlJNI7c9pwq5R0RB@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 04:21:07AM +0100, Matthew Wilcox wrote:
> On Sat, Apr 09, 2022 at 08:49:07PM +0200, Fabio M. De Francesco wrote:
> > @@ -52,25 +52,65 @@ Temporary Virtual Mappings
> >  
> >  The kernel contains several ways of creating temporary mappings:
> >  
> > -* vmap().  This can be used to make a long duration mapping of multiple
> > -  physical pages into a contiguous virtual space.  It needs global
> > -  synchronization to unmap.
> > +* vmap().  This can be used to make a long duration mapping of multiple physical
> > +  pages into a contiguous virtual space. It needs global synchronization to unmap.
> 
> Did you change any words here?  If so, I can't see them.  Please don't
> gratuitously reformat paragraphs; it obscures the real changes.  Also,
> 75 characters is a good limit for line length, and you're well past
> that.  If in doubt, use `fmt`.
> 
> > -* kmap().  This permits a short duration mapping of a single page.  It needs
> > -  global synchronization, but is amortized somewhat.  It is also prone to
> > -  deadlocks when using in a nested fashion, and so it is not recommended for
> > -  new code.
> > +* kmap().  This can be used to make long duration mapping of a single page with
> 
> kmap() really isn't for long duration.  But the pointer returned from
> kmap() is valid across all CPUs, unlike kmap_local() or kmap_atomic().

I think the problem is in how kmap() is being used now for the long duration
maps in a couple of places.

That said, I agree with Matt that we should not document this fact.  Rather we
should steer people away from making use of kmap() at all.

That said if kmap() goes away what replaces it in the areas of the code which
require a long term access to a VA?

The addition of PKS like protections on the direct map complicate this.

[snip]

> > +
> > +* kmap_local_*().  These provide a set of functions similar to kmap_atomic() and
> > +  are used to require short term mappings. They can be invoked from any context
> > +  (including interrupts).
> > +
> > +  The mapping can only be used in the context which acquired it, it is per thread,
> > +  CPU local (i.e., migration from one CPU to another is disabled - this is why
> > +  they are called "local"), but they don't disable preemption. It's valid to take
> > +  pagefaults in a local kmap region, unless the context in which the local mapping
> > +  is acquired does not allow it for other reasons.
> > +
> > +  If a task holding local kmaps is preempted, the maps are removed on context
> > +  switch and restored when the task comes back on the CPU. As the maps are strictly
> > +  CPU local, it is guaranteed that the task stays on the CPU and that the CPU
> > +  cannot be unplugged until the local kmaps are released.
> > +
> > +  Nesting kmap_local.*() and kmap_atomic.*() mappings is allowed to a certain
> > +  extent (up to KMAP_TYPE_NR). Nested kmap_local.*() and kunmap_local.*()
> > +  invocations have to be strictly ordered because the map implementation is stack
> > +  based.
> 
> I think the original layout of all this is flawed.  We should start by
> describing the interface we want people to use first -- kmap_local*(),
> then say "But if you can't use that, there's kmap_atomic()" and "If
> you can't use kmap_atomic(), you can use kmap()".

...  If, and only if, one absolutely has to use kmap(), then ok...

Ira
